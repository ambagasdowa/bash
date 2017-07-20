# bash
## multiple bash scripts

### battery_osd_monitor

Just a simple battery monitor using **osd** and / or *notify-send*

#### Dependencies on debian:

* xosd-bin *for osd_cat for write in X*
* notify-osd *for notify-send daemon*

just
> sudo apt-get install xosd-bin

then just run :
```javascript
$ sh battery_osd_monitor.sh &
```

### Preview

![battery osd monitor](http://baizabal.xyz/img/battery_osd_monitor.png)

### Site

[link to Page!](https://ambagasdowa.github.io/bash/)

### Version updates
0.0.1
>Adding colors for bat lower than 15 , 10 and 5 percents


TODO
> install instructions for starting as daemon


### extract

extractor with **passwords** list

#### Dependencies on debian:
* 7zip-full *For rar support*

Edit this lines with your passwords and your extraction path

```javascript
 PASSWORDS=$'pass1\npass2\npass3' # whit your passwords
 filepath="/path/to/data/inflating" #whit your extraction path

```
then you are ready to go
```javascript
  $ cd /to/path/of/zipped/files
  #and run the script
  $ path/to/extract.sh
```

### Version updates
0.0.1
>firts release


TODO
> set working directory

### more scripts ... soon
