### Problem: Level Order Tree Traversal
Print nodes at each level of a binary tree on separate lines.

**Input**: Binary Tree
```
    1
   / \
  2   3
 /|   |
4 5   6
```

**Output**: Print each level on a separate line
```
1
2 3
4 5 6
```

### Solution (Using BFS)
```python
from collections import deque

def print_tree_levels(root):
    if not root:
        return
    
    queue = deque([(root, 0)])  # store (node, level)
    current_level = 0
    current_line = []
    
    while queue:
        node, level = queue.popleft()
        
        # When level changes, print nodes collected so far
        if level > current_level:
            print(" ".join(map(str, current_line)))
            current_line = []
            current_level = level
        
        current_line.append(node.val)
        
        # Add child nodes
        if node.left:
            queue.append((node.left, level + 1))
        if node.right:
            queue.append((node.right, level + 1))
    
    # Print last level
    if current_line:
        print(" ".join(map(str, current_line)))
```

### Solution Explanation
1. Create a queue for BFS, storing the root node with its level (0)
2. While processing nodes from queue:
   - If level changes, print nodes from previous level
   - Add current node to current level's list
   - Add child nodes to queue (with level + 1)
3. Print nodes from the last level

### Time Complexity
- O(N): Visit each node once

### Space Complexity
- O(W): W is the maximum width of the tree (max nodes in queue)

This problem tests understanding of:
1. BFS implementation
2. Level-order traversal
3. Queue data structure usage
4. Output formatting
