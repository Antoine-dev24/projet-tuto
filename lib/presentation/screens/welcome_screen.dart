import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/widgets/app_bar.dart';
import 'package:projet_tuto/presentation/widgets/app_drawer.dart';
import 'package:projet_tuto/presentation/widgets/welcome/hero_section.dart';
import 'package:projet_tuto/presentation/widgets/welcome/how_it_works_section.dart';
import 'package:projet_tuto/presentation/widgets/welcome/join_section.dart';
import 'package:projet_tuto/presentation/widgets/welcome/section.dart';
import 'package:projet_tuto/presentation/widgets/welcome/verification_section.dart';

// Landing page of the league: four sections stacked in one scroll.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Marks the "how it works" section so the hero button can scroll to it.
  // static is fine here: only one welcome page exists at a time
  // (AppRoutes.go never pushes a second one).
  static final _howItWorksKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WelcomeColors.background,
      // The burger menu, opened from DotaTopBar on small screens.
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const DotaTopBar(),
          // The page itself takes all the space left under the bar,
          // and scrolls as a whole.
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeroSection(
                    // ensureVisible scrolls until the widget
                    // holding this key is on screen.
                    onDiscover: () => Scrollable.ensureVisible(
                      _howItWorksKey.currentContext!,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  HowItWorksSection(key: _howItWorksKey),
                  const VerificationSection(),
                  const JoinSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
