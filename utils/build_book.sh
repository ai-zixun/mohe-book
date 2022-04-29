#!/bin/bash

(
    mdbook build
    rm -rf ./docs
    cp -R ./book ./docs
    rm -rf ./book
)