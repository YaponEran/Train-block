# frozen_string_literal: true

# A passenger train for train type
class PassengerTrain < Train
  attr_reader :type
  def initialize(name)
    @type = :passenger
    super
  end
end
