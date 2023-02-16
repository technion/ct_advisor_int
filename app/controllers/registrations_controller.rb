class RegistrationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :id_not_found
  BLACKLIST = ["cloudflaressl.com", "facebook.com"]

  def new
    @registration = Registration.new
  end

  def unsub
    @registration = Registration.new
  end

  def unsub_send
    @registration = Registration.find_by(:domain =>
      params[:registration][:domain].downcase)
    if @registration && (@registration.email == 
        params[:registration][:email].downcase)
      @status = "Unsubscribe email sent."
      EmailAlert.unsubscribe(@registration).deliver_later
    else
      @status = "Account not found"
    end
    render "status"
      
  end

  def create
    # Shutdown process - creating a sign up no longer available
    @status = "Registrations are disabled"
    render "status"
    return

    # Original workflow
    @registration = Registration.new(registration_params)
    @registration.set_nonce
    @registration.active = 0
    unless verify_recaptcha(model: @registration)
      @status = "Captcha incorrectly entered"
      render "status"
      return
    end

    unless verify_domain(@registration.domain)
      @status = "Entered domain is not valid"
      render "status"
      return
    end

    if @registration.save
      EmailAlert.activate(@registration).deliver_later
      @status = "Please check your email"
    else
      @status = "Domain is already registered"
    end
    render "status"
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
      @registration.set_nonce
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

  def verify_domain(domain)
    return false unless PublicSuffix.valid?(domain)
    domain = PublicSuffix.parse(domain)
    return false unless domain.domain
    return false if BLACKLIST.include?(domain.domain)

    true
  end
end
