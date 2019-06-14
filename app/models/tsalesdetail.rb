class Tsalesdetail < ActiveRecord::Base
    self.table_name = "t_salesdetail"
    def self.newpurchasedetail(tranno, prodid, qty, price, uid)
        @sd = Tsalesdetail.new
        @sd.sd_tranno = tranno
        @sd.sd_prodid = prodid
        @sd.sd_qty = qty
        @sd.sd_price = price
        @sd.sd_totprice = qty.to_i * price.to_i
        @sd.sd_activeyn = 'Y'
        @sd.sd_updateid = uid
        @sd.sd_lastupdate = Time.now
        @sd.save
        return @sd
    end
end