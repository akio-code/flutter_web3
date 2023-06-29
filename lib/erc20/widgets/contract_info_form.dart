import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/bloc/erc20_bloc.dart';
import 'package:flutter_rental_blockchain/web3client/bloc/web3_client_bloc.dart';

class ContractInfo extends StatefulWidget {
  const ContractInfo({super.key});

  @override
  State<ContractInfo> createState() => _ContractInfoState();
}

class _ContractInfoState extends State<ContractInfo> {
  final _contractAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final web3ClientBloc = context.read<Web3ClientBloc>();
    final erc20Bloc = context.read<Erc20Bloc>();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: _contractAddress,
            decoration: InputDecoration(
              labelText: 'ERC20 contract address',
              suffixIcon: IconButton(
                onPressed: _contractAddress.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<Web3ClientBloc, Web3ClientState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.web3client != null
                    ? () {
                        erc20Bloc.add(
                          SaveContractAddress(
                            _contractAddress.text,
                            web3ClientBloc.state.web3client!,
                          ),
                        );
                      }
                    : null,
                child: const Text('Read'),
              );
            },
          ),
          const SizedBox(height: 24),
          const _ContractInfo(),
        ],
      ),
    );
  }
}

class _ContractInfo extends StatelessWidget {
  const _ContractInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Erc20Bloc, Erc20State>(
      builder: (context, state) {
        if (state.erc20 == null) {
          return const Text('no contract loaded');
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: state.erc20!.name(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Text('name: ${snapshot.data.toString()}');
                  }
                },
              ),
              FutureBuilder(
                future: state.erc20!.totalSupply(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    final totalSupply =
                        snapshot.data! / BigInt.from(pow(10, 6));
                    return Text('total supply: $totalSupply');
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }
}
