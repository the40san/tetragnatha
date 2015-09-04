require 'spec_helper'

class Hoge < ActiveRecord::Base
  spider_at :default
end

describe Tetragnatha::ConnectionAdapters::TableDefinition do
  describe "#initialize" do
    let(:table_definition) do
      ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::TableDefinition.new("hoges", nil, nil, nil)
    end
    let(:schema_creation) do
      ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::SchemaCreation.new(nil)
    end

    before do
      allow(schema_creation).to receive(:quote_table_name).and_return("hoges")
      allow_any_instance_of(Tetragnatha::ConnectionAdapters::TableDefinition::CommentBuilder).to receive(:get_model).and_return(Hoge)

      ActiveRecord::Base.configurations = {
        "default" => {
          "adapter"  => "mysql2",
          "encoding" => "utf8",
          "reconnect"=> false,
          "host"     => "localhost",
          "username" => "usr",
          "password" => "passwd",
          "port"     => 3306,
          "database" => "default_database"
        },
        "spider_endpoint1" => {
          "adapter"  => "mysql2",
          "encoding" => "utf8",
          "reconnect"=> false,
          "host"     => "spider.db1.example",
          "username" => "sp1",
          "password" => "spsp",
          "port"     => 3306,
          "database" => "spider_database"
        }
      }
    end

    subject do
      schema_creation.__send__(:visit_TableDefinition, table_definition)
    end

    it "returns create table sql with comment for default endpoint" do
      expect(subject).to eq("CREATE TABLE hoges ENGINE=SPIDER COMMENT 'host \"localhost\", user \"usr\", password \"passwd\", port \"3306\"'")
    end
  end
end
