class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 全てのアクションが行われる前にここが読み込まれる。以下のメソッドを呼ぶ

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  # これはストロングパラメータと同意味。サインアップ時に入力された「name」キーの保存を許可。
end
