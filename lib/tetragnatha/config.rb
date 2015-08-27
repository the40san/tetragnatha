module Tetragnatha
  class Config
    DEFAULT_HOST = "localhost"
    DEFAULT_USER = "root"
    DEFAULT_PORT = 3306
    DEFAULT_PASSWORD = ""

    def initialize(name)
      @name = name
    end

    # TODO delegate
    def host
      database_configurations[:host] || DEFAULT_HOST
    end

    def port
      database_configurations[:port] || DEFAULT_PORT
    end

    def user
      database_configurations[:username] || DEFAULT_USER
    end

    def password
      database_configurations[:password] || DEFAULT_PASSWORD
    end

    private

    def database_configurations
      ActiveRecord::Base.configurations.with_indifferent_access[@name] || {}
    end
  end
end
