import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web3dart/web3dart.dart';

part 'web3_client_event.dart';
part 'web3_client_state.dart';

class Web3ClientBloc extends Bloc<Web3ClientEvent, Web3ClientState> {
  Web3ClientBloc() : super(Web3ClientState()) {
    on<UpdateWeb3Client>(_handleUpdateWeb3Client);
    on<UpdateWallet>(_handleUpdateWallet);
  }

  FutureOr<void> _handleUpdateWeb3Client(
    UpdateWeb3Client event,
    Emitter<Web3ClientState> emit,
  ) {
    log('Updating Web3Client');
    emit(
      state.copyWith(
        web3client: event.client,
      ),
    );
  }

  FutureOr<void> _handleUpdateWallet(
    UpdateWallet event,
    Emitter<Web3ClientState> emit,
  ) {
    log('Updating wallet');
    emit(
      state.copyWith(
        wallet: event.wallet,
      ),
    );
  }
}
