# frozen_string_literal: true

if ENV['ASSET_COMPILATION'].nil?
  Resque.redis = ENV['REDIS_URL']

 
end
