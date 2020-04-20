class Credible::Authentication::SessionsController < Credible::AuthenticationController
  before_action :set_session, only: [:show, :destroy]

  skip_before_action :authenticate!, only: [:new, :create, :fail]
  skip_after_action :verify_authorized, only: [:fail]

  # GET /sessions
  # GET /sessions.json
  def index
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = ::Session.new
    authorize @session
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = ::Session.authenticate(permitted_attributes(Session))
    authorize @session

    if @session.save
      render :show, status: :created, location: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  # DELETE /sessions/current
  # DELETE /sessions/current.json
  def destroy
    warden.logout
    @session.destroy
    head :no_content
  end

  def fail
    render json: {}, status: :unauthorized
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = current_session
      authorize @session
    end
end
