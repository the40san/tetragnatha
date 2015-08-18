module Tetragnatha
  module SchemaCreation
    def visit_TableDefinition_with_tetragnatha(table_definition)
      table_definition.options += " #{table_comment(table_definition)}"
      visit_TableDefinition_without_tetragnatha(table_definition)
    end

    private

    def table_comment(table_definition)
      spider_config = model(quote_table_name(table_definition.name)).spider_config
      comment_sql = "COMMENT"
      comment_sql << " 'host \"#{spider_config.host}\"'"         if spider_config.host
      comment_sql << " 'user \"#{spider_config.user}\"'"         if spider_config.user
      comment_sql << " 'password \"#{spider_config.password}\"'" if spider_config.password
      comment_sql << " 'port \"#{spider_config.port}\"'"         if spider_config.port
    end

    def model(table_name)
      table_name.classify.constantize
    end
  end
end
