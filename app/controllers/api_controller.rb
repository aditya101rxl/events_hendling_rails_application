class ApiController < ApplicationController
	skip_before_action :authenticate_user!
	
  #create separet api controllers
  # 1. login, logout
  # 2. users query, filter
  # 3. user registrations





  #action for login
	def login
		@user = User.find_by_email(params[:email])

		if @user.valid_password?(params[:pass])
			render json: {user: @user, msg: "success"}
		else
			render json: {user: "user not found or invalid credentials", msg: "failed"}
		end
	end





  #action to get all tags
  def tags
    all_tags = Tag.select(:name)
    render json: all_tags
  end
  




  # action for all types of filter
  def events

    event_type = params[:event_type]
    sign = "<="
    tag_list = params[:tag_list].strip.split(',')

    if tag_list.size == 0
      tag_list = Tag.select(:name)
    end

    if params[:sub_event_type]=="upcoming"
      sign = ">="
    end

    if event_type == "all_events"
      @events = Event.where("registration_end #{sign} ?", Time.now)
                     .joins(taggables: :tag)
                     .where(tag: {name: tag_list})
      render json: @events

    else
      @events = Event.where("event_type = ? AND registration_end #{sign} ?", event_type, Time.now)
                     .joins(taggables: :tag)
                     .where(tag: {name: tag_list})
      render json: @events
    end

  end









  def register
  	
  end

end
