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
   
   queue = deque([root])        # Initialize queue with root node
   
   while queue:
       level_size = len(queue)  # Get number of nodes at current level
       level_nodes = []         # List to store nodes at current level
       
       # Process all nodes at current level
       for _ in range(level_size):
           node = queue.popleft()  # Get node from front of queue
           level_nodes.append(str(node.val))
           
           # Add child nodes to queue
           if node.left:
               queue.append(node.left)
           if node.right:
               queue.append(node.right)
       
       # Print all nodes at current level
       print(" ".join(level_nodes))
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
- O(W): W is the maximum width of the tree (max nodes in a queue)
