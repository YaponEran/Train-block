class Station
  include InstanceCounter
  attr_reader :name, :trains
  @@stations = []

  NAME_EXAMPLE = /^[А-ЯЁ][а-яё]{2,15}$/x

  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)

    validate!
    register_instance
  end

  def each_train(&block)
    @trains.each {|train| block.call(train) if block_given?}
  end

  def self.all
    @@stations
  end

  def add_train(train)
    @trains.push(train)
  end

  def type_of_train(type)
    @trains.each {|train| puts train.type }
  end

  def sent_train(train_type)
    @trains.delete(train_type)
  end

  protected
  def valid?
    validate!
    true
   rescue
    false
  end

  def validate!
    raise "Invalid name" if name !~ NAME_EXAMPLE
  end

end 

