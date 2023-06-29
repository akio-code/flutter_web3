import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/bloc/erc20_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/erc20.g.dart';

class Erc20Events extends StatefulWidget {
  const Erc20Events({super.key});

  @override
  State<Erc20Events> createState() => _Erc20EventsState();
}

class _Erc20EventsState extends State<Erc20Events>
    with AutomaticKeepAliveClientMixin {
  final List<Transfer> _transfers = [];
  StreamSubscription<Transfer>? _subscription;

  void _addTransfer(Transfer transfer) {
    _transfers.insert(0, transfer);
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<Erc20Bloc, Erc20State>(
      builder: (context, state) {
        if (_subscription == null) {
          final erc20 = state.erc20;
          _subscription = erc20?.transferEvents().listen(_addTransfer);
        }

        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          itemCount: _transfers.length,
          itemBuilder: (BuildContext context, int index) {
            return _Card(_transfers[index], index);
          },
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(
    this._transfer,
    this._index, {
    super.key,
  });

  final int _index;
  final Transfer _transfer;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<Erc20Bloc, Erc20State>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('transfer #$_index'),
                const SizedBox(height: 8),
                SelectableText(
                  '${_transfer.event.transactionHash}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('value: '),
                    Expanded(
                      child: SelectableText(
                        '${_transfer.value}',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(overflow: TextOverflow.fade),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  children: [
                    const Text('from: '),
                    SelectableText(
                      '${_transfer.from}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  children: [
                    const Text('to: '),
                    SelectableText(
                      '${_transfer.to}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
