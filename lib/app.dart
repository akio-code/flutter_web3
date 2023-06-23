import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/config/bloc/config_bloc.dart';
import 'package:flutter_rental_blockchain/config/config_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigBloc>(
      create: (context) => ConfigBloc(),
      child: Navigator(
        initialRoute: "/config",
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    final route = settings.name;

    if (route == "/config") {
      return CupertinoPageRoute(
        builder: (context) => const ConfigPage(),
      );
    }

    return null;
  }
}
