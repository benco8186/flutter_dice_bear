import 'package:flutter/material.dart';
import 'package:flutter_dice_bear/models/options.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_options.dart';
import 'package:flutter_dice_bear/styles/adventurer/adventurer_style.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_options.dart';
import 'package:flutter_dice_bear/styles/fun_emoji/fun_emoji_style.dart';
import 'package:flutter_dice_bear/widgets/dice_bear_widget.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seed = "test";
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
              Center(
                child: DiceBearWidget(
                  style: FunEmojiStyle(options: FunEmojiOptions(seed: seed)),

                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24.0),
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
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // Generate random avatar button
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
