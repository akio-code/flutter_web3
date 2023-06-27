part of 'web3_client_bloc.dart';

class Web3ClientState {
  Web3ClientState({
    this.web3client,
    this.wallet,
  });

  final Web3Client? web3client;
  final EthPrivateKey? wallet;

  Web3ClientState copyWith({
    Web3Client? web3client,
    EthPrivateKey? wallet,
  }) {
    return Web3ClientState(
      web3client: web3client ?? this.web3client,
      wallet: wallet ?? this.wallet,
    );
  }
}
