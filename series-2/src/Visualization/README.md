# Clone detector Visualization

Our tool is inspired by: *SolidSDD* [1] and *IntelliJ Idea IDE* [2] clone detector

### Our tool supports the following questions:
- How code clones are distributed among files
- Which files are affected by a given clone
- What kind of clones does a selected file contain

## Structure View:
The diagram used is the **Hierarchical Edge Bundle**.

### The Nodes:
- Are clone locations
- They are files in the file system which include clones of different types

### The edges:
- Show clone relations between files, *clone pairs*
- Edge colors show the type of the clones:
    - *Red* edges mean that the file includes **type-1** clone
    - *Yellow* edges mean that the file includes **type-2** clone
    - *Blue* edges mean that the file includes **type-3** clone
- An edge is highlighted with the strongest clone type color, *t-1 > t-2 > t-3*

The structure view helps finding files linked by clones and/or having large cloned-code number.

----

## Detail View:
The tool offers 3 different views to inspect the clones.

### The File view
This view presents the files which include clones with the number of clones as an overview. The user can see the details on demand.
This view is linked with the structure view: selecting a file in the **structure view**, highlights it in this view.
When the user selects a file on this view he/she can see the clone pairs on the **Clone view**.

### The Clone View
This view allows the user to inspect the clones of the selected file in the **File view**. It displays a list of clone pairs with origin the selected file, including
information about the type of the clone (*type-1*, *type-2* or *type-3*).
When the user selects a *clone-pair* on this view he/she can see the cloned snippets on the **Code detail view**.

### The Code Detail View
This view is used to study the cloned code snippets between the origin and the clone file respectively. The left code-detail view shows code in the origin file, which is the file that selected from the **File view**, and the right view shows code in clone file, which is the file that selected from the **Clone view**. Using these views one can easily compare matching code fragments.

## Sources
[1]. Voinea, Lucian, and Alexandru C. Telea. "Visual Clone Analysis with SolidSDD." Software Visualization (VISSOFT), 2014 Second IEEE Working Conference on. IEEE, 2014.

[2]. [IntelliJ Idea](https://www.jetbrains.com/idea/)
