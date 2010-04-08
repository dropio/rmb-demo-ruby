class GetDropController < ApplicationController
  
  require 'dropio' 
  
  Dropio::Config.api_key = "348df82fc24bd1eff27084a7b5f876afe61d9d7b"
  def index
    @dropname = params['drop'] || "splayfist"
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
     
  def uploadFile
    @params = params
  end


end
