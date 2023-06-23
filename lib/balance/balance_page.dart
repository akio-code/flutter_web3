import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/config/bloc/config_bloc.dart';
import 'package:web3dart/web3dart.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  void getBalance() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('balance'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  'ETH',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Expanded(
                child: BlocBuilder<ConfigBloc, ConfigState>(
                  builder: (context, state) {
                    if (state.web3client == null || state.address == null) {
                      return const Text('web3 client not initialized');
                    } else {
                      return FutureBuilder<EtherAmount>(
                        future: state.web3client?.getBalance(state.address!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return SelectableText(
                              'an error has occurred: ${snapshot.error}',
                            );
                          } else {
                            return SelectableText(
                              '${snapshot.data!.getInWei / BigInt.from(pow(10, 18))}',
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.right,
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
