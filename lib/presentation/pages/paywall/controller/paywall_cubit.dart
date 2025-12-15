import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../data/models/subscription_model.dart';
import '../../../../domain/entity/subscription_entity.dart';
import '../../../../domain/repository/local_storage_repository.dart';

part 'paywall_state.dart';

class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit({required this.localStorageRepository})
    : super(PaywallInitial());

  final ILocalStorageRepository localStorageRepository;

  Future<void> buySubscForMonth({required int monthAmount}) async {
    try {
      if (monthAmount / 12 >= 1) {
        final sub = SubscriptionModel(
          name: 'Year',
          price: '1000',
          duration: '$monthAmount months',
        );
        await localStorageRepository.saveSubscription(sub);
        emit(PaywallBuyed(subscriptionBuyed: sub));
      } else {
        final sub = SubscriptionModel(
          name: 'Month',
          price: '100',
          duration: '1 month',
        );
        await localStorageRepository.saveSubscription(sub);
        emit(PaywallBuyed(subscriptionBuyed: sub));
      }
    } catch (e) {
      emit(PaywallError(error: e.toString()));
    }
  }

  Future<void> checkSubscription() async {
    try {
      final sub = await localStorageRepository.getSubscription();
      if (sub != null) {
        emit(PaywallBuyed(subscriptionBuyed: sub));
      } else {
        emit(PaywallInitial());
      }
    } catch (e) {
      emit(PaywallError(error: e.toString()));
    }
  }
}
