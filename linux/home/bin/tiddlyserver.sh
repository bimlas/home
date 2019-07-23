#!/bin/sh

cd $1 && git pull --ff-only && tiddlywiki --listen port=$2
