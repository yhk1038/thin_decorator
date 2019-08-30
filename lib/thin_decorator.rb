
require 'active_support'
require 'active_support/core_ext'

class ThinDecorator < SimpleDelegator
  attr_accessor :context

  def self.inherited(base)
    base.class_eval <<-CODE, __FILE__ , __LINE__ + 1
      class Collection < ::ThinDecorator::Collection
        def origin_klass
          @origin_klass = Module.nesting[1]
        end
      end
    CODE
  end

  def self.decorate(obj, context: :default)
    instance = new(obj)
    instance.context = context
    instance
  end

  def self.decorates(collection, context: :default)
    self::Collection.decorate(collection, context: context)
  end

  def as_json(options = {})
    case context
    when :raw
      super(options)
    else
      default_scheme(options)
    end
  end

  private

  # Same as Object#as_json (original :as_json method)
  def default_scheme(options)
    if respond_to?(:to_hash)
      to_hash.as_json(options)
    else
      instance_values = Hash[instance_variables.map { |name| [name[1..-1], instance_variable_get(name)] }]
      instance_values.as_json(options)
    end
  end

  protected

  def cls
    self.class
  end

  def model
    __getobj__
  end

  def resource_name
    model.class.name.underscore
  end
end

require_relative './thin_decorator/collection'
require_relative './thin_decorator/error'
require_relative './thin_decorator/version'
