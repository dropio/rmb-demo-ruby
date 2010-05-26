class DropsController < ApplicationController
  
  gem 'dropio', '>=3.0.0.pre' 
  require 'dropio'
  
  def initialize
    
    ######################
    #MAIN CONFIGURATION (required)
    Dropio::Config.api_key = "YOUR_API_KEY"
    @manager_api_token = "YOUR_MANAGER_API_TOKEN"
    
    ################################
    #ADDITIONAL CONFIGURATION (optional)
    
    ######################
    #API Version 3.0 is required for using our Roles->Locations structure  
    Dropio::Config.version = "3.0"
    
    ######################
    #An array of available storage locations. You can create your own storage
    #locations in the  http://manager.drop.io API tab
    @output_locations = ["DropioS3"]
    
    ######################
    #Which CDN links to display
    @enabled_cdns = ["akamai", "voxel", "limelight"]
    
  end

  def index
    service = Dropio::Api.new
    @manager_info = service.manager_drops(@manager_api_token)
  end
  
  def new
    if params['id'] 
      service = Dropio::Api.new
      service.create_drop({"name"=>params['id'], "expiration_length"=>"1_YEAR_FROM_LAST_VIEW"})
      redirect_to :drops
    end
  end
  
  def show
      @dropname = params['id'] || ""
      drop = Dropio::Drop.find(@dropname)
      @assets = []
      @howmany = drop.asset_count
      @drop = drop
      pages = (drop.asset_count / 30) + 1
      if !drop.blank?
        (pages).times { |i|
          drop.assets(i+1).each do |a|
              @assets << a
          end
        }
      end
  end
  
  def upload
  end
  
end
