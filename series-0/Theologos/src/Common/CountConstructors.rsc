module Common::CountConstructors

import Node;
import Map;

// Define a ColoredTree data type
data ColoredTree = leaf(int N)      
                 | red(ColoredTree left, ColoredTree right) 
                 | black(ColoredTree left, ColoredTree right);
                 
public ColoredTree CT = red(black(leaf(1), red(leaf(2),leaf(3))), black(leaf(3), leaf(4)));

// Define a Card data type.
data Suite = hearts() | diamonds() | clubs() | spades();

data Card =  two(Suite s) | three(Suite s) | four(Suite s)  | five(Suite s) |
             six(Suite s) | seven(Suite s) | eight(Suite s) | nine(Suite s) | 
             ten(Suite s) | jack(Suite s)  | queen(Suite s) | king(Suite s) | 
             ace(Suite s);
             
data Hand = hand(list[Card] cards);

public Hand H = hand([two(hearts()), jack(diamonds()), six(hearts()), ace(spades())]);

// Count frequencies of constructors
public map[str,int] count(node N) {
    // introduces an empty map to maintain the frequencies
    freq = ();
    
    // defines a visit of argument N; it traverses the complete value of N.
    visit(N) {
        
        case node M: {
            // First the name of the constructor is retrieved using the getName()
            name = getName(M);
            // and then the frequency is updated.
            freq[name] ? 0 += 1; 
        }
    }
    return freq;
}
// rascal> count(CT);
// map[str, int]: ("red":2,"leaf":5,"black":2)

// rascal> count(H);
// map[str, int]: ("six":1,"ace":1,"two":1,"hearts":2,"spades":1,"hand":1,"diamonds":1,"jack":1)

public map[str,int] countRelevant(node N, set[str] relevant) = domainR(count(N), relevant);
// rascal> countRelevant(H, {"hearts", "spades"});
// map[str, int]: ("hearts":2,"spades":1) 
