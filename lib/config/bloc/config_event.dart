part of 'config_bloc.dart';

@immutable
abstract class ConfigEvent {}

class PrivateKeyChanged extends ConfigEvent {
  PrivateKeyChanged(this.value);

  final String value;
}

class RpcServerChanged extends ConfigEvent {
  RpcServerChanged(this.value);

  final String value;
}

class SaveConfig extends ConfigEvent {}
