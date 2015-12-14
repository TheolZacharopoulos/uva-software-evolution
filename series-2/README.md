# Clone Detector

## How to run
1. First copy the executable files to your bin folder:

` cp rascal* /usr/local/bin/`

2. Change directory to the *src* folder in order to find the *Main* module:

`cd src`

3. Then run the Clone detector with the project name as argument:

`rascal Main <smallsql|hsql>`

4. When the detection finished, open the `index.html` file under the `Visualization` folder and select the desirable project using the drop down.

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
