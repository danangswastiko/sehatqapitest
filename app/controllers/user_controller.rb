class UserController < ActionController::API
    def registration
        xusername =user_newuser[:un]
        xpwd = user_newuser[:pwd]
        xuidoapp = user_newuser[:uidoapp]
        xflagoapp = user_newuser[:flagoapp]
        xname = user_newuser[:name]
        xaddress = user_newuser[:address]
        xphone = user_newuser[:phone]
        xdob = user_newuser[:dob]

        @user = Muser.createnewuser(xusername,xpwd,xuidoapp,xflagoapp)
        xuid = @user.userid
        @userprofile = Muserprofile.createnewuserprofile(xuid,xname,xaddress,xphone,xdob)
        if ! @user.nil?
            render json: [status: "OK", message: "Registration New User Success"]
        else
            render json: [status: "ERROR", message: @user.errors]
        end
        
    end

    def login
        xusername = user_login[:un]
        xpwd = user_login[:pwd]
        if xusername == "" || xpwd =="" || xusername.nil?  || xpwd.nil? 
            render json: [status:"ERROR", message: "Username and Pwd Cannot be empty !"]
        else
            @user = Muser.checkuser(xusername,xpwd)
            if ! @user.nil? && ! @user.empty?
                render json: [status:"OK", message: @user]
            else
                render json: [status:"ERROR", message: "Unidentified User"]
            end
        end
    end

    private
	def user_newuser
		params.require(:newuser).permit(:un, :pwd, :uidoapp, :flagoapp, :name, :address, :phone, :dob)
    end
    def user_login
        params.require(:userlogin).permit(:un, :pwd)
    end
end
