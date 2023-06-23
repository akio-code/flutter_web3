import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:web3dart/web3dart.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc()
      : super(
          ConfigState(privateKey: '', rpcServer: ''),
        ) {
    on<PrivateKeyChanged>(_handlePrivateKeyChanged);
    on<RpcServerChanged>(_handleRpcServerChanged);
    on<SaveConfig>(_handleSaveConfig);
  }

  FutureOr<void> _handlePrivateKeyChanged(
    PrivateKeyChanged event,
    Emitter<ConfigState> emit,
  ) {
    emit(
      state.copyWith(
        privateKey: event.value,
      ),
    );
  }

  FutureOr<void> _handleRpcServerChanged(
    RpcServerChanged event,
    Emitter<ConfigState> emit,
  ) {
    emit(
      state.copyWith(
        rpcServer: event.value,
      ),
    );
  }

  FutureOr<void> _handleSaveConfig(
    SaveConfig event,
    Emitter<ConfigState> emit,
  ) {
    final web3client = Web3Client(state.privateKey, Client());
    final credentials = EthPrivateKey.fromHex(state.privateKey);
    final address = credentials.address;

    emit(
      state.copyWith(
        web3client: web3client,
        address: address,
      ),
    );
  }
}
