# Update main.dart.js version to current datetime
today=$(date +%Y%m%d%H%M%S)

## for OS X
# sed -i ".bak" "s/main.dart.js/main.dart.js?version=${today}/g" "build/web/index.html"

## for Linux
sed -i "s/main.dart.js/main.dart.js?version=${today}/g" "build/web/index.html"