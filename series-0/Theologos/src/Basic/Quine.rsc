module Basic::Quine

import IO;
import String;

/**
 * A quine is a computer program that takes no input and produces a copy of its own source code. 
 * A quine is also called a self-replicating or self-reproducing program.
 *
 */
 
 public void quine() {
    println(program);
    println("\"" + escape(program, ("\"" : "\\\"", "\\" : "\\\\")) + "\";");
 }
 
 str program = 
    "module demo::basic::Quine
    
    import IO;
    import String;
    
    public void quine(){
      println(program);
      println(\"\\\"\" + escape(program, (\"\\\"\" : \"\\\\\\\"\", \"\\\\\" : \"\\\\\\\\\")) + \"\\\";\");
    }
    
    str program ="; 