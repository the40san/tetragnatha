module Tetragnatha
  module SchemaCreation
    def visit_TableDefinition_with_tetragnatha(table_definition)
      if model_exists?(table_definition.name)
        # TODO move option addtions to TableDefinition
        #options = table_definition.instance_variable_get(:@options)
        table_definition.instance_variable_set(:@options, "#{engine} #{table_comment(table_definition.name)}")
      end

      visit_TableDefinition_without_tetragnatha(table_definition)
    end

    private

    def table_comment(table_name)
      spider_config = to_model(table_name).spider_config
      comment_sql = "COMMENT"
      comment_sql << " 'host \"#{spider_config.host}\","
      comment_sql << " user \"#{spider_config.user}\","
      comment_sql << " password \"#{spider_config.password}\","
      comment_sql << " port \"#{spider_config.port}\"'"
      comment_sql
    end

    def engine
      "ENGINE=SPIDER"
    end

    def to_model_name(table_name)
      table_name.classify
    end

    def to_model(table_name)
      to_model_name(table_name).constantize
    end

    def model_exists?(table_name)
      Object.const_defined?(to_model_name(table_name))
    end
  end
end
