import 'package:get_it/get_it.dart';
import 'package:trial1/repository/auth_repo.dart';
import 'package:trial1/repository/storage_repo.dart';
import 'package:trial1/view_controller/user_controller.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<AuthRepo>(AuthRepo());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<UserController>(UserController());
}
