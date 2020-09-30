class CargoTrain < Train
  attr_reader :type
  def initialize(name)
    @type = :cargo
    super
  end
end