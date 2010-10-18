module Initializer
  configure do
    CONFIG = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/config.yml'))

    Rmb::Config.api_key = CONFIG['api_key']

    # Only needed for secure keys
    # Rmb::Config.api_secret = CONFIG['api_secret']

    # Uncomment to enable Rmb logging
    # Rmb::Config.debug = true

    API_KEY    = Rmb::Config.api_key
    API_SECRET = Rmb::Config.api_secret

    enable :sessions
    use Rack::Flash, :sweep => true
  end

  before do
    @api = Rmb::Api.new
  end

  helpers do
    def large_thumbnail(asset)
      begin
        if asset.type == "image"
          large_thumbnail = lambda do
            asset.roles.select{ |role| role["name"] == "large_thumbnail" }
          end.call.first['locations']
          if large_thumbnail.first["status"] == "complete"
            "<img src='#{large_thumbnail.first['file_url']}' />"
          end
        end
      rescue Exception => e
        puts "Caught exception: #{e}"
      end
    end

    def signature
      @api.get_signature({
        :api_key        => API_KEY,
        :timestamp      => (Time.now.to_i + 900).to_s,
        :version        => "3.0",
        :signature_mode => "OPEN"
      })
    end
  end
end
