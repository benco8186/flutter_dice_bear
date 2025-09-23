import 'package:flutter/material.dart';
import 'package:flutter_dice_bear/styles/smiley/smiley_options.dart';
import 'package:flutter_dice_bear/widgets/avatar_customizer.dart';
import 'package:flutter_dice_bear/widgets/avatar_widget.dart';

void main() {
  runApp(const DiceBearApp());
}

class DiceBearApp extends StatelessWidget {
  const DiceBearApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiceBear Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AvatarScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  late SmileyOptions _options;
  final _avatarKey = GlobalKey<AvatarWidgetState>();

  @override
  void initState() {
    super.initState();
    _options = const SmileyOptions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DiceBear Flutter'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar display
              Center(
                child: AvatarWidget(
                  key: _avatarKey,
                  seed: 'dicebear-flutter',
                  size: 200.0,
                  options: _options,
                ),
              ),
              const SizedBox(height: 32.0),

              // Customization controls
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Customize Avatar',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      AvatarCustomizer(
                        onOptionsChanged: (options) => setState(() {
                          _options = options;
                        }),
                        initialOptions: _options,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // Generate random avatar button
              ElevatedButton.icon(
                onPressed: _generateRandomAvatar,
                icon: const Icon(Icons.refresh),
                label: const Text('Generate Random Avatar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),

              const SizedBox(height: 16.0),

              // Export button
              OutlinedButton.icon(
                onPressed: _exportAvatar,
                icon: const Icon(Icons.save_alt),
                label: const Text('Export Avatar'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateRandomAvatar() {
    setState(() {
      _options = SmileyOptions(
        faceColor: _getRandomColor(),
        featureColor: _getRandomColor(),
        isHappy: DateTime.now().millisecond % 2 == 0,
        hasGlasses: DateTime.now().second % 2 == 0,
      );
    });
  }

  String _getRandomColor() {
    final colors = [
      '#FF0000', // Red
      '#00FF00', // Green
      '#0000FF', // Blue
      '#FFFF00', // Yellow
      '#FF00FF', // Magenta
      '#00FFFF', // Cyan
      '#FFA500', // Orange
      '#800080', // Purple
      '#008000', // Dark Green
      '#000080', // Navy
    ];
    return colors[DateTime.now().millisecondsSinceEpoch % colors.length];
  }

  void _exportAvatar() {
    // In a real app, you would implement the export functionality here
    // For now, we'll just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export functionality would be implemented here'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
