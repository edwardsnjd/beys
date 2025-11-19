SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: all
all: bey1.png bey1.stl bey2.png bey2.stl

%.stl: %.scad
	openscad -o $@ $<

%.png: %.scad
	openscad -o $@ $<
