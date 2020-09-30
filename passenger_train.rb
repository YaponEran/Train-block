class PassengerTrain < Train
  attr_reader :type
  def initialize(name)
    @type = :passenger
    super
  end
end