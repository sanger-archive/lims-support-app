# requirement used by  everything
require 'facets/string'
require 'facets/kernel'
require 'facets/hash'
require 'facets/array'

require 'virtus'
require 'aequitas/virtus_integration'

class Object
  def andtap(&block)
    self && (block ? block[self] : self)
  end

  def self.parent_scope()
    @__parent_scope ||= eval self.name.split('::').tap { |_| _.pop }.join('::')
  end
end

class Hash
  def deep_fetch(key, default = nil)
    default = yield if block_given?
    (deep_find(key) or default)
  end

  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end

  def deep_fetch_all(key, default = nil)
    values = []
    self.each do |element_key, element_value|
      if element_key == key
        values << element_value
      elsif element_value.is_a?(Hash)
        element = element_value.deep_fetch(key)
        values << element if element
      end
    end
    values
  end
end
