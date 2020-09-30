class PassengerVagon < Vagon
  attr_reader :type, :sit_place
  def initialize(sit_place)
    @type = :passenger
    @sit_place = sit_place
    @occupied = 0
  end

  def take_sit_place(msg, val)
    raise msg if occupied_place?(val)
    @occupied += val
  end

  def free_sit_place
    @sit_place.to_i - @occupied.to_i
  end

  def occupied_place?(val)
    @sit_place.to_i - @occupied.to_i < val.to_i
  end

  protected
  attr_accessor :occupied
end