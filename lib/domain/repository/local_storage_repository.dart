import '../entity/subscription_entity.dart';

abstract class ILocalStorageRepository {
  Future<void> init();
  Future<void> saveSubscription(ISubscription subscription);
  Future<ISubscription?> getSubscription();
  Future<void> clearSubscription();
}
