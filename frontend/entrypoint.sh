#!/bin/bash

pnpm i
pnpm playwright install
pnpm playwright install-deps
pnpm gen:schema:watch &
pnpm dev
