# frozen_string_literal: true

# A factory makin trains vagons
module Factory
  attr_accessor :company_name
  validate :number, :presence
end
