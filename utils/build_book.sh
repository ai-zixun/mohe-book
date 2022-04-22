#!/bin/bash

(
    mdbook build
    cp -R ./book ./docs
    rm -rf ./book
)