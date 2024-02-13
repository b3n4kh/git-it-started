#!/bin/bash

if [ ! -f "node_modules/.bin/reveal-md" ]; then
    echo "Error: 'node_modules/.bin/reveal-md' not found. run `npm install` first"
    exit 1
fi


node_modules/.bin/reveal-md git.md --css style.css --absolute-url https://git.akhras.at --static --static-dirs=static
node_modules/.bin/reveal-md git.md --theme simple --css style.css --print _static/slides.pdf --print-size A4
node_modules/.bin/reveal-md git.md --css style.css --print _static/slides_dark.pdf --print-size A4

cp favicon.ico _static/


