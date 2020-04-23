class Credible::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  skip_before_action :authenticate!, only: [:new, :create, :confirm]

  # TODO: Reevaluate authorization without Pundit

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = ::User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = ::User.new(user_params)

    if @user.save
      Credible::ConfirmationMailer.with(user: @user).confirmation_email.deliver_later
      @session = ::Session.create(user: @user)
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/confirm/:confirmation_token
  # GET /users/confirm/:confirmation_token.json
  def confirm
    @user = ::User.find_by(email: params[:email])

    @user.confirm(params[:confirmation_token])

    if @user.save
      @session = current_user ? current_session : ::Session.create(user: @user)
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/reset_password
  # POST /users/reset_password.json
  def reset_password
    @user = ::User.find_by(email: user_params[:email])

    @user.reset_password

    if @user.save
      Credible::ResetPasswordMailer.with(user: @user).reset_password_email.deliver_later
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
