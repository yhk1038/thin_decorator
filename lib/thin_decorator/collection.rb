class ThinDecorator < SimpleDelegator
  class Collection < SimpleDelegator
    attr_reader :origin_klass
    attr_accessor :context

    def self.decorate(obj, context: :default)
      instance = new(obj)
      instance.context = context
      instance
    end

    def as_json(options = {})
      entries.map do |entry|
        origin_klass.decorate(entry, context: context)
      end
    end

    def origin_klass
      @origin_klass = Module.nesting[1]
    end

    protected

    def entries
      @entries ||= __getobj__
    end
  end
end
