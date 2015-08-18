module Tetragnatha
  class Config
    def initialize(name)
      @name = name
    end

    # TODO delegate
    def host
      database_configurations[:host]
    end

    def port
      database_configurations[:port]
    end

    def user
      database_configurations[:username]
    end

    def password
      database_configurations[:password]
    end

    private

    def database_configurations
      ActiveRecord::Base.configurations.with_indifferent_access[@name]
    end
  end
end
