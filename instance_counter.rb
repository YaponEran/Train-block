module InstanceCounter
  def self.included(receiver)
    receiver.included = ClassMethods
    receiver.send :incluede , InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ? @instances : 0
    end

    def add_instance
      self.instances += 1
    end

  end

  module InstanceMethods
    protected 
    def register_instance
      self.class.instances
    end
  end

end