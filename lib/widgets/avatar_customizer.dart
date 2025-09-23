import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_dice_bear/styles/smiley/smiley_options.dart';

/// A widget that provides controls for customizing a Smiley avatar
class AvatarCustomizer extends StatefulWidget {
  final ValueChanged<SmileyOptions> onOptionsChanged;
  final SmileyOptions initialOptions;

  const AvatarCustomizer({
    super.key,
    required this.onOptionsChanged,
    required this.initialOptions,
  });

  @override
  State<AvatarCustomizer> createState() => _AvatarCustomizerState();
}

class _AvatarCustomizerState extends State<AvatarCustomizer> {
  late SmileyOptions _options;

  @override
  void initState() {
    super.initState();
    _options = widget.initialOptions;
  }

  @override
  void didUpdateWidget(covariant AvatarCustomizer oldWidget) {
    _options = widget.initialOptions;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Face Color Picker
        ListTile(
          title: const Text('Face Color'),
          trailing: ColorPickerButton(
            color: Color(_parseColor(_options.faceColor)),
            onColorChanged: (color) {
              setState(() {
                _options = _options.copyWith(
                  faceColor: '#${color.value.toRadixString(16).substring(2)}',
                );
                widget.onOptionsChanged(_options);
              });
            },
          ),
        ),

        // Feature Color Picker
        ListTile(
          title: const Text('Feature Color'),
          trailing: ColorPickerButton(
            color: Color(_parseColor(_options.featureColor)),
            onColorChanged: (color) {
              setState(() {
                _options = _options.copyWith(
                  featureColor:
                      '#${color.value.toRadixString(16).substring(2)}',
                );
                widget.onOptionsChanged(_options);
              });
            },
          ),
        ),

        // Mood Toggle
        SwitchListTile(
          title: Text(_options.isHappy ? 'Happy 😊' : 'Sad 😢'),
          value: _options.isHappy,
          onChanged: (value) {
            setState(() {
              _options = _options.copyWith(isHappy: value);
              widget.onOptionsChanged(_options);
            });
          },
        ),

        // Glasses Toggle
        SwitchListTile(
          title: const Text('Glasses 👓'),
          value: _options.hasGlasses,
          onChanged: (value) {
            setState(() {
              _options = _options.copyWith(hasGlasses: value);
              widget.onOptionsChanged(_options);
            });
          },
        ),
      ],
    );
  }

  int _parseColor(String color) {
    String hexColor = color.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

/// A button that shows a color picker dialog
class ColorPickerButton extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerButton({
    Key? key,
    required this.color,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showColorPicker(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }

  Future<void> _showColorPicker(BuildContext context) async {
    final Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: color,
              onColorChanged: onColorChanged,
              labelTypes: const [],
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop(color);
              },
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      onColorChanged(pickedColor);
    }
  }
}
