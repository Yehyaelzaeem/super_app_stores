


import 'package:cogina_restaurants/presentation/modules/auth/auth_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/branches/branch_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/delivery_time/delivery_time_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/layout_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/account_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/orders_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/prescription/prescription_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/store_time/store_time_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/injection.dart';
import 'domain/provider/local_auth_provider_cubit.dart';

Future<void> init() async {
  getIt.registerLazySingleton(() => LayoutCubit());
  getIt.registerLazySingleton(() => PrescriptionCubit(prescriptionUseCase: getIt(), sendPricePrescriptionUseCase: getIt()));
  getIt.registerLazySingleton(() => StoreTimeCubit(addStoreTimeUseCase: getIt()));
  getIt.registerLazySingleton(() => DeliveryTimeCubit(addDeliveryTimeUseCase: getIt()));
  getIt.registerLazySingleton(() => LocalAuthCubit(clearUserDataUseCase: getIt(), isUserLoginUseCase: getIt(), getProfileUseCase: getIt(), updateFCMTokenUseCase: getIt()));
  getIt.registerLazySingleton(() => HomeCubit(getProductsCategoriesUseCase: getIt(), addProductUseCase: getIt(), getProductsUseCase: getIt(),
      updateProductUseCase: getIt(), deleteProductUseCase: getIt(), changeProductStateUseCase: getIt(), updateOfferProductUseCase: getIt(), addOfferProductUseCase: getIt()));
  getIt.registerLazySingleton(() => AccountCubit(bankAccountUseCase: getIt(), addAccountFilesUseCase: getIt(), aboutUsUseCase: getIt(), privacyUseCase: getIt(), termsUseCase: getIt()));
  getIt.registerLazySingleton(() => BranchCubit(getBranchesUseCase:  getIt(), addBranchUseCase: getIt(), getRegionsUseCase: getIt(), deleteBranchUseCase: getIt(), updateBranchUseCase: getIt()));
  getIt.registerLazySingleton(() => ProfileCubit(profileUseCase: getIt(), updateProfileUseCase: getIt(),));
  getIt.registerLazySingleton(() => AuthCubit(signInUseCase: getIt(), otpUseCase: getIt(), registerUseCase: getIt(), saveUserDataUseCase: getIt(), completeProfileUseCase: getIt(), restaurantTypesUseCase: getIt(),
      restaurantCategoriesUseCase: getIt()));
  getIt.registerLazySingleton(() => OrdersCubit(
      getOrdersUseCase: getIt(), acceptOrderUseCase: getIt(), rejectOrderUseCase: getIt(), changeStateRestaurantUseCase: getIt(), getOrdersByDateUseCase: getIt(), finishOrderUseCase: getIt(),deliveredOrderUseCase: getIt(),inProgressOrderUseCase: getIt()));
}
