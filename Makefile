help: # Display help
       @grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'

init: # Install FVM and Flutter
       dart pub global activate fvm && fvm install && fvm flutter config --enable-web

run: # Run application in debug environment
       fvm flutter run -d chrome --web-renderer html

run-qa: # Run application in QA environment
       fvm flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Qa --web-renderer html

run-prod: # Run application in production environment
       fvm flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Production --web-renderer html

build-for-release: # Build the app for release
       fvm flutter build web --release --web-renderer html

build-qa: # Build QA environment
       fvm flutter build web --release --dart-define=DEPLOY_ENVIRONMENT=Qa --web-renderer html

build-release: # Build production environment
       fvm flutter build web --release --dart-define=DEPLOY_ENVIRONMENT=Production --web-renderer html

build-mock: # Generate http mocks
       fvm flutter pub run build_runner build

upgrade-major: # upgrade major versions of pub
       fvm flutter pub upgrade --major-versions
