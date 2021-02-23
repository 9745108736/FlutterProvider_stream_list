import 'package:get_it/get_it.dart';
import 'package:tp_connects/src/constents/styles.dart';
import 'package:tp_connects/src/provider/LoginProvider.dart';
import 'package:tp_connects/src/provider/PostsProvider.dart';
import 'package:tp_connects/src/utils/sharedPrefUtils.dart';

import 'constents/img.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Mystyles>(Mystyles()); //common styles
  getIt.registerFactory(() => SharedPrefUtils()); //shared preference
  getIt.registerFactory(() => LoginProvider()); //login provider
  getIt.registerFactory(() => PostsProvider()); //post provider
  getIt.registerSingleton<Img>(Img());
}
