#!/bin/sh

members="bonprosoft ja731j ktt2357 nepiadeath oboenikui ThePerorist y_chu5"

for name in $members
do
    cp index.html _index.html
    uri=`curl -s https://twitter.com/${name} | grep "ProfileAvatar-image" | sed -e 's:.*<img.*src="::' | sed -e 's:" alt=".*">::'`
    ext=`echo ${uri} | sed -e 's:^.*com/.*/.*/.*\.::'`
    curl -s -o img/members/${name}.${ext} $uri
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mThe profile image of ${name} has been downloaded.\033[00m" | sed "s/^-e //"
        cat _index.html | sed "s:img/members/${name}\..*\":img/members/${name}.${ext}\":" > index.html
    else
        echo -e "\033[0;31m✗ \033[1;31mGetting the profile image of ${name} has failed.\033[00m" | sed "s/^-e //"
    fi
done
rm _index.html

