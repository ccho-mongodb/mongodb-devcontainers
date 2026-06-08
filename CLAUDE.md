# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repo provides VS Code Dev Container configurations for three MongoDB driver quickstarts — TypeScript, Python, and Go. Each language has its own devcontainer that attaches to a shared MongoDB instance running in Docker Compose. The containers are intended to be opened in VS Code via the "Reopen in Container" flow, selecting one of the three language containers.

## Architecture

Docker Compose (`/.devcontainer/docker-compose.yml`) defines four services:
- `mongo-database` — MongoDB community server, persists data in a named volume
- `init-db` — Alpine container that runs `load_sample_data.sh` on startup to import the JSON files in `/.devcontainer/sample_data/` into the `sample_mflix` database
- `typescript`, `python`, `golang` — language-specific dev containers, each mounting their respective source directory at `/workspace/<lang>/`

Each language app connects to MongoDB at `mongodb://mongo-database:27017` and queries the `sample_mflix.movies` collection as a connectivity demo.

## Language-specific commands

### TypeScript (`/typescript/`)
```bash
npm install          # install dependencies
npm run start        # run with ts-node (no compile step needed)
npm run build        # compile to dist/ with tsc
```

### Python (`/python/`)
```bash
pip install -r requirements.txt   # install pymongo, flask, pytest
python src/app.py                 # start Flask server on port 3001
pytest                            # run tests
```

### Go (`/golang/`)
```bash
go run ./cmd/welcome/    # run the welcome app
go build ./cmd/welcome/  # build binary
go test ./...            # run tests
```

## Sample data

`/.devcontainer/sample_data/` contains JSON files (`movies.json`, `comments.json`, `sessions.json`, `theaters.json`, `users.json`) that are bulk-imported by `init-db` via `mongoimport` into the `sample_mflix` database. The directory name becomes the database name; the filename (without extension) becomes the collection name.
