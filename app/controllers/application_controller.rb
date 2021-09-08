class ApplicationController < ActionController::Base
 before_action :authenticate_user!,except: [:top, :about]

 before_action :configure_permitted_parameters, if: :devise_controller?

#サインイン後のページの遷移先
def after_sign_in_path_for(resource)
  user_path(current_user.id)
end

 protected

 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email])
    #nameをキーにしてあげることでemailの設定がキーから外れてデータの送信がうまくいかなくなるためストロングパラメーターを設定する必要がある
    #　config.authentication_keys = [:name]で指定したカラムはストロングパラメーターに設定する必要がない
 end


end
