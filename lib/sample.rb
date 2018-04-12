module Sample
  def self.weighted(range)
    @_weights ||= {}
    @_weights[range] ||= range.map { |i| (range.end + 1 - i).times.map { i } }.flatten
    @_weights[range].sample
  end
end