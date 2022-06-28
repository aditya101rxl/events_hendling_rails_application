class TagsController < ApplicationController
  before_action :is_admin
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params) 
    if @tag.save
      redirect_to tags_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

    def is_admin
      if !current_user.isAdmin
        redirect_to root_path
      end
    end

    def tag_params
      params.require(:tag).permit(:name)
    end

end
