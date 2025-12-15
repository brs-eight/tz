part of 'paywall_cubit.dart';

@immutable
sealed class PaywallState {}

final class PaywallInitial extends PaywallState {}

class PaywallError extends PaywallState {
  final String error;

  PaywallError({required this.error});
}

class PaywallBuyed extends PaywallState {
  final ISubscription subscriptionBuyed;

  PaywallBuyed({required this.subscriptionBuyed});
}
