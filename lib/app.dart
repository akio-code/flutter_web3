import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/balance/balance_page.dart';
import 'package:flutter_rental_blockchain/config/bloc/config_bloc.dart';
import 'package:flutter_rental_blockchain/config/config_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _pageController = PageController();
  int _currentIndex = 1;

  void _navigateToPage(int index) {
    _updatePageIndex(index);
    _pageController.animateToPage(
      index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _updatePageIndex(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigBloc>(
      create: (context) => ConfigBloc(),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _updatePageIndex,
          children: const [
            BalancePage(),
            ConfigPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _navigateToPage,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              label: 'Balance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Config',
            ),
          ],
        ),
      ),
    );
  }
}
