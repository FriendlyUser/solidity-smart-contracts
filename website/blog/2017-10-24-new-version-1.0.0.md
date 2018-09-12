---
title: Vuedoc and Icons
author: David Li
authorURL: http://twitter.com/davidli
authorFBID: 661277174
---

Previously, I had used a ad-hoc method of documentation.js and jsdoc to generate documentation for this project. Icons are from free website [all-free-download](https://all-free-download.com/free-vector/download/business_icons_268686_download.html) and I assume since I am doing open source projects, I can use it for free.

Using vuedoc is superior for a number of reasons, including documentating vue components, etc ...
```sh
#!/bin/bash 

path=docs/components
mkdir -p $path
vuedoc.md src/components/* --output $path
echo "Done writing vue components with vuedoc."
echo "----------------------"
cd $path

for filename in *.md; do
    echo "Working on $filename"
    name=$(echo "$filename" | cut -f 1 -d '.')
    echo "$name"
    echo "Using file $filename"
    echo "----------------------"
    baseFileName=$(basename $filename)

    echo "Adding docusarus headers"
    echo "----------------------"
    sed -i '1s/^/---\n/' "$name.md"
    sed -i '1s/^/title: ${TitleReplace} \n/' "$name.md"
    sed -i '1s/^/id: ${nameNone} \n/' "$name.md"
    sed -i '1s/^/---\n/' "$name.md"
    
    
    # Replace the garbage with Actually content
    sed -i -e 's/${TitleReplace}/'${name}'/g' "$name.md"
    sed -i -e 's/${nameNone}/'${baseFileName}'/g' "$name.md"
done
```

