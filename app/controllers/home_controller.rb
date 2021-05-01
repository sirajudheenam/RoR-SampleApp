class HomeController < ApplicationController
  def index
  end

  def info
  	@asset_config_path = Rails.application.config.assets.paths
  	
  end

  def contact
  end

  def about
  end

  def validation
  end
end
