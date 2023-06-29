import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/bloc/erc20_bloc.dart';
import 'package:flutter_rental_blockchain/erc20/widgets/balance_form.dart';
import 'package:flutter_rental_blockchain/erc20/widgets/contract_info_form.dart';
import 'package:flutter_rental_blockchain/erc20/widgets/events.dart';
import 'package:flutter_rental_blockchain/erc20/widgets/transfer_form.dart';
import 'package:flutter_rental_blockchain/web3client/bloc/web3_client_bloc.dart';

class ERC20Page extends StatefulWidget {
  const ERC20Page({super.key});

  @override
  State<ERC20Page> createState() => _ERC20PageState();
}

class _ERC20PageState extends State<ERC20Page>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<Web3ClientBloc, Web3ClientState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => Erc20Bloc(),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('ERC20'),
                bottom: const TabBar(
                  tabs: [
                    Tab(child: Text('info')),
                    Tab(child: Text('transfer')),
                    Tab(child: Text('events')),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ListView(
                    children: const [
                      ContractInfo(),
                      Divider(),
                      BalanceForm(),
                    ],
                  ),
                  const TransferForm(),
                  const Erc20Events(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
