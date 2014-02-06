require 'lims-support-app/version'
require 'common'

require 'lims-support-app/barcode/all'

require 'lims-support-app/kit/all'

require 'lims-support-app/label_printer/all'

require 'lims-core/persistence/sequel'
require 'lims-core/persistence/sequel/session'

require 'lims-laboratory-app/labels/all'
require 'lims-laboratory-app/labels/labellable/eager_load_labellable'

require 'lims-core/persistence/search'
require 'lims-core/persistence/search/all'
require 'lims-api/persistence/search_resource'

require 'lims-api/server'
require 'lims-api/context_service'

require 'lims-support-app/util/db_handler'

# TODO remove it later, if we have a proper solution for hiding resources
# from lims-core project
require 'hide_resources'

ENV["LIMS_SUPPORTAPP_ENV"] = "test" unless ENV["LIMS_SUPPORTAPP_ENV"]


class Hash
  def deep_fetch(key, default = nil)
    default = yield if block_given?
    (deep_find(key) or default)
  end

  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) do |memo, value|
      memo ||= value.deep_find(key) if value.respond_to?(:deep_find)
    end
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
