require 'active_support/lazy_load_hooks'
require 'active_record'
require 'active_record/connection_adapters/abstract_mysql_adapter'

module Tetragnatha
end

ActiveSupport.on_load(:active_record) do
  require "tetragnatha/config"
  require "tetragnatha/model"
  require "tetragnatha/schema_creation"

  ActiveRecord::Base.send(:include, Tetragnatha::Model)
  ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::SchemaCreation.send(:include, Tetragnatha::SchemaCreation)
  ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::SchemaCreation.class_eval do
    alias_method_chain "visit_TableDefinition", :tetragnatha
  end
end
