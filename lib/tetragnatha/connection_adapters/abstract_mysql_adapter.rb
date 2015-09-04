require 'active_record/connection_adapters/abstract_mysql_adapter'

module Tetragnatha
  class ModelClassNotFound < StandardError; end

  module ConnectionAdapters
    class TableDefinition < ActiveRecord::ConnectionAdapters::TableDefinition
      def initialize(types, name, temporary, options, as = nil)
        builder = CommentBuilder.new(name, options)
        super(types, name, temporary, builder.build, as)
      end

      class CommentBuilder
        attr_reader :name, :options

        def initialize(name, options)
          @name = name
          @options = options
        end

        def build
          !skip_table? && blank_option? ? table_comment : @options
        end

        private

        def blank_option?
          @options.blank? || @options == "ENGINE=InnoDB"
        end

        def table_comment
          comment_sql = "ENGINE=SPIDER "
          comment_sql << "COMMENT '"
          comment_sql << "host \"#{spider_config.host}\", "
          comment_sql << "user \"#{spider_config.user}\", "
          comment_sql << "password \"#{spider_config.password}\", "
          comment_sql << "port \"#{spider_config.port}\""
          comment_sql << "'"
          comment_sql
        end

        def spider_config
          return @spider_config if @spider_config
          @spider_config = get_model.spider_config
        end

        def get_model
          name.classify.constantize
        rescue
          fail(Tetragnatha::ModelClassNotFound, name)
        end

        def skip_table?
          name == "schema_migrations"
        end
      end
    end

    def create_table_definition(name, temporary = false, options = nil, as = nil) # :nodoc:
      TableDefinition.new(native_database_types, name, temporary, options, as)
    end
  end
end

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter < AbstractAdapter
      prepend Tetragnatha::ConnectionAdapters
    end
  end
end
