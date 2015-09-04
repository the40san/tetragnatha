module Tetragnatha
  class Railtie < Rails::Railtie
    initializer "tetragnatha" do
      ActiveSupport.on_load(:active_record) do
        require "tetragnatha/connection_adapters/abstract_mysql_adapter"
        require "tetragnatha/config"
        require "tetragnatha/model"

        ActiveRecord::Base.send(:include, Tetragnatha::Model)
      end
    end
  end
end
