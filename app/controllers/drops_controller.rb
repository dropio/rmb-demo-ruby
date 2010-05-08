class DropsController < ApplicationController
  
  require 'dropio' 
  ######################
  #Production
  Dropio::Config.api_key = "348df82fc24bd1eff27084a7b5f876afe61d9d7b"
  Dropio::Config.manager_api_token = "dq7yf4m3qx"
  Dropio::Config.user_output_locations = ["sl_0bb68ad0233c012db8e7fffb204ba9a3"]
  Dropio::Config.enabled_cdns = ["akamai", "voxel", "limelight"]
  Dropio::Config.version = "3.0"
  ######################
  #Staging
  #Dropio::Config.api_key = "d4bf89d218cb982ddffdeef8a0144b57f88896c6"
  #Dropio::Config.manager_api_token = "uxd1dxumgi"
  #Dropio::Config.user_output_locations = ["sl_2e2f29b01a82012da16efe5f8802078d"]
  #Dropio::Config.enabled_cdns = ["akamai", "voxel", "limelight"]
  #Dropio::Config.base_url = "http://stage-drop.io"
  #Dropio::Config.api_url = "http://stage-api.drop.io"
  #Dropio::Config.upload_url = "http://stage-assets.drop.io/upload"
  #Dropio::Config.version = "3.0"
  
  def index
    service = Dropio::Api.new
    @manager_info = service.manager_drops(Dropio::Config.manager_api_token)
    
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
     @output_locations = Dropio::Config.output_locations
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
