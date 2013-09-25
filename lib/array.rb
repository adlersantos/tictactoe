class Array
  def sum_with(row, col)
    [self, [row, col]].transpose.map { |x| x.reduce(:+) }
  end
end
