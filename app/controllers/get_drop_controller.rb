class GetDropController < ApplicationController
  
  require 'dropio' 
  
  Dropio::Config.api_key = "54651d667328449f5b98a0566323b4113801a8e5"
  def index
    drop = Dropio::Drop.find("splayfist")
     @drop = drop
     @howmany = drop.asset_count
    if false 
    @keys = []
    @howmany = drop.asset_count
   
    pages = (drop.asset_count / 30) + 1
    if !drop.blank?
      (pages).times { |i|
        drop.assets(i+1).each do |a|
            @keys << a.name 
        end
      }
    end
    end
  end
     


end
