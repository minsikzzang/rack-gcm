require 'rack'
require 'rack/contrib'

require 'sinatra/base'
require 'sinatra/param'

require 'sequel'

module Rack
  class GCM < Sinatra::Base
    use Rack::PostBodyContentTypeParser
    helpers Sinatra::Param

    disable :raise_errors, :show_exceptions

    autoload :Device, 'rack/gcm/models/device'

    configure do
      if ENV['DATABASE_URL']
        Sequel.extension :pg_array, :migration

        DB = Sequel.connect(ENV['DATABASE_URL'])
        DB.extend Sequel::Postgres::PGArray::DatabaseMethods
        Sequel::Migrator.run(DB, ::File.join(::File.dirname(__FILE__), 'gcm/migrations'), table: 'gcm_schema_info')
      end
    end

    before do
      content_type :json
    end

    post '/register/?' do
      param :languages, Array
      param :tags, Array
      
      if params[:regId]
        record = Device.find(token: params[:regId]) || Device.new
        
        # let's keep Google's standard parameter name
        params[:token] = params[:regId]
        record.set(params)
        
        code = record.new? ? 201 : 200
        
        if record.save
          status code
          {device: record}.to_json
        else
          status 400
          {errors: record.errors}.to_json
        end
      else
        status 400
      end
    end

    post '/unregister/?' do
      if params[:regId]
        record = Device.find(token: params[:regId]) or halt 404
        
        if record.destroy
          status 200
        else
          status 400
          {errors: record.errors}.to_json
        end
      else
        status 400
      end
    end
  end
end
