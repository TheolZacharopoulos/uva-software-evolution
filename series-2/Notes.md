## Cool tricks we learned during Series-2

### Checking if annotation exists

The expression ``someExampleNode@src?`` will return false when the annotation does not exist. However, if you want to bring a default value in such cases, you can always use ``someExampleNode@src?|unknown://DEFAULT_VALUE_HERE``.