class RegistrationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :id_not_found
  def new
    @registration = Registration.new
  end

  def unsub
    @registration = Registration.new
  end

  def unsub_send
    @registration = Registration.find_by(:domain =>
      params[:registration][:domain].downcase)
    @status = "Unsubscribe email sent."
    render "status"
      
  end

  def create
    @registration = Registration.new(registration_params)
    @registraiton.set_nonce
    @registration.active = 0
    @registration.save
  end

  def destroy_form
    @registration = Registration.find(params[:id])
    if @registration.nonce == params[:nonce]
      @status = "Click to confirm unsubscribe"
    else
      @status = "Nonce is invalid"
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    if @registration.nonce == params[:nonce]
      @status = "Registration removal confirmed"
      @registration.destroy!
    else
      @status = "Nonce is invalid"
    end
    render "status"
  end

  def verify
    @registration = Registration.find(params[:id])
    unless @registration.nonce == params[:nonce]
      @status = "Nonce not valid"
      render "status"
    end
  end

  def verify_activate
    @registration = Registration.find(params[:id])
    if @registration.nonce == params[:nonce]
      @status = "User has been verified."
      @registration.active = 1
      @registration.nonce = SecureRandom.urlsafe_base64
      @registration.save
    else
      @status = "Nonce not valid"
    end
    render "status"
  end

  private
  def registration_params
    params.require(:registration).permit(:email, :domain)
  end

  def id_not_found
    @status = "ID not found"
    render "status"
  end
end
