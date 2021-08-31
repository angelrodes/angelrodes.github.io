<!--
# Ángel Rodés

[Home](https://angelrodes.github.io/)

---
-->
# This is a test file

Maybe I will use this to deliver the next sessions on `Matlab for Geoscientists`.

This is a [link](https://angelrodes.github.io/).

List

* Item 1
* Item 2
    * Subitem 2.1
        * Subitem 2.1.1
    * Subitem 2.2
* Item 3

Enumerate

1. first
1. second
1. third



Matlab code

```matlab

%% select number of models
testpointstotal=1e6;
testpoints=round(testpointstotal.^0.5);

%% doplot=1 if you want to see plots
doplot=0;

%% All inputs to single rows
x=x(:)';
dx=dx(:)';
y=y(:)';
dy=dy(:)';

%% Check data
check=std([length(x),length(y),length(dx),length(dy)])>0 | length(x)<3 | min(dy)<0 | min(dx)<0;
if check
    error('Check your data!')
end
```
