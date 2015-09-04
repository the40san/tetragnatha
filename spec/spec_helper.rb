require "active_record"
require "active_support"
require "tetragnatha"

ActiveSupport.on_load(:active_record) do
  require "tetragnatha/connection_adapters/abstract_mysql_adapter"
  require "tetragnatha/config"
  require "tetragnatha/model"

  ActiveRecord::Base.send(:include, Tetragnatha::Model)
end

RSpec.configure do |config|
end
