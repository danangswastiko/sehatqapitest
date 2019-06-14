class Muserprofile < ActiveRecord::Base
    self.table_name = "m_user_profile"
    self.primary_key = "userprofileid"

    def self.createnewuserprofile(uid,name = '',address = '',phone = '',dob = '')      
        @user = Muserprofile.new
        @user.userprofileid = uid
        @user.name = name
        @user.address = address
        @user.phonenumber = phone 
        @user.dob = dob
        @user.activeyn = 'Y'
        @user.updateid = 0
        @user.lastupdate = Time.now
        @user.save
        return @user 
    end

    def self.getprofile(uid)
        @userprofile = Muserprofile.where("userprofileid = #{uid}")
                                   .select("userprofileid,name,address,phonenumber,dob")
        return @userprofile 
    end
end