# Clone detector Visualization

Our tool is inspired by: *SolidSDD* [1] and *IntelliJ Idea IDE* [2] clone detector

### Our tool supports the following questions:
- How are clones distributed vs file structure
- How code clones are distributed between files
- Which files have high clone percentages
- What kind of clones does a given file contain
- Which files are affected by a given clone

## Structure View:
The diagram used is the **Hierarchical Edge Bundle**.

### The Nodes:
- Are clone locations
- Are files in the file system which include clones

### The edges:
- Show clone relations between files
- Edge colors show the type of the clones:
    - *Red* edges mean that the file include **type-1** clone
    - *Yellow* edges mean that the file include **type-2** clone
    - *Blue* edges mean that the file include **type-3** clone

The structure view helps finding files linked by clones and/or having high cloned-code percentages.

----

## Detail View:
The tool offers 3 different views to inspect the clones.

### The File view
This view presents the files which include clones with the number of clones as an overview. The user can see the details on demand.
This view is linked with the structure view: selecting file f in the structure view highlights it in this table. When the user selects a file on this view he/she can
see the clone pairs on the **Clone view**.

### The Clone View
This view allows the user to inspect the clones of the selected file in the **File view**. It displays a list of clone pairs with origin the selected file, including
information about the type of the clone (*type-1*, *type-2* or *type-3*).
When the user selects a *clone-pair* on this view he/she can see the cloned snippets
on the **Code detail view**.

### The Code Detail View
This view is used to study the cloned code snippets between the clone pair, origin and clone respectively. The left code-detail view shows code in the origin file, which is the file that selected from the **File view**, and the right view shows code in clone file, which is the file that selected from the **Clone view**. Using these views to easily compare matching code fragments.

## Sources
[1]. Voinea, Lucian, and Alexandru C. Telea. "Visual Clone Analysis with SolidSDD." Software Visualization (VISSOFT), 2014 Second IEEE Working Conference on. IEEE, 2014.

[2]. [IntelliJ Idea](https://www.jetbrains.com/idea/)
