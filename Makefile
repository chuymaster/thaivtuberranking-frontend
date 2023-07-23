help: # Display help
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'

run: # Run application in debug environment
	flutter run -d chrome --web-renderer html

run-qa: # Run application in QA environment
	flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Qa --web-renderer html

run-prod: # Run application in production environment
	flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Production --web-renderer html

build-for-release: # Build the app for release
	flutter build web --release --web-renderer html

build-mock: # Generate http mocks
	flutter pub run build_runner build

upgrade-major: # upgrade major versions of pub
	flutter pub upgrade --major-versions
