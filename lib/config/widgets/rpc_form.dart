import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/web3client/bloc/web3_client_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class RpcForm extends StatefulWidget {
  const RpcForm({super.key});

  @override
  State<RpcForm> createState() => _RpcFormState();
}

class _RpcFormState extends State<RpcForm> {
  final _rpcServerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final web3ClientBloc = context.read<Web3ClientBloc>();

    return Column(
      children: [
        TextField(
          controller: _rpcServerController,
          decoration: InputDecoration(
            labelText: 'RCP server',
            suffixIcon: GestureDetector(
              onTap: _rpcServerController.clear,
              child: const Icon(Icons.clear),
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            web3ClientBloc.add(
              UpdateWeb3Client(
                Web3Client(_rpcServerController.text, Client()),
              ),
            );
          },
          child: const Text('Save'),
        ),
        const SizedBox(height: 24),
        BlocBuilder<Web3ClientBloc, Web3ClientState>(
          builder: (context, state) {
            return FutureBuilder(
              future: state.web3client?.getNetworkId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return SelectableText(snapshot.error.toString());
                } else if (!snapshot.hasData) {
                  return const Text('no RCP server');
                } else {
                  return SelectableText(
                    snapshot.data.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
