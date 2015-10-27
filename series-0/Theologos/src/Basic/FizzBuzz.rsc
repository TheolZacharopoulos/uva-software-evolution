module Basic::FizzBuzz

import IO;

/**
 * Write a program that prints the numbers from 1 to 100. 
 * But for multiples of three print "Fizz" instead of the number and for the multiples of five print "Buzz". 
 * For numbers which are multiples of both three and five print "FizzBuzz".
 */
 
 public void fizzBuzz() {
    for (n <- [0..101]) { // 101 because Rascal is not inclusive
        fb = ((n % 3 == 0) ? "Fizz" : "") + ((n % 5 == 0) ? "Buzz" : "");
        println((fb == "") ?"<n>" : fb);
    }
 }
 
 public void fizzBuzz2() {
    for (n <- [0..101]) {
        switch(<n % 3 == 0, n % 5 == 0>) {
            case <true, true> : println("FizzBuzz");
            case <true, false> : println("Fizz");
            case <false, true> : println("Buzz");
            default            : println(n);
        }
    }
 }
 
 public void fizzBuzz3() {
    for (n <- [0..101]) {
        if (n % 3 == 0)  {
            print("Fizz");
            
        } if (n % 5 == 0) {
            print("Buzz");
            
        } else {
            if (n % 3 != 0) {
                print(n);
            }
        }
    }
 }
 