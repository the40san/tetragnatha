module Tetragnatha
  class ModelClassNotFound < StandardError; end

  module TableDefinition
    def self.included(model)
      model.class_eval do
        remove_method :options
      end
    end

    def options
      skip_table? ? @options : table_comment
    end

    private

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
