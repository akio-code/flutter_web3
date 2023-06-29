import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/bloc/erc20_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/erc20.g.dart';
import 'package:flutter_rental_blockchain/web3client/bloc/web3_client_bloc.dart';
import 'package:web3dart/credentials.dart';

class BalanceForm extends StatefulWidget {
  const BalanceForm({super.key});

  @override
  State<BalanceForm> createState() => _BalanceFormState();
}

class _BalanceFormState extends State<BalanceForm> {
  final _balanceOfController = TextEditingController();

  BigInt _balance = BigInt.zero;

  Future<void> _balanceOf(Erc20 erc20) async {
    final balance = await erc20.balanceOf(
      EthereumAddress.fromHex(_balanceOfController.text),
    );
    _balance = balance;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: _balanceOfController,
            decoration: InputDecoration(
              labelText: 'balance of',
              suffixIcon: IconButton(
                onPressed: _balanceOfController.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<Web3ClientBloc, Web3ClientState>(
            builder: (context, web3State) {
              return BlocBuilder<Erc20Bloc, Erc20State>(
                builder: (context, erc20State) {
                  return TextButton(
                    onPressed:
                        web3State.wallet != null && erc20State.erc20 != null
                            ? () => _balanceOf(erc20State.erc20!)
                            : null,
                    child: const Text('balance'),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Text('balance $_balance'),
        ],
      ),
    );
  }
}
