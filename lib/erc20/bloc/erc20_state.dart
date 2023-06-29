part of 'erc20_bloc.dart';

class Erc20State {
  Erc20State({
    this.erc20,
    this.events,
  });

  final Erc20? erc20;
  final StreamSubscription<Transfer>? events;
}
