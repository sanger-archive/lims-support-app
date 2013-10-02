require 'benchmark'
require 'lims-core'
require 'lims-core/persistence/sequel'
require 'lims-core/persistence/sequel/persistor'
require 'lims-core/persistence/session'
require 'lims-core/persistence/sequel/session'
require 'lims-core/persistence/sequel/store'
require 'lims-support-app'
require 'lims-support-app/barcode/bulk_create_barcode'
require 'sequel'
require 'rest-client'
require 'mysql2'

#require 'rubygems'
#require 'ruby-debug'

conn_str = "mysql2://localhost/support_development?user=root&password=root"
#conn_str = "jdbc:mysql://localhost/development?user=root&password=root"
DB = Sequel.connect(conn_str)
STORE = Lims::Core::Persistence::Sequel::Store.new(DB)
env='development'
cas_settings = YAML.load_file(File.join("config", "cas_database.yml"))[env]
sequencescape_settings = YAML.load_file(File.join("config", "sequencescape_database.yml"))[env]
labware_settings = YAML.load_file(File.join("config", "labware_db.yml"))
Lims::SupportApp::Util::DBHandler.db_initialize(cas_settings, sequencescape_settings, labware_settings)

def create_parameters(number_of_barcodes)
  labware = "tube_rack"
  role = "stock"
  contents = "DNA"

  {
    :labware            => labware,
    :role               => role,
    :contents           => contents,
    :number_of_barcodes => number_of_barcodes
  }
end

def create_number_of_barcodes(number_of_barcodes)
  Lims::SupportApp::Barcode::BulkCreateBarcode.new(:store => STORE, :user => "user", :application => "application") do |action, session|
    create_parameters(number_of_barcodes).each do |key, value|
      action.send("#{key}=", value)
    end
  end.call
end

def create_number_of_barcodes_with_api(number_of_barcodes)
  parameters = {:bulk_create_barcode => create_parameters(number_of_barcodes) }
  RestClient.post('http://localhost:9292/actions/bulk_create_barcode', parameters.to_json, HEADERS)
end

puts "CORE benchmarking"
Benchmark.bm do |x|
  x.report("100 barcodes: ")    { create_number_of_barcodes(100) }
  x.report("500 barcodes: ")    { create_number_of_barcodes(500) }
  x.report("1000 barcodes: ")   { create_number_of_barcodes(1000) }
  x.report("5000 barcodes: ")   { create_number_of_barcodes(5000) }
  x.report("10000 barcodes: ")  { create_number_of_barcodes(10000) }
end

#Profile the code
#RubyProf.start
#  create_number_of_barcodes(1000)
#core_result = RubyProf.stop

# Print a flat profile to text
#printer = RubyProf::GraphHtmlPrinter.new(core_result)
#File.open("script/perf_result/core_profile_data.html", "w") { |file| printer.print(file) }

#Profile the code
#RubyProf.start
#  create_number_of_barcodes_with_api(1000)
#api_result = RubyProf.stop

# Print a flat profile to text
#printer = RubyProf::GraphHtmlPrinter.new(api_result)
#File.open("script/perf_result/api_profile_data.html", "w") { |file| printer.print(file) }
