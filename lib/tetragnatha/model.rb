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
        @config ||= Config.new(@spider_at)
      end
    end
  end
end
