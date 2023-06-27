part of 'web3_client_bloc.dart';

@immutable
abstract class Web3ClientEvent {}

class UpdateWeb3Client extends Web3ClientEvent {
  UpdateWeb3Client(this.client);

  final Web3Client client;
}

class UpdateWallet extends Web3ClientEvent {
  UpdateWallet(this.wallet);

  final EthPrivateKey wallet;
}
