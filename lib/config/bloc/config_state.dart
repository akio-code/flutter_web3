part of 'config_bloc.dart';

class ConfigState {
  ConfigState({
    required this.privateKey,
    required this.rpcServer,
    this.web3client,
    this.address,
  });

  final String privateKey;
  final String rpcServer;
  final Web3Client? web3client;
  final EthereumAddress? address;

  ConfigState copyWith({
    String? privateKey,
    String? rpcServer,
    Web3Client? web3client,
    EthereumAddress? address,
  }) {
    return ConfigState(
      privateKey: privateKey ?? this.privateKey,
      rpcServer: rpcServer ?? this.rpcServer,
      web3client: web3client ?? this.web3client,
      address: address ?? this.address,
    );
  }
}
