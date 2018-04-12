module Generators
  class BandName < ApplicationService
    def call
      context.result = Faker::Hipster.sentence(2, false, 0).delete('.').titleize
    end
  end
end