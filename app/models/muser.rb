class Muser < ActiveRecord::Base
    self.table_name = "m_user"
    self.primary_key = "userid"

    def self.createnewuser(un,pwd,uidoapp = '',flagoapp = '')
        require 'securerandom'
        require 'digest'

        xtoken = SecureRandom.hex
        xpasscode = Digest::MD5.hexdigest(pwd)

        @maxuserid = Muser.select("COALESCE(max(userid),0) userid")
        maxuserid_max = @maxuserid.first.userid + 1
      
        @user = Muser.new
        @user.userid = maxuserid_max
        @user.username = un
        @user.password = xpasscode
        @user.useridoapp = uidoapp 
        @user.flagoapp = flagoapp
        @user.token = xtoken
        @user.activeyn = 'Y'
        @user.updateid = 0
        @user.lastupdate = Time.now
        @user.save
        return @user 
    end

    def self.checkuser(un,pwd)
        require 'digest'
        xpasscode = Digest::MD5.hexdigest(pwd)

        @usercheck = Muser.where("username = '#{un}' and password = '#{xpasscode}'")
        return @usercheck
    end

    def sellf.checktoken(uid,token)
        @usercheck = Muser.where("uid = #{uid} and password = '#{token}'")
        return @usercheck
    end
end