module BubbleSort

import List;
import IO;

// Sort 1, list[int] : integer's list 
public list[int] sort1(list[int] numbers) {

	if (size(numbers) > 0) { // get the size of the numbers list
		for (int i <- [0 .. size(numbers)-1]) {
		
			// not yet sorted elements.
			if (numbers[i] > numbers[i+1]) {
				// swapping / exchange.
				<numbers[i], numbers[i+1]> = <numbers[i+1], numbers[i]>;
         		return sort1(numbers);
			}
		}
	}
	return numbers;
}

// Ok this is some pretty cool list comprehension.
bool isSorted(list[int] lst) = 
	!any(int i <- index(lst), int j <- index(lst), (i < j) && (lst[i] > lst[j]));

test bool sorted1a() = isSorted([]);
test bool sorted1b() = isSorted([10]);
test bool sorted1c() = isSorted([10, 20]);
test bool sorted1d() = isSorted([-10, 20, 30]);
test bool sorted1e() = !isSorted([10, 20, -30]);

// sort2: uses list matching and switch
public list[int] sort2(list[int] numbers) {

  switch(numbers) {
  
  	// list matching
    case [*int nums1, int p, int q, *int nums2]:
       if (p > q) {
          return sort2(nums1 + [q, p] + nums2);
       } else {
       	  fail; // go back on the backtracking process.
       }
     default: 
     	return numbers;
   }
}

/**
 * Pattern matching example:
 *  (how to match) := (what to match)
 * > for([*i,3,*j] := [1,2,3,3,5,6]) { println(i); }
 * > [1,2]
 * > [1,2,3]
 * > list[void]: []
 */

test bool sorted2(list[int] lst) = isSorted(sort2(lst));

// sort3: uses list matching and while

public list[int] sort3(list[int] numbers) {

	// list matching in while
	// if it matches and p > q
  	while([*int nums1, int p, *int nums2, int q, *int nums3] := numbers && p > q) {
    	numbers = nums1 + [q] + nums2 + [p] + nums3; // list concatination
  	}
    
  return numbers;
}

test bool sorted3(list[int] lst) = isSorted(sort3(lst));

// sort4: using recursion instead of iteration, and splicing instead of concat
public list[int] sort4([*int nums1, int p, *int nums2, int q, *int nums3]) {
	if (p > q) {
		println("\> p = <p> , q = <q>"); 
    	return sort4([*nums1, q, *nums2, p, *nums3]);
	} else {
		println("Fail p = <p> , q = <q>");
    	fail sort4;
    }
}

public default list[int] sort4(list[int] x) = x;

test bool sorted4(list[int] lst) = isSorted(sort4(lst));

// finally, sort 5 inlines the condition into a when:
// uses tail recursion to reach a fixed point instead of a while loop.
public list[int] sort5([*int nums1, int p, *int nums2, int q, *int nums3]) 
  = sort5([*nums1, q, *nums2, p, *nums3])
  when p > q; 

public default list[int] sort5(list[int] x) = x;

test bool sorted5(list[int] lst) = isSorted(sort5(lst));