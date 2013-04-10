require 'lims-support-app/barcode/prefix/barcode_prefix_rule'

module Lims::SupportApp
  module BarcodePrefix
    class BarcodePrefixes
      PREFIXES = [
        BarcodePrefixRule.new('tube', 'stock', 'DNA', 'JD'),
        BarcodePrefixRule.new('tube', 'stock', 'PDNA', 'JP'),
        BarcodePrefixRule.new('tube', 'stock', 'RNA', 'JR'),

        BarcodePrefixRule.new(nil, 'stock', 'DNA', 'ND'),
        BarcodePrefixRule.new(nil, 'stock', 'PDNA', 'NP'),
        BarcodePrefixRule.new(nil, 'stock', 'RNA', 'NR'),

        BarcodePrefixRule.new('plate', 'working dilution', 'DNA', 'WD'),
        BarcodePrefixRule.new('plate', 'working dilution', 'PDNA', 'WQ'),
        BarcodePrefixRule.new('plate', 'working dilution', 'RNA', 'WR'),

        BarcodePrefixRule.new('plate', 'pico dilution', 'DNA', 'QD'),
        BarcodePrefixRule.new('plate', 'pico dilution', 'PDNA', 'QP'),

        BarcodePrefixRule.new('plate', 'pico assay_a', 'DNA', 'PA'),
        BarcodePrefixRule.new('plate', 'pico assay_a', 'PDNA', 'PD'),

        BarcodePrefixRule.new('plate', 'pico assay_b', 'DNA', 'PB'),
        BarcodePrefixRule.new('plate', 'pico assay_b', 'PDNA', 'PE'),

        BarcodePrefixRule.new('plate', 'ribo dilution', 'RNA', 'QR'),

        BarcodePrefixRule.new('plate', 'ribo assay_a', 'RNA', 'RH'),

        BarcodePrefixRule.new('plate', 'ribo assay_b', 'RNA', 'RI'),

        BarcodePrefixRule.new('gel', 'gel plate', 'DNA', 'GD'),
        BarcodePrefixRule.new('gel', 'gel plate', 'PDNA', 'GQ'),
        BarcodePrefixRule.new('gel', 'gel plate', 'RNA', 'GR'),

        BarcodePrefixRule.new('plate', 'standard', 'DNA', 'YD'),
        BarcodePrefixRule.new('plate', 'standard', 'PDNA', 'YP'),
        BarcodePrefixRule.new('plate', 'standard', 'RNA', 'YR'),

        BarcodePrefixRule.new('plate', 'control', 'DNA', 'XD'),
        BarcodePrefixRule.new('plate', 'control', 'PDNA', 'XP'),
        BarcodePrefixRule.new('plate', 'control', 'RNA', 'XR'),

        BarcodePrefixRule.new('spin column', nil, 'DNA', 'KD'),
        BarcodePrefixRule.new('spin column', nil, 'PDNA', 'KP'),
        BarcodePrefixRule.new('spin column', nil, 'RNA', 'KR'),

        BarcodePrefixRule.new(nil, 'stock', 'blood', 'BL'),
        BarcodePrefixRule.new(nil, 'stock', 'tumour tissue', 'TS'),
        BarcodePrefixRule.new(nil, 'stock', 'non-tumour tissue', 'TN'),
        BarcodePrefixRule.new(nil, 'stock', 'saliva', 'SV'),
        BarcodePrefixRule.new(nil, 'stock', 'pathogen', 'PT')
      ]
    end
  end
end
