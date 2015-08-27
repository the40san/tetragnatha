require 'active_support/lazy_load_hooks'
require 'active_record'

ActiveSupport.on_load(:active_record) do
  require "tetragnatha/config"
  require "tetragnatha/model"
  require "tetragnatha/table_definition"

  ActiveRecord::Base.send(:include, Tetragnatha::Model)
  ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Tetragnatha::TableDefinition)
end
