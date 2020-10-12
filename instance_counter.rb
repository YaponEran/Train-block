# frozen_string_literal: true

# A counter when w create a class of objects
module InstanceCounter
  def self.included(receiver)
    receiver.included = ClassMethods
    receiver.send :incluede, InstanceMethods
  end

  # a class methods of object
  module ClassMethods
    attr_writer :instances

    def instances
      @instances || 0
    end

    def add_instance
      self.instances += 1
    end
  end

  # a intance methods of object
  module InstanceMethods
    protected

    def register_instance
      self.class.instances
    end
  end
end
