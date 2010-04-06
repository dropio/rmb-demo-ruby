class GetDropController < ApplicationController
  
  require 'dropio' 
  
  Dropio::Config.api_key = "72851f00745cdfd0e87207219f3106bcc9927f66"
  def index
    drop = Dropio::Drop.find("fzf2n2l")
    if false 
    @keys = []
    @howmany = drop.asset_count
    @drop = drop
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
