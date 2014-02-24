#shared contexts for integrations
require 'lims-support-app'
require 'spec_helper'
require 'lims-api/context_service'

require 'lims-core/persistence/sequel'
require 'logger'

Loggers = []
#Loggers << Logger.new($stdout)
  
def connect_db(env)
  config = YAML.load_file(File.join('config','database.yml'))
  Sequel.connect(config[env.to_s], :loggers => Loggers)
end

def set_uuid(session, object, uuid)
  session << object
  ur = session.new_uuid_resource_for(object)
  ur.send(:uuid=, uuid)
end

def config_bus(env)
  YAML.load_file(File.join('config','amqp.yml'))[env.to_s] 
end

shared_context 'use core context service' do |user='user', application_id='application'|
  let(:db) { connect_db(:test) }
  let(:store) { Lims::Core::Persistence::Sequel::Store.new(db) }
  let(:message_bus) {
    mock(:message_bus).tap { |m|
      m.stub(:publish)
      m.stub(:connect)
      m.stub(:backend_application_id) { "lims-support-app/spec" }
    }
  }
  let(:context_service) { Lims::Api::ContextService.new(store, message_bus) }

  before(:each) do
    app.set(:context_service, context_service)
    header('user_email', user) if user
    header('application_id', application_id) if application_id
  end

  # This code is cleaning up the DB after each test case execution
  after(:each) do
    store.with_session(:backend_application_id => "lims-support-app/spec", :parameters => {action: "purge"}) do
      # list of all the tables in our DB
      %w{templates label_printers barcodes kits labels labellables uuid_resources}.each do |table|
        db[table.to_sym].delete
        revision_table = "#{table}_revision".to_sym
        db[revision_table].delete if db.table_exists?(revision_table)
      end
      db.disconnect
    end
  end
end

shared_context 'JSON' do
  before(:each) {
    header('Accept', 'application/json')
    header('Content-Type', 'application/json')
  }
end
