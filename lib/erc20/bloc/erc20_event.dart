part of 'erc20_bloc.dart';

@immutable
abstract class Erc20Event {}

class SaveContractAddress extends Erc20Event {
  SaveContractAddress(this.address, this.web3client);

  final String address;
  final Web3Client web3client;
}
