import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tuto/cubits/dota_cards_cubit.dart';

import '../repositories/in_memory_dota_cards_repository.dart';
import '../widgets/app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cards/cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider creates the cubit and makes it available
    // to every widget below it in the tree.
    // MultiBlocProvider avoids nesting several BlocProvider.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DotaCardsCubit(InMemoryDotaCardsRepository())..load(),
        ),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic page structure
    // (and its own Material surface).
    return Scaffold(
      // The burger menu, opened from DotaTopBar on small screens.
      drawer: const AppDrawer(),
      // DecoratedBox paints a decoration (here a gradient) behind its child.
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1C2028), // dark slate grey
              Color(0xFF050607), // almost black
            ],
          ),
        ),
        // Column is a vertical, linear layout.
        child: Column(
          children: [
            DotaTopBar(
              title: Text(
                'Flutter Dota',
                style:
                    Theme.of(context) //
                        .primaryTextTheme
                        .titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            // A grid inside a Column must be given a bounded height: Expanded.
            const Expanded(child: DotaCards()),
          ],
        ),
      ),
    );
  }
}
