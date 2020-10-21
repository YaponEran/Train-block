module Accessors

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        method_name = method.to_sym
        define_method("#{method_name}") do 
          instance_variable_get("@#{method_name}")
        end

        define_method("#{method_name}=") do |value|
          history = instance_variable_get("@#{method_name}_history")
          history ||= []
          history << value
          instance_variable_set("@#{method_name}_history", history)
          instance_variable_set("@#{method}", value)
        end

        define_method("#{method_name}_history") do 
          instance_variable_get("@#{method_name}_history") || []
        end
      end
    end

    def strong_attr_accessor(*attr_names, klass)
      attr_names.each do |attr_name|
        define_method("#{attr_name}") do 
          instance_variable_get("@#{attr_name}")
        end
        define_method("#{attr_name}") do |val|
          raise TypeError.new("Wrong type of instance was passed") unless val.is_a?(klass)
          instance_variable_set("@#{attr_name}", val)
        end
      end
    end

  end
end