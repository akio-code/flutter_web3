import 'package:flutter/material.dart';
import 'package:flutter_rental_blockchain/config/widgets/rpc_form.dart';
import 'package:flutter_rental_blockchain/config/widgets/wallet_form.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('config'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          RpcForm(),
          Divider(height: 64),
          WalletForm(),
        ],
      ),
    );
  }
}
