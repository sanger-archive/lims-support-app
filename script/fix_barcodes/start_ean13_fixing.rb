require 'optparse'
require 'fix_barcodes/fix_ean13_in_barcodes_table'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: add_kit.rb [options]"
  opts.on("-d", "--db [DB]")    { |d| options[:db] = d }
  opts.on("-v", "--verbose")    { |v| options[:verbose] = true }
  opts.on("-f", "--file F")     { |f| options[:file] = f }
end.parse!

barcode_mapper = Lims::SupportApp::BarcodeMapper.new(options)
barcode_mapper.correct_barcodes
