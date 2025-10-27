
# Trips Web (Flutter)

Clean Architecture + Riverpod + MVVM. Uses `assets/data/trips_mock.json` as local source.

## Run
```bash
flutter pub get
flutter run -d chrome
```

## Build Web
```bash
flutter build web --release --web-renderer canvaskit
```

## Deploy to Firebase
```bash
npm i -g firebase-tools
firebase login
firebase init hosting   # Public directory: build/web, single page app: y
firebase deploy --only hosting
```
