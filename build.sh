#!/bin/bash


reveal-md git.md --theme simple --css style.css --absolute-url https://git.akhras.at --static --static-dirs=static

reveal-md git.md --theme simple --css style.css --print _static/slides.pdf --print-size A4
reveal-md git.md --css style.css --print _static/slides_dark.pdf --print-size A4

cp favicon.ico _static/


