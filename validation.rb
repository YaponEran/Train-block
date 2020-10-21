module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validation_hash

    def validate(attr_name, validation_type, options={})
      @validation_hash ||= {}
      @validation_hash[attr_name.to_sym] ||= []
      @validation_hash[attr_name] << {validation_type => options}
    end
  end

  module InstanceMethods
    def validate!
      return if hash_empty?(self.class.validation_hash)
      self.class.validation_hash.each do |attr_name, arr|
        instance = get_instance_by_attr_name(attr_name)
        arr.each do |hash|
          hash.each {|type, options| send(type, instance, options)}
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private
    def presence(attr_name, val)
      raise 'This value cannot be nil or empty' if attr_name.nil? || attr_name.empty?
    end

    def format(attr_value, options)
      options.each do |format, format_value|
        raise 'Wrong format was passed' if attr_value !~ format_value
      end
    end

    def type(attr_value, options)
      options.each do |item, class_name|
        raise "This attribute does not correspont to #{class_name}" unless attr_value.is_a?(class_name)
      end
    end

    def attr_empty?(attr_name)
      attr_name.nil? || attr_name.to_s.strip.empty?
    end

    def hash_empty?(hash)
      hash.nil? || hash.empty?
    end

    def get_instance_by_attr_name(name)
      instance_variable_get("@#{name}")
    end

  end
end