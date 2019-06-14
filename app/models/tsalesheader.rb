class Tsalesheader < ActiveRecord::Base
    self.table_name = "t_salesheader"
    self.primary_key = "sh_tranno"

    def self.newpurchase(uid,totprice)
        snow = Time.now
        @salesheader = Tsalesheader.new
        @salesheader.sh_tranno = snow.strftime("%Y%m%d%H%M%S")
        @salesheader.sh_trandate = Time.now
        @salesheader.sh_userid = uid
        @salesheader.sh_totprice = totprice
        @salesheader.sh_activeyn = 'Y'
        @salesheader.sh_updateid = uid
        @salesheader.sh_lastupdate = Time.now
        @salesheader.save
        return @salesheader
    end

    def self.gethistperuid(uid)
        @histsales = Tsalesheader.where("sh_userid = #{uid}")
                                 .joins("left join t_salesdetail on sd_tranno = sh_tranno
                                         left join m_product on prodid = sd_prodid
                                         left join m_user_profile on userprofileid = sh_userid")
                                 .select("name,sh_tranno,sh_trandate,sd_prodid,prodname,sd_qty,sd_totprice")
        return @histsales
    end
end