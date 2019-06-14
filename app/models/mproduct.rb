class Mproduct < ActiveRecord::Base
    self.table_name = "m_product"
    self.primary_key = "prodid"

    def self.getallproduct()
        @allproduct = Mproduct.where("activeyn = 'Y'")
                              .select("prodid,prodname,qty,price")
        return @allproduct
    end
    def self.productbyname(prodname)
        @product = Mproduct.where("prodname like '%#{prodname}%' and activeyn = 'Y'" )
                           .select("prodid,prodname,qty,price")
        return @product
    end
end