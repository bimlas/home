#!/bin/sh

cd $1 && git pull --ff-only && tiddlywiki --server $2
