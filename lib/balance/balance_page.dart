import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/web3client/bloc/web3_client_bloc.dart';
import 'package:web3dart/web3dart.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  BigInt _balance = BigInt.zero;

  double get _balanceInEther => _balance / BigInt.from(pow(10, 18));

  Future<void> _updateBalance(
    Web3Client client,
    EthPrivateKey privateKey,
  ) async {
    final balance = await client.getBalance(privateKey.address);
    setState(() {
      _balance = balance.getInWei;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Web3ClientBloc, Web3ClientState>(
      builder: (context, state) {
        final isWeb3Loaded = state.web3client != null && state.wallet != null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('balance'),
            actions: [
              IconButton(
                onPressed: isWeb3Loaded
                    ? () => _updateBalance(state.web3client!, state.wallet!)
                    : null,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  Text(
                    'ETH',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      _balanceInEther.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
