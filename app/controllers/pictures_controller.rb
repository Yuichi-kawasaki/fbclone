class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show

  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def edit
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, notice: "投稿しました！"
      else
        render :new
      end
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿を編集しました！"
    else
      ender :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"投稿を削除しました！"
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end

  private
  def picture_params
    params.require(:picture).permit(:content, :image, :image_cache)
  end
end
