import 'package:cogina_restaurants/domain/usecase/account/add_account_file_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/account/bank_account_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/auth/check_otp_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/auth/complete_profile_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/auth/register_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/auth/restaurant_type_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/auth/sign_in_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/auth/update_fcm_token_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/branches/add_branch_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/branches/delete_branch_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/branches/get_branches_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/branches/get_regions_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/branches/update_branch_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/favorite/add_favorite_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/favorite/get_favorite_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/favorite/remove_favorite_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/home/add_product_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/home/change_product_state_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/home/delete_product_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/home/get_products_categories_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/home/get_products_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/home/update_product_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/local/clear_user_data_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/local/get_is_login_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/local/get_user_token_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/local/save_data_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/account/about_us_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/account/privacy_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/account/terms_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/accept_order_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/change_state_restaurant_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/delivered_order_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/finish_order_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/get_orders_date_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/get_orders_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/in_progress_order_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/orders/reject_order_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/profile/get_profile_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/profile/update_profile_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/time/add_delivery_time_usecase.dart';
import 'package:cogina_restaurants/domain/usecase/time/add_store_time_usecase.dart';

import '../data/injection.dart';


Future<void> init() async {


  ///local
   getIt.registerLazySingleton(() => ClearUserDataUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => IsUserLoginUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => GetUserTokenUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => SaveUserDataUseCase(repository: getIt()));

  ///Auth
   getIt.registerLazySingleton(() => SignInUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => OTPUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => RegisterUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => CompleteProfileUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => UpdateFCMTokenUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => RestaurantTypesUseCase(repository: getIt()));
   ///Branches
   getIt.registerLazySingleton(() => GetBranchesUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => AddBranchUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => GetRegionsUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => DeleteBranchUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => UpdateBranchUseCase(repository: getIt()));

   ///TimeStore
   getIt.registerLazySingleton(() => AddStoreTimeUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => AddDeliveryTimeUseCase(repository: getIt()));


   ///Account
   getIt.registerLazySingleton(() => BankAccountUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => AddAccountFilesUseCase(repository: getIt()));

   ///Profile
   getIt.registerLazySingleton(() => GetProfileUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => UpdateProfileUseCase(repository: getIt()));

   ///Home
   getIt.registerLazySingleton(() => GetProductsCategoriesUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => AddProductUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => GetProductsUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => UpdateProductUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => DeleteProductUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => ChangeProductStateUseCase(repository: getIt()));


   ///Orders
   getIt.registerLazySingleton(() => GetOrdersUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => RejectOrderUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => AcceptOrderUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => ChangeStateRestaurantUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => GetOrdersByDateUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => FinishOrderUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => InProgressOrderUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => DeliveredOrderUseCase(repository: getIt()));

  ///more
   getIt.registerLazySingleton(() => TermsUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => PrivacyUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => AboutUsUseCase(repository: getIt()));
 ///favorite
   getIt.registerLazySingleton(() => GetFavoriteUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => AddFavoriteUseCase(repository: getIt()));
   getIt.registerLazySingleton(() => RemoveFavoriteUseCase(repository: getIt()));

  ///notifications
  // getIt.registerLazySingleton(() => GetNotificationsUseCase(repository: getIt()));
  //
  //
  // ///setting
  // getIt.registerLazySingleton(() => GetCitiesUseCase(repository: getIt()));
  // getIt.registerLazySingleton(() => GetCategoriesUseCase(repository: getIt()));
  // getIt.registerLazySingleton(() => ContactUsRequestUseCase(repository: getIt()));
  // getIt.registerLazySingleton(() => GetFQAsUseCase(repository: getIt()));
  //
  // ///country
  // getIt.registerLazySingleton(() => GetCountriesUseCase(repository: getIt()));
  //
  // ///offer
  // getIt.registerLazySingleton(() => GetOffersUseCase(repository: getIt()));

}