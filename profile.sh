#!/bin/bash
~/local/python/bin/gprof2dot -f pstats --colour-nodes-by-selftime --show-samples /tmp/profile/* > profile.dot
dot -Tpdf profile.dot -o profile.pdf
rm /tmp/profile/*
