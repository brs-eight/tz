import 'package:hive/hive.dart';
import '../../domain/entity/subscription_entity.dart';
import '../../domain/repository/local_storage_repository.dart';
import '../models/subscription_model.dart';

class HiveLocalStorageRepository implements ILocalStorageRepository {
  static const String _boxName = 'subscription_box';
  static const String _key = 'current_subscription';

  @override
  Future<void> init() async {
    // Hive should be initialized in main.dart, but we register adapter here if not already done?
    // Usually adapter registration is done before opening boxes.
    // So init() here might just open the box.
    if (!Hive.isAdapterRegistered(0)) {
       Hive.registerAdapter(SubscriptionModelAdapter());
    }
    await Hive.openBox<SubscriptionModel>(_boxName);
  }

  Box<SubscriptionModel> get _box => Hive.box<SubscriptionModel>(_boxName);

  @override
  Future<void> saveSubscription(ISubscription subscription) async {
    // Ensure we are saving the concrete model
    final model = SubscriptionModel(
      name: subscription.name,
      price: subscription.price,
      duration: subscription.duration,
    );
    await _box.put(_key, model);
  }

  @override
  Future<ISubscription?> getSubscription() async {
    if (_box.containsKey(_key)) {
      return _box.get(_key);
    }
    return null;
  }

  @override
  Future<void> clearSubscription() async {
    await _box.delete(_key);
  }
}
