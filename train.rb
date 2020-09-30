class Train
  include InstanceCounter
  include Factory

  attr_reader :number, :type, :station, :num_of_vagons, :route, :speed
  @@trains = {}
  NUMBER_EXAMPLE = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i.freeze

  def self.find(num)
    @@trains[num]
  end

  def initialize(number)
    @number = number
    @type = type
    @num_of_vagons = []
    @speed = 0
    @@trains[@number] = self
    register_instance

    validate!
  end

  def each_vagons(&block)
    @num_of_vagons.each {|vagon| block.call(vagon) if block_given?}
  end

  def move_train
    self.speed += 1
  end

  def stop_train
    self.speed = 0
  end

  def add_vagon(vagon)
    self.num_of_vagons.push(vagon) if vagon.type == @type && @speed == 0
  end

  def remove_vagon(vagon)
    self.num_of_vagons.pop if @speed == 0
  end

  def add_route(route)
    @route = route
    @station = route.start_station
    @station.add_train(self)
  end

  def move_station
    if station != route.end_station
      station.send_train(self)
      self.station = self.next_station
      station.add_train(self)
    end
  end

  def comeback_station
    if station != route.start_station
      station.sent_train(self)
      self.station = self.previous_station
      station.add_train(self)
    end
  end

  def next_station
    route.stations[route.stations.index(station) + 1]
  end

  def previous_station
    if station == route.start_station
      nil
    else
      route.stations[route.stations.index(station) - 1]
    end
  end

  protected
  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise "Invalid number" if number !~ NUMBER_EXAMPLE
  end

end