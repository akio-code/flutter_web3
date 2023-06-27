import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/web3client/bloc/web3_client_bloc.dart';
import 'package:web3dart/web3dart.dart';

class WalletForm extends StatefulWidget {
  const WalletForm({super.key});

  @override
  State<WalletForm> createState() => _WalletFormState();
}

class _WalletFormState extends State<WalletForm> {
  final _privateKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final web3ClientBloc = context.read<Web3ClientBloc>();

    return Column(
      children: [
        TextField(
          controller: _privateKeyController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'private key',
            suffixIcon: GestureDetector(
              onTap: _privateKeyController.clear,
              child: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            web3ClientBloc.add(
              UpdateWallet(
                EthPrivateKey.fromHex(_privateKeyController.text),
              ),
            );
          },
          child: const Text('Save'),
        ),
        const SizedBox(height: 24),
        BlocBuilder<Web3ClientBloc, Web3ClientState>(
          builder: (context, state) {
            return SelectableText(
              state.wallet?.address.hexEip55 ?? 'no available address',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            );
          },
        ),
      ],
    );
  }
}
