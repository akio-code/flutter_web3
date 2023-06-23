import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/config_bloc.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final _privateKeyController = TextEditingController();
  final _rpcServerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<ConfigBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('config'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: _privateKeyController,
            onChanged: (value) => configBloc.add(PrivateKeyChanged(value)),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'private key',
              suffixIcon: GestureDetector(
                onTap: _privateKeyController.clear,
                child: const Icon(Icons.clear),
              ),
            ),
          ),
          TextField(
            controller: _rpcServerController,
            onChanged: (value) => configBloc.add(RpcServerChanged(value)),
            decoration: InputDecoration(
              labelText: 'RPC server',
              suffixIcon: GestureDetector(
                onTap: _rpcServerController.clear,
                child: const Icon(Icons.clear),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: () => configBloc.add(SaveConfig()),
              child: const Text('Save'),
            ),
          ),
          BlocBuilder<ConfigBloc, ConfigState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SelectableText(
                  configBloc.state.address?.toString() ??
                      'no available address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
