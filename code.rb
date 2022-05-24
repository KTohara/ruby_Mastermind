class Code

  def initialize
    @code = (1..4).inject([]) { |acc| acc << rand(1..6) }
  end
end