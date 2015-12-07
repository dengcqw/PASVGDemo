#!/usr/bin/make
#
# Copyright (c) 2010-2014, Marcus Rohrmoser mobile Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted
# provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions
# and the following disclaimer.
#
# 2. The software must not be used for military or intelligence or related purposes nor
# anything that's in conflict with human rights as declared in http://www.un.org/en/documents/udhr/ .
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
# THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# ##############################################################
# ragel stuff. http://www.complang.org/ragel/
DOT			?= dot
RAGEL		?= ragel

RAGEL_DIR := MROGeometry
GENERATED_DIR := MROGeometry

RAGEL_SOURCES := $(wildcard ./$(RAGEL_DIR)/*.rl)
RAGEL_GENERATED := $(RAGEL_SOURCES:./$(RAGEL_DIR)/%.rl=./$(GENERATED_DIR)/%.m)
RAGEL_PDF := $(RAGEL_SOURCES:./$(RAGEL_DIR)/%.rl=./$(GENERATED_DIR)/%.pdf)

./$(GENERATED_DIR)/%.m : ./$(RAGEL_DIR)/%.rl
	$(RAGEL) -e -s -G2 -C -o $@ $<
./$(GENERATED_DIR)/%.dot : ./$(RAGEL_DIR)/%.rl
	$(RAGEL) -e -p -V -o $@ $<
%.pdf: %.dot
	$(DOT) -Tpdf -o $@ $<

################################################################
## Run ragel to generate statemachine implementations
generate:	$(RAGEL_GENERATED)

################################################################
## Create ragel statemachine charts - runs literally for hours
doc:	$(RAGEL_PDF)

################################################################
## remove all ragel generated artifacts
clean:
	-rm $(RAGEL_GENERATED) $(RAGEL_PDF)
