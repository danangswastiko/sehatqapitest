class PurchaseController < ActionController::API
    def createsales
        xuid = purchase_newsales[:uid]
        xtoken = purchase_newsales[:token]
        xtotprice = purchase_newsales[:totprice]
        @detailsales = params[:createsales][:detailsales]

        if xuid == "" || xtoken =="" || xuid.nil?  || xtoken.nil? 
            render json: [status:"ERROR", message: "userid and token cannot be empty !"]
            return
        end

        if @detailsales.empty? || @detailsales.nil?
            render json: [status:"ERROR", message: "No Detail Data"]
        else
            @user = Muser.checktoken(xuid, xtoken)
            if ! @user.nil? && ! @user.empty?
                @sh = Tsalesheader.newpurchase(xuid,xtotprice)
                xtranno = @sh.sh_tranno
                @detailsales.each do |sd|
                    @sd = Tsalesdetail.newpurchasedetail(xtranno, sd["prodid"], sd["qty"], sd["price"], xuid)
                end
                render json: @sd
            else
                render json: [status:"ERROR", message: "Invalid Token"]
            end
        end
    end

    def historysales
        xuid = purchase_hist[:uid]
        xtoken = purchase_hist[:token]

        if xuid == "" || xtoken =="" || xuid.nil?  || xtoken.nil? 
            render json: [status:"ERROR", message: "userid and token cannot be empty !"]
            return
        end
        @user = Muser.checktoken(xuid, xtoken)
        if ! @user.nil? && ! @user.empty?
            @saleshist = Tsalesheader.gethistperuid(xuid)
            render json: [status:"OK", message: @saleshist]
        else
            render json: [status:"ERROR", message: "Invalid Token"]
        end
    end

    private
	def purchase_newsales
		params.require(:createsales).permit(:uid, :token, :totprice, :detailsales)
    end
    def purchase_hist
        params.require(:histsales).permit(:uid, :token)
    end
end