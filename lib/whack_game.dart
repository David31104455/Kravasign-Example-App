import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhackGameScreen extends StatefulWidget {
  @override
  _WhackGameScreenState createState() => _WhackGameScreenState();
}

class _WhackGameScreenState extends State<WhackGameScreen> {
  final int gridSize = 20;
  final Random random = Random();
  int score = 0;
  int activeIndex = -1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startGameLoop();
  }

  void _startGameLoop() {
    _timer = Timer.periodic(Duration(milliseconds: 800), (_) {
      setState(() {
        activeIndex = random.nextInt(gridSize);
      });
    });
  }

  void _handleTap(int index) {
    if (index == activeIndex) {
      setState(() {
        score++;
        activeIndex = -1;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: GradientRotation(0.89),
          colors: [
            Color(0xFF1100FC),
            Color(0xFFAB0080),
            Color(0xFFD42F2F),
          ],
        ),
      ),
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 24),
                Text(
                  'Whack-a-Cow',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  'Score: $score',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      padding: const EdgeInsets.all(12),
                      children: List.generate(gridSize, (index) {
                        final isActive = index == activeIndex;
                        return GestureDetector(
                          onTap: () => _handleTap(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.pinkAccent
                                  : Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              isActive ? '🐮' : '🕳️',
                              style: TextStyle(
                                fontSize: isActive ? 26 : 20,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
