class Api::V1::TokensController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    email = params[:email]
    password = params[:password]
    
    if request.format != :json
      render :status=>406, :json=>{:message=>"The request must be json"}
      return
    end

    if email.nil? or password.nil?
      render :status=>400, :json=>{:message=>"The request must contain the user email and password."}
      return
    end

    @user=User.find_by_email(email.downcase)

    if @user.nil?
      render :status=>401, :json=>{:message=>"Invalid email or passoword."}
      return
    end
    
    @user.ensure_authentication_token!

    if not @user.valid_password?(password)
      render :status=>401, :json=>{:message=>"Invalid email or password."}
    else
      render :status=>200, :json=>{:token=>@user.authentication_token}
    end
  end

  def destroy
  end
end
