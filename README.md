[![Netlify Status](https://api.netlify.com/api/v1/badges/3f342da2-0855-4157-8aa3-985a78c1bf64/deploy-status)](https://app.netlify.com/sites/vtuber-chuysan/deploys)

# thaivtuberranking-frontend

A Flutter Web client application for [Thai VTubers Directory](https://vtuber.chuysan.com/) website.

![](docs/repository-open-graph.png)

## Setup

- See Documentation on Flutter site https://flutter.dev/docs/get-started/web
- After cloning, run `fvm use` or `make init` to install Flutter 3.27.1 from `.fvm/fvm_config.json`.

## Local Command

See `Makefile`. Run `make help` to see the available commands.

Run `make run` to start the application locally.

## API Document

See https://github.com/chuymaster/thaivtuberranking-docs

## Localization

Use `L10n` helper class to localize strings. Do not use hard-coded strings.

[Translation Sheet](https://docs.google.com/spreadsheets/d/19jNewC37ThjRGWCsf2ZScjiJtmKtincxIK3l0F5XuGc/edit#gid=0)

## Automated Deployment

- Auto trigger deploy to Netlify production site when `production` branch is updated. Host: https://vtuber.chuysan.com/#/
- Auto trigger deploy to Netlify QA site when `main` branch is updated. Host: https://vtuber-qa-chuysan.netlify.app/#/

## Branch Strategy

- Use only `main` branch without long-live feature branch. ([GitHub Flow](https://www.flagship.io/git-branching-strategies/))
- PR will be generated automatically by GitHub action. Merge it to promote to `production` when ready.

## Unit Tests

This project use [mockito](https://pub.dev/packages/mockito) to generate mock classes.

`http.Client` mock is already generated but if you need to generate new mock class, read the document, add `@GenerateMocks` annotation then run `make build-mock` to generate.

See `video_ranking_repository.dart` and `video_ranking_repository_test.dart` for example of API stub implementation.

Run `flutter test` to test all cases.

### Netlify Build Command

Use the `netlify_build.sh` script for automated Netlify builds. Pass `qa` or
`production` as the first argument to build the corresponding environment.

```bash
./netlify_build.sh qa        # build QA site
./netlify_build.sh production # build production site
```

# Contributing

I am still learning how to develop in Flutter. Feel free to raise an issue, create a pull request or contact me at [@chuymaster](https://twitter.com/chuymaster) 😄
