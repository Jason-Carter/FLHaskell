
data Tree = Leaf | Node Int Tree Tree deriving Show

treeDepth :: Tree -> Int
-- longest path from root to a leaf
treeDepth Leaf = 0
treeDepth (Node _ leftSubtree rightSubtree) = 
  1 + max (treeDepth leftSubtree) (treeDepth rightSubtree)

-- make a test Tree
testTree = Node 10 (Node 5 Leaf Leaf) (Node 12 (Node 11 Leaf Leaf) Leaf)

treeSum :: Tree -> Int
treeSum Leaf = 0
treeSum (Node val leftSubTree rightSubTree) = val + (treeSum leftSubTree) + (treeSum rightSubTree)


isSortedTree :: Tree -> Int -> Int -> Bool
isSortedTree Leaf _ _ = True
isSortedTree (Node x leftSubtree rightSubtree) minVal maxVal =
    let leftSorted   = isSortedTree leftSubtree minVal x
        rightSorted = isSortedTree rightSubtree x maxVal
    in x >= minVal && x< maxVal && leftSorted && rightSorted

addNewMax :: Tree -> Tree
-- add a new max element to tree
addNewMax Leaf = Node 0 Leaf Leaf  -- input tree with no nodes
addNewMax (Node x t1 Leaf) = Node x t1 (Node (x+1) Leaf Leaf)  -- this is the rightmost Node
addNewMax (Node x t1 t2) = Node x t1 (addNewMax t2) -- intermediate node, go down right subtree


addNewMin :: Tree -> Tree
-- add a new min element to tree
addNewMin Leaf = Node 0 Leaf Leaf  -- input tree with no nodes
addNewMin (Node x Leaf t2) = Node x (Node (x-1) Leaf Leaf) t2  -- this is the leftmost Node
addNewMin (Node x t1 t2) = Node x (addNewMin t1) t2 -- intermediate node, go down right subtree
