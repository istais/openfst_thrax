# openfst_thrax
The Dockerfile of an openfst installation with pywrapfst, far, grm and thrax support

## Contents

### Openfst
OpenFst is a library for constructing, combining, optimizing, and searching weighted finite-state transducers (FSTs). 

### pywrapfst
This extension exposes the OpenFst scripting API to Python. The extension allows for rapid prototyping and interactive construction of FSTs using the Python REPL.

### FAR
A finite-state archive (FAR) is used to store an indexable collection of FSTs in a single file.

### GRM
The OpenGrm Grammar Compiler is a set of tools for compiling grammars expressed as regular expressions and context-dependent rewrite rules into weighted finite-state transducers using the OpenFst format.

### Thrax
The OpenGrm Thrax tools compile grammars expressed as regular expressions and context-dependent rewrite rules into weighted finite-state transducers. It makes use of functionality in the OpenFst library to create, access and manipulate compiled grammars. It is named after Dionysius Thrax (Διονύσιος ὁ Θρᾷξ) (170 BC – 90 BC), the reputed first Greek grammarian.

## How to download

Just download the already installed image from docker
```
docker pull istais/openfst_thrax
docker run openfst_thrax
```

or build your own
```
docker build -t openfst_thrax .
```
