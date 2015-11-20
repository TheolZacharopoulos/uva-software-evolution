## Cool tricks we learned during Series-2

### Checking if annotation exists

The expression ``someExampleNode@src?`` will return false when the annotation does not exist. However, if you want to bring a default value in such cases, you can always use ``someExampleNode@src?|unknown://DEFAULT_VALUE_HERE``.

### Annotation usage

Seems that if you want to use an annotation of your own, you need to define it in the beginning of the file. 
Furthermore, this counts even only when you are trying to read annotation values, without writing.