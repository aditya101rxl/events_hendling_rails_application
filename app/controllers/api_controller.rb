class ApiController < ApplicationController
	skip_before_action :authenticate_user!
	
	def login
		@user = User.find_by_email(params[:email])

		if @user.valid_password?(params[:pass])
			render json: {user: @user, msg: "success"}
		else
			redirect_to api_login_failed_path
		end
	end

  def events
    @events = Event.all

    render json: @events
  end

  def search
  	# @event = Event.where(id: params[:q] or event_type: params[:q])
  	@event = Event.where(id: params[:q]).or(Event.where(event_type: params[:q]))

  	render json: @event
  end

  def register
  	
  end

  def login_failed
  	@user = User.all
  	render json: {user: "user not found or invalid credentials", msg: "failed"}
  end

  # def show
  # 	@event = Event.find(12)

  # 	render json: @event
  # end

end
