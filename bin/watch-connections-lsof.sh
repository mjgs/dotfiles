#!/bin/bash

watch -d -n0 "lsof -Pn +M -i4 | grep ESTA"
