class ProductController < ActionController::API
    def allproduct
        xuid = product_allprod[:uid]
        xtoken = product_allprod[:token]
        if xuid == "" || xtoken =="" || xuid.nil?  || xtoken.nil? 
            render json: [status:"ERROR", message: "userid and token cannot be empty !"]
            return
        end
        @user = Muser.checktoken(xuid, xtoken)
        if ! @user.nil? && ! @user.empty?
            @product = Mproduct.getallproduct
            render json: [status:"OK", message: @product]
        else
            render json: [status:"ERROR", message: "Invalid Token"]
        end
    end

    def prodbyname
        xuid = product_prodbyname[:uid]
        xtoken = product_prodbyname[:token]
        xprodname = product_prodbyname[:prodname]

        if xuid == "" || xtoken =="" || xuid.nil?  || xtoken.nil? 
            render json: [status:"ERROR", message: "userid and token cannot be empty !"]
            return
        end
        @user = Muser.checktoken(xuid, xtoken)
        if ! @user.nil? && ! @user.empty?
            @product = Mproduct.productbyname(xprodname)
            render json: [status:"OK", message: @product]
        else
            render json: [status:"ERROR", message: "Invalid Token"]
        end
    end
    private
	def product_allprod
		params.require(:allprod).permit(:uid, :token)
    end
    def product_prodbyname
        params.require(:prodbyname).permit(:uid, :token, :prodname)
    end
end