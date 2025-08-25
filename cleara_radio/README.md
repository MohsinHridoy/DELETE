# Cleara Radio

Minimal radio streaming app inspired by the provided mock.

Features:
- Drawer with sections
- Central oval cover image
- Large bottom play/pause control
- Streaming via `just_audio`

## Run

```bash
cd /workspace/cleara_radio
flutter pub get
flutter run -d linux   # or chrome/android/ios if configured
```

## Change stream URL

Edit `lib/main.dart` and update:

```dart
const String kDefaultStream = 'https://your-station/stream.mp3';
```

## Notes

- Internet permission added in `android/app/src/main/AndroidManifest.xml`.
- On first play the app initializes the audio session and buffers the stream.