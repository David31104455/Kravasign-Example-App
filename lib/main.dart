import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'whack_game.dart';
import 'help_screen.dart';
void main() => runApp(KravasignApp());

class KravasignApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Kravasign Test',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: CupertinoColors.black,
      ),
      home: MainNavigation(),
    );
  }
}


class MainNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black.withOpacity(0.05),
        activeColor: CupertinoColors.white,
        inactiveColor: CupertinoColors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠', style: TextStyle(fontSize: 20)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('🐮', style: TextStyle(fontSize: 20)),
            label: 'Whack-a-Cow',
          ),
          BottomNavigationBarItem(
            icon: Text('❔', style: TextStyle(fontSize: 20)),
            label: 'Help',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            Widget child;
            switch (index) {
              case 0:
                child = HomeScreen();
                break;
              case 1:
                child = WhackGameScreen();
                break;
              case 2:
                child = HelpScreen();
                break;
              default:
                child = Center(child: Text("Unknown tab"));
            }
            return Stack(
              children: [
                child,
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          height: 80,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
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
                  SizedBox(height: 80),
                  Text(
                    'Kravasign Test',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'If you can see this, your Kravasign certificate is working. While waiting, feel free to install your sideloaded apps or play Whack-a-Cow.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
