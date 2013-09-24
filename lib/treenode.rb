class TreeNode
  attr_accessor :parent, :children, :value

  def initialize(value=nil)
    @parent = nil
    @children = []
    @value = value
  end

  def children=(child_nodes)
    @children = child_nodes
    child_nodes.each do |child_node|
      child_node.parent = self
    end
  end

  # depth-first search
  def dfs(end_value=nil, &block)
    if block && block.call(@value)
      return self
    elsif @value == end_value
      return self
    else
      @children.each do |child|
        temp = child.dfs(end_value, &block)
        return temp if temp
      end
    end
    nil
  end

  # breadth-first search
  def bfs(end_value=nil, &block)
    nodes_to_check = [self]
    next_nodes_to_check = []

    visited_nodes = []

    while !nodes_to_check.empty?
      nodes_to_check.each do |node|
        if block && block.call(node.value)
          return node
        elsif node.value == end_value
          return node
        else
          if !visited_nodes.include?(node)
            node.children.each do |child|
              next_nodes_to_check << child
            end

            visited_nodes << node
          end
        end
      end

      nodes_to_check = next_nodes_to_check
      next_nodes_to_check = []
    end
    nil
  end
end

# a = TreeNode.new(1)
# b = TreeNode.new(2)
# c = TreeNode.new(3)
# d = TreeNode.new(4)
# e = TreeNode.new(5)
# f = TreeNode.new(3)

# a.children = [b, c]
# b.children = [d, e, f]

# a.bfs { |value| value == 3 } => c
# a.dfs { |value| value == 3 } => f