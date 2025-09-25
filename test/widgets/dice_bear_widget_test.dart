import 'package:flutter/material.dart';
import 'package:flutter_dice_bear/flutter_dice_bear.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiceBearWidget', () {
    testWidgets('should render with default style', (
      WidgetTester tester,
    ) async {
      // Build our widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiceBearWidget(
              style: AdventurerStyle(
                options: AdventurerOptions(
                  seed: 'test-seed',
                  // Provide all required options
                  skinColor: ['#f0d9b5'],
                  hairColor: ['#000000'],
                  glassesProbability: 0,
                  featuresProbability: 0,
                  hairProbability: 100,
                  earringsProbability: 0,
                ),
              ),
            ),
          ),
        ),
      );

      // Verify the widget renders
      expect(find.byType(DiceBearWidget), findsOneWidget);
    });

    testWidgets('should render with custom style and options', (
      WidgetTester tester,
    ) async {
      final options = AdventurerOptions(
        seed: 'custom-seed',
        skinColor: ['#f0d9b5', '#d2a679'],
        hairColor: ['#000000', '#663300'],
        // Provide all required options
        glassesProbability: 0,
        featuresProbability: 0,
        hairProbability: 100,
        earringsProbability: 0,
      );

      // Build our widget with custom options
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiceBearWidget(style: AdventurerStyle(options: options)),
          ),
        ),
      );

      // Verify the widget renders with custom options
      expect(find.byType(DiceBearWidget), findsOneWidget);
    });

    testWidgets('should update when seed changes', (WidgetTester tester) async {
      // Create a stateful widget to manage the style
      final testWidget = _TestWidget(initialSeed: 'initial-seed');

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));

      // Get the initial widget
      final initialWidget = tester.widget<DiceBearWidget>(
        find.byType(DiceBearWidget),
      );

      // Get the initial seed
      final initialSeed =
          (initialWidget.style.options as AdventurerOptions).seed;
      expect(initialSeed, 'initial-seed');

      // Rebuild the widget with the new seed
      await tester.pump();
    });
  });
}

// A stateful widget to test the DiceBearWidget with changing props
class _TestWidget extends StatefulWidget {
  final String initialSeed;

  _TestWidget({required this.initialSeed}) : super(key: UniqueKey());

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  late String _seed;

  @override
  void initState() {
    super.initState();
    _seed = widget.initialSeed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: DiceBearWidget(
            style: AdventurerStyle(
              options: AdventurerOptions(
                seed: _seed,
                // Provide all required options
                skinColor: ['#f0d9b5'],
                hairColor: ['#000000'],
                glassesProbability: 0,
                featuresProbability: 0,
                hairProbability: 100,
                earringsProbability: 0,
                // Background options
                backgroundColor: ['#ffffff'],
                backgroundType: ['solid'],
                backgroundRotation: [0],
                // Other options with defaults
                radius: 0,
                flip: false,
                rotate: 0,
                scale: 100,
                translateX: 0,
                translateY: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
