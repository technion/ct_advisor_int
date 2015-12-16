class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def unsub
    @registration = Registration.new
  end

  def unsub_send
    @registration = Registration.find_by(:domain => params[:registration][:domain])
    @status = "ID #{@registration.id} and nonce #{@registration.nonce}"
    render "status"
      
  end

  def create
    @registration = Registration.new(registration_params)
    @registration.nonce = SecureRandom.urlsafe_base64
    @registration.active = 0
    @registration.save
  end

  def destroy_form
    @registration = Registration.find(params[:id])
    if @registration.nonce == params[:nonce]
      @status = "user is valid"
    else
      @status = "Not valid"
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    if @registration.nonce == params[:nonce]
      @status = "user is valid and now deleted"
      @registration.destroy!
    else
      @status = "Not valid"
    end
    render "status"
  end

  def verify
    @registration = Registration.find(params[:id])
    if @registration.nonce == params[:nonce]
      @pass = "user is valid"
    else
      @pass = "Not valid"
    end
  end

  def verify_activate
    @registration = Registration.find(params[:id])
    if @registration.nonce == params[:nonce]
      @status = "user is valid"
      @registration.active = 1
      @registration.nonce = SecureRandom.urlsafe_base64
      @registration.save
    else
      @status = "Not valid"
    end
    render "status"
  end

  private
  def registration_params
    params.require(:registration).permit(:email, :domain)
  end
end
