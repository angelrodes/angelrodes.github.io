<!--
# Ángel Rodés

[Home](https://angelrodes.github.io/)

---
-->
# This is a test file

## sceond 

### third

#### fourth

##### fifth

###### sixth (max)


Maybe I will use this to deliver the next sessions on `Matlab for Geoscientists`.

This is a [link](https://angelrodes.github.io/).

Lists:

* Item 1
* Item 2
    * Subitem 2.1
        * Subitem 2.1.1
    * Subitem 2.2
* Item 3

- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item

Enumerate:

1. first
1. second
1. third

*Italic* **Bold** `code`

Table:

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column




Matlab code:

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

<!--
![image](https://angelrodes.files.wordpress.com/2021/09/yo-china_pixelado.gif)
-->
