help: # Display help
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'

init: # Install FVM and Flutter
	dart pub global activate fvm && fvm install && fvm flutter config --enable-web

run: # Run application in debug environment
	fvm flutter run -d chrome

run-qa: # Run application in QA environment
	fvm flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Qa

run-prod: # Run application in production environment
	fvm flutter run -d chrome --dart-define=DEPLOY_ENVIRONMENT=Production

build-qa: # Build QA environment
	fvm flutter build web --release --dart-define=DEPLOY_ENVIRONMENT=Qa

build-production: # Build production environment
	fvm flutter build web --release --dart-define=DEPLOY_ENVIRONMENT=Production

build-mock: # Generate http mocks
	fvm flutter pub run build_runner build

upgrade-major: # upgrade major versions of pub
	fvm flutter pub upgrade --major-versions

# ==================== Next.js ====================

nextjs-install: # Install Next.js dependencies
	cd nextjs-app && npm install

nextjs-dev: # Run Next.js in development mode
	cd nextjs-app && npm run dev

nextjs-dev-qa: # Run Next.js in QA mode
	cd nextjs-app && npm run dev:qa

nextjs-build-qa: # Build Next.js for QA
	cd nextjs-app && npm run build:qa

nextjs-build-prod: # Build Next.js for production
	cd nextjs-app && npm run build:prod

nextjs-start: # Start Next.js production server
	cd nextjs-app && npm run start
