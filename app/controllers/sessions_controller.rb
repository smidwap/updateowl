class SessionsController < Devise::SessionsController
   def create
      resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure") 
      sign_in(resource_name, resource)
      respond_to do |format|
         format.html { redirect_to root_path }
         format.extension
      end
   end

   def failure
      respond_to do |format|
         format.html { render :new }
         format.extension {
            flash[:error] = "We didn't recognize your email or password. Please try again."
         }
      end
   end
end