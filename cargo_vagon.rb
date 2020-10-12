# frozen_string_literal: true

# A cargo vagon which will be aded train
class CargoVagon < Vagon
  attr_reader :type, :cargo_volume
  def initialize(cargo_volume)
    @type = :cargo
    @cargo_volume = cargo_volume
    @volume = 0
  end

  def load_volume(volume)
    @volume += volume
  end

  def unload_volume(volume)
    @volume -= volume
  end

  def free_volume
    @cargo_volume - @volume
  end

  def ocuppied_voume
    @volume
  end

  protected

  attr_accessor :volume
end
