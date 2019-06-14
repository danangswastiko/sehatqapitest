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

        if xusername == "" || xpwd =="" || xusername.nil?  || xpwd.nil? || xname == "" || xaddress == "" ||
           xphone == "" || xdob == "" || xname.nil? || xaddress.nil? || xphone.nil? || xdob.nil?
            render json: [status:"ERROR", message: "Username,Pwd, name, address, phone and dob Cannot be empty !"]
        else
            @user = Muser.createnewuser(xusername,xpwd,xuidoapp,xflagoapp)
            xuid = @user.userid
            @userprofile = Muserprofile.createnewuserprofile(xuid,xname,xaddress,xphone,xdob)
            if ! @user.nil?
                render json: [status: "OK", message: "Registration New User Success"]
            else
                render json: [status: "ERROR", message: @user.errors]
            end
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

    def userprofile
        xuid = user_profile[:uid]
        xtoken = user_profile[:token]
        if xuid == "" || xtoken =="" || xuid.nil?  || xtoken.nil? 
            render json: [status:"ERROR", message: "userid and token cannot be empty !"]
            return
        end
        @user = Muser.checktoken(xuid, xtoken)
        if ! @user.nil? && ! @user.empty?
            @userprofile = Muserprofile.getprofile (xuid)
            render json: [status:"OK", message: @userprofile]
        else
            render json: [status:"ERROR", message: "Invalid Token"]
        end
    end

    private
	def user_newuser
		params.require(:newuser).permit(:un, :pwd, :uidoapp, :flagoapp, :name, :address, :phone, :dob)
    end
    def user_login
        params.require(:userlogin).permit(:un, :pwd)
    end
    def user_profile
        params.require(:userprofile).permit(:uid, :token)
    end
end
