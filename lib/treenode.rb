class TreeNode
  attr_accessor :parent, :value, :left, :right

  def initialize(value)
    @parent, @value = nil, value
  end

  def left=(child_node)
    self.left.parent = nil if self.left

    @left = child_node
    child_node.parent = self
  end

  def right=(child_node)
    self.right.parent = nil if self.right

    @right = child_node
    child_node.parent = self
  end
end