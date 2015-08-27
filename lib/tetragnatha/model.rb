module Tetragnatha
  module Model
    def self.included(model)
      model.singleton_class.class_eval do
        include ClassMethods
      end
    end

    module ClassMethods
      def spider_at(name)
        @spider_at = name
      end

      def spider_config
        if @spider_at
          Config.new(@spider_at)
        elsif self == ActiveRecord::Base
          Config.new("default")
        else
          superclass.spider_config
        end
      end
    end
  end
end
