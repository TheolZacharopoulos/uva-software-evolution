# Clone Detector

## Hot to run
`rascal Main <smallsql|hsql>`

## Specification

### Input
#### 1. Choose a target project to detect clones for
#### 2. Clone Detection algorithm configuration:
- Statements number clone length
- Types to detect (1, 2, 3 are available)

### Output
#### 1. Data 
- Filenames
- Method with Start lines of all of its clone pairs 
- Types of detected clones

#### 2. Visualization
- HTML file which visualizes the detected clones (The javascript library D3.js is used here.)
- Supports: navigation between the clones, between the clone pairs

### The Visualization (Wheel):
1. The file detail view:
Shows all the files grouped by folders/packages, that include clones with:
    - clone code percentage
    - number of clones
    - type of clones
    
2. The Clone pair view
By selecting a file f, this view shows clones pair (fc) files of a selected file from the file detail view.

3. Code detail view
By selecting a code clone g, of a file, this view shows the two snippets allowing you to compare them.
Left is the original f, and right is the clone g. This view uses code highlighting to emphasize the clones.

