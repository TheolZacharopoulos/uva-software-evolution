## Cool tricks we learned during Series-2

### Checking if annotation exists

The expression ``someExampleNode@src?`` will return false when the annotation does not exist. However, if you want to bring a default value in such cases, you can always use ``someExampleNode@src?|unknown://DEFAULT_VALUE_HERE``.

### Annotation usage

Seems that if you want to use an annotation of your own, you need to define it in the beginning of the file. 
Furthermore, this counts even only when you are trying to read annotation values, without writing.

### Flaws in the paper

- There is a flaw in the generalization algorithm as defined in ICSM98. Simply put, if you have clone methods in the same class their parents will result to be identical, because the class is the same. Therefore the generalization goes from methods to the whole compilation unit and brings back results such as _Class A identical to class A_.

### Eclipse problems with M3

Sometimes M3 fragments can be remembered by Eclipse and lead to mismatch. `unregisterLocations("java", "");` can help with this.