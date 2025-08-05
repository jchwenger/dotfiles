#!/bin/bash
chmod `stat -f %A $1` $2
