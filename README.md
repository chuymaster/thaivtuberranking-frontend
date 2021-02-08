[![Netlify Status](https://api.netlify.com/api/v1/badges/3f342da2-0855-4157-8aa3-985a78c1bf64/deploy-status)](https://app.netlify.com/sites/vtuber-chuysan/deploys)

# thaivtuberranking-frontend

A Flutter Web project. [Project Portal](https://www.notion.so/Thai-VTuber-Ranking-79d4f27e65214eab9fec4461f83baa77)

## Web Client

### Setup

- Flutter Web https://flutter.dev/docs/get-started/web

### Flutter Web Local Test

- Debug environment
`flutter run -d chrome`

- QA environment 
 `flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Qa`

- Production environment
 `flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Production`

### Frontend Applications
- Auto trigger deploy to Netlify when `main` branch is updated. Host: https://vtuber.chuysan.com/#/
- Auto trigger deploy to Netlify when `develop` branch is updated. Host: https://vtuber-qa-chuysan.netlify.app/#/