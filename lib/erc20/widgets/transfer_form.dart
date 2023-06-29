import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/bloc/erc20_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/erc20.g.dart';
import 'package:flutter_rental_blockchain/web3client/bloc/web3_client_bloc.dart';
import 'package:web3dart/credentials.dart';

class TransferForm extends StatefulWidget {
  const TransferForm({super.key});

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final _toAddressController = TextEditingController();
  final _amountController = TextEditingController();

  Future<void> _transfer(Erc20 erc20, EthPrivateKey wallet) async {
    final txId = await erc20.transfer(
      EthereumAddress.fromHex(_toAddressController.text),
      BigInt.from(int.parse(_amountController.text)),
      credentials: wallet,
    );
    log(txId);
  }

  Future<void> _mint(Erc20 erc20, EthPrivateKey wallet) async {
    final txId = await erc20.mint(
      EthereumAddress.fromHex(_toAddressController.text),
      BigInt.from(int.parse(_amountController.text)),
      credentials: wallet,
    );
    log(txId);
  }

  @override
  Widget build(BuildContext context) {
    final web3ClientBloc = context.read<Web3ClientBloc>();
    final erc20Bloc = context.read<Erc20Bloc>();

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        TextField(
          controller: _toAddressController,
          decoration: InputDecoration(
            labelText: 'to',
            suffixIcon: IconButton(
              onPressed: _toAddressController.clear,
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _amountController,
          decoration: InputDecoration(
            labelText: 'amount',
            suffixIcon: IconButton(
              onPressed: _amountController.clear,
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            TextButton(
              onPressed: web3ClientBloc.state.wallet != null
                  ? () => _transfer(
                        erc20Bloc.state.erc20!,
                        web3ClientBloc.state.wallet!,
                      )
                  : null,
              child: const Text('Transfer'),
            ),
            TextButton(
              onPressed: web3ClientBloc.state.wallet != null
                  ? () => _mint(
                        erc20Bloc.state.erc20!,
                        web3ClientBloc.state.wallet!,
                      )
                  : null,
              child: const Text('Mint'),
            ),
          ],
        ),
      ],
    );
  }
}
