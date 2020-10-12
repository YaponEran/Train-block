# frozen_string_literal: true

# Station creation class and methods
class Station
  include InstanceCounter
  attr_reader :name, :trains
  @stations = []

  NAME_EXAMPLE = /^[А-ЯЁ][а-яё]{2,15}$/x.freeze

  def initialize(name)
    @name = name
    @trains = []
    @stations.push(self)

    validate!
    register_instance
  end

  def each_train
    @trains.each { |train| yield(train) if block_given? }
  end

  def self.all
    @stations
  end

  def add_train(train)
    @trains.push(train)
  end

  def type_of_train(_type)
    @trains.each { |train| puts train.type }
  end

  def sent_train(train_type)
    @trains.delete(train_type)
  end

  protected

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise 'Invalid name' if name !~ NAME_EXAMPLE
  end
end
