import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web3dart/web3dart.dart';

import '../erc20.g.dart';

part 'erc20_event.dart';
part 'erc20_state.dart';

class Erc20Bloc extends Bloc<Erc20Event, Erc20State> {
  Erc20Bloc() : super(Erc20State()) {
    on<SaveContractAddress>(_handleSaveContactAddress);
  }

  Future<FutureOr<void>> _handleSaveContactAddress(
    SaveContractAddress event,
    Emitter<Erc20State> emit,
  ) async {
    final chainId = await event.web3client.getChainId();

    emit(
      Erc20State(
        erc20: Erc20(
          address: EthereumAddress.fromHex(event.address),
          client: event.web3client,
          chainId: chainId.toInt(),
        ),
      ),
    );
  }
}
