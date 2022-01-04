class StoriesController < ApplicationController
  # @users = User.order(:name).page params[:page]
  include StoriesHelper
  def index
    @stories = get_stories
    # @paginatable_array = Kaminari.paginate_array(@stories).page(params[:page]).per(5)
    @paginatable_array = Kaminari.paginate_array(@stories, total_count: @stories.count).page(params[:page]).per(5)
    @id = 0

    html_text = "<html><head><title>Title</title></head><body>This is just a Body</body></html>"
  end
  def show
  end
end
