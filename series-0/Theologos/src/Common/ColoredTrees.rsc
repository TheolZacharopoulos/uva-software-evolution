module Common::ColoredTrees

// Define a red black tree, with info at the leaves.
data ColoredTree = leaf (int N)      
                 | red (ColoredTree left, ColoredTree right) 
                 | black (ColoredTree left, ColoredTree right);
          
// Count the number of red nodes
public int cntRed(ColoredTree t) {
    int c = 0;  // init counter.
    visit(t) {  // pattern patch the tree at red nodes.
        case red(_,_): c = c + 1;
    };
    return c;
}

// Compute the sum of all integer leaves
public int sumLeaves(ColoredTree t) {
   int c = 0;
   visit(t) {
     case leaf(int N): c = c + N; // pattern match the Leaf   
   };
   return c;
}

// Add green nodes to ColoredTree by adding a new Constructor.
data ColoredTree = green(ColoredTree left, ColoredTree right); 

// Transform red nodes into green nodes
public ColoredTree makeGreen(ColoredTree t) {
   return visit(t) {
     case red(l, r) => green(l, r)   // pattern match the red nodes
   };                                // and then turns red into green.
}

