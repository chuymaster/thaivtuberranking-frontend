[![Netlify Status](https://api.netlify.com/api/v1/badges/3f342da2-0855-4157-8aa3-985a78c1bf64/deploy-status)](https://app.netlify.com/sites/vtuber-chuysan/deploys)

# thaivtuberranking-frontend

A Flutter Web client application for [Thai VTuber Ranking](https://vtuber.chuysan.com/) website.

![](docs/repository-open-graph.png)

## Setup

- See Documentation on Flutter site https://flutter.dev/docs/get-started/web

## Local Command

See `Makefile`. Run `make help` to see the available commands.

## API Document

See https://github.com/chuymaster/thai-vtuber-ranking-docs

## Automated Deployment

- Auto trigger deploy to Netlify when `main` branch is updated. Host: https://vtuber.chuysan.com/#/
- Auto trigger deploy to Netlify when `develop` branch is updated. Host: https://vtuber-qa-chuysan.netlify.app/#/

### Netlify Build Command

Build commands that run when the branch is updated are listed below.

- QA Environment

```
if cd flutter; then git pull && cd ..; else git clone https://github.com/flutter/flutter.git; fi && flutter/bin/flutter channel stable && flutter/bin/flutter upgrade && flutter/bin/flutter config --enable-web && flutter/bin/flutter build web --release --dart-define=DEPLOY_ENVIRONMENT=Qa --web-renderer html && sh update_html.sh
```

- Production Environment

```
if cd flutter; then git pull && cd ..; else git clone https://github.com/flutter/flutter.git; fi && flutter/bin/flutter channel stable && flutter/bin/flutter upgrade && flutter/bin/flutter config --enable-web && flutter/bin/flutter build web --release --dart-define=DEPLOY_ENVIRONMENT=Production --web-renderer html && sh update_html.sh
```

# Contributing

I am still learning how to develop in Flutter. Feel free to raise an issue, create a pull request or contact me at [@chuymaster](https://twitter.com/chuymaster) 😄
