class EventsController < ApplicationController
  before_action :is_admin, except: :index
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @registerd_users = User.joins(:registerables).where(registerables: {event_id: @event.id});
  end
  
  def new
    @event = Event.new
    @tags = Tag.all
  end

  def create
    @event = Event.new(event_params.except(:tags))
    create_or_delete_events_tags(@event, params[:event][:tags])

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    create_or_delete_events_tags(@event, params[:event][:tags])

    if @event.update(event_params.except(:tags))
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_path, status: :see_other
  end


  private

    def is_admin
      if !current_user.isAdmin
        redirect_to root_path
      end
    end

    def create_or_delete_events_tags(event, tags)
      event.taggables.destroy_all
      tags = tags.delete(' ')
      tags = tags.strip.split(',')
      tags.each do |tag|
        event.tags << Tag.find_or_create_by(name: tag.upcase)
      end
    end

    def event_params
      params.require(:event).permit(:title, :description, :image, :registration_start, 
                      :registration_end, :fees, :venue, :event_type, :tags)
    end

    def check_option
      if params[:event_type] == "select"
        render :edit, status: :unprocessable_entity
      end
    end

  def addEvent
  end

end
