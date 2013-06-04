module Rack
  class GCM::Device < Sequel::Model
    plugin :json_serializer, naked: true, except: :id
    plugin :validation_helpers
    plugin :timestamps, force: true, update_on_create: true
    plugin :schema

    self.dataset = :gcm_devices
    self.strict_param_setting = false
    self.raise_on_save_failure = false

    def before_validation
      normalize_token!
    end

    def validate
      super

      validates_presence :token
      validates_unique :token
      validates_format /[[:xdigit:]]/, :token
    end

    private

    def normalize_token!      
      self.token = self.token.strip.gsub(/[<\s>]/, '')
    end
  end
end
