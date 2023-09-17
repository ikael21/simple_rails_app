# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(microposts_params)
    @micropost.image.attach(microposts_params[:image])

    return process_successful_micropost_creation if @micropost.save

    @feed_items = current_user.feed.paginate(page: params[:page])
    render 'static_pages/home'
  end

  def destroy
    @micropost.destroy
    add_flash_message(:success, 'Micropost deleted.')

    redirect_to request.referer || root_url
  end

  private

  def process_successful_micropost_creation
    add_flash_message(:success, 'Micropost created!')

    redirect_to root_url
  end

  def microposts_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
