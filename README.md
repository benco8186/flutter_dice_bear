# Flutter DiceBear

[![pub package](https://img.shields.io/pub/v/flutter_dice_bear.svg)](https://pub.dev/packages/flutter_dice_bear)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter implementation of the [DiceBear](https://dicebear.com/) avatar library. Create beautiful, customizable avatars for your Flutter applications.

## Features

- Generate customizable avatars in different styles
- Lightweight and fast
- Null-safety support
- Easy to integrate and use

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_dice_bear: ^1.0.0
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dice_bear/flutter_dice_bear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter DiceBear Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DiceBearWidget(
              style: AdventurerStyle(
                options: AdventurerOptions(
                  seed: 'custom-seed',
                ),
              ),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Regenerate avatar with new seed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
              child: const Text('Generate New Avatar'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Available Styles

### Adventurer

```dart
const style = AdventurerStyle(
  options: AdventurerOptions(
    seed: 'unique-seed',
    backgroundColor: Colors.blue,
    // Other options...
  ),
);
```

### Fun Emoji

```dart
const style = FunEmojiStyle(
  options: FunEmojiOptions(
    seed: 'custom-seed',
    // Other options...
  ),
);
```

## Customization Options

### Common Options

- `seed` (String): String used to generate the avatar
- `size` (double?): The size of the avatar in pixels
- `scale` (double?): The scale of the avatar as a percentage (0-100)
- `flip` (bool): Whether to flip the avatar horizontally (default: false)
- `rotate` (double?): The rotation of the avatar in degrees
- `backgroundColor` (List<String>?): The background color(s) of the avatar
- `backgroundType` (List<String>?): The type of background (e.g., 'solid', 'gradient')
- `backgroundRotation` (List<int>?): The rotation of the background in degrees
- `translateX` (double?): The horizontal translation of the avatar
- `translateY` (double?): The vertical translation of the avatar
- `radius` (double?): The border radius of the avatar
- `clip` (bool?): Whether to clip the avatar to a circle
- `randomizeIds` (bool): Whether to randomize the IDs used in the SVG (default: false)

## API Reference

### DiceBearWidget

The main widget that displays the avatar.

```dart
DiceBearWidget({
  required AvatarStyle style,
  double? width,
  double? height,
  BoxFit fit = BoxFit.contain,
  WidgetBuilder? placeholderBuilder,
})
```

### DiceBearProvider

A provider that can be used to display avatar SVGs in an `Image` widget.

```dart
// First, generate an avatar result
final avatarResult = AvatarGenerator(
  style: const AdventurerStyle(
    options: AdventurerOptions(seed: 'custom-seed'),
  ),
).generate();

// Create a provider instance
final provider = DiceBearProvider(
  avatarResult: avatarResult,
);

// Use with an Image widget
Image(image: provider);
```

#### Parameters

- `avatarResult` (required): The `AvatarResult` containing the SVG data

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

This package is inspired by the original [DiceBear](https://dicebear.com/) project.

---

Made with ❤️ by Benco
