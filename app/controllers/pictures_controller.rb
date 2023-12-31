class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
    @favorites = Favorite.all
    @favorite_pictures = current_user.favorites
  end

  def show
    @user = User.find(params[:id])
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to pictures_path, notice: "本人以外は編集ができません"
    else
      @picture = Picture.find(params[:id])
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        ContactMailer.contact_mail(@picture).deliver
        redirect_to pictures_path, notice: "投稿が完了しました！"
      else
        render :new
      end
    end
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "編集が完了しました！"
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path
  end

  private

  def picture_params
      params.require(:picture).permit(:user_id, :image, :content, :image_cache)
  end
end