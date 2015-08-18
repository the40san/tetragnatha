require 'spec_helper'

class Hoge < ActiveRecord::Base
  spider_at :default
end

describe Tetragnatha::SchemaCreation do
  describe "#visit_TableDefinition_with_tetragnatha" do

    let(:table_definition) do
      OpenStruct.new(name: "hoges", options: "ENGINE=InnoDB", columns: [])
    end

    let(:schema_creation) do
      ActiveRecord::ConnectionAdapters::AbstractAdapter::SchemaCreation.new(nil)
    end

    before do
      allow(schema_creation).to receive(:quote_table_name).and_return("hoges")

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
      schema_creation.visit_TableDefinition_with_tetragnatha(table_definition)
    end

    it "returns create table sql with comment for default endpoint" do
      expect(subject).to eq(
<<-SQL
CREATE TABLE hoges () ENGINE=InnoDB COMMENT 'host "localhost", user "usr", password "passwd", port "3306"'
SQL
      )
    end

  end
end
