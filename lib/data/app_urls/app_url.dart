import '../../main.dart';

class AppURL {

  static const String kAPIKey = "";
  static  String kBaseURL = "http://yalla-hatly.matrixclouds.net/api/";
  /// Auth
  static const String kLoginURI = "stores/login";
  static const String kOtpURI = "stores/otp";
  static const String kRegisterURI = "stores/register";
  static const String kCompleteProfileURI = "stores/profile/store_info";
  static const String kUpdateFCMTokenURI = "stores/profile/fcm_token";
  static const String kRestaurantTypesURI = "stores/types";
  static  String kRestaurantCategoriesURI(int id) => "stores/type-category/$id";


  /// Profile
  static const String kGetProfileURL = "stores/profile";
  static const String kUpdateProfileURL = "stores/profile/update";
  static const String kUpdateImageProfileURL = "stores/profile/image";

   /// Account
   static const String kBankAccountURL = "stores/bank_details";
   static const String kAddAccountFilesURL = "stores/profile/files";
  ///Branches
  static const String kGetBranchesURL = "stores/branches";
  static const String kAddBranchURL = "stores/branches/new_branch";
  static  String kDeleteBranchURL({required int branchId}) => "stores/branches/delete_branch/$branchId";
  static  String kUpdateBranchURL({required int branchId}) => "stores/branches/update_branch/$branchId";
  static const String kGetRegionsURL = "stores/regions";

///Products
  static const String kGetProductsCategoriesURL = "stores/products/categories";
  static const String kGetProductsURL = "stores/products";
  static  String kDeleteProductURL({required int id}) => "stores/products/remove_product/$id";
  static  String kChangeProductStateURL({required int id}) => "stores/products/change_status?id=$id";
  static  String kUpdateProductURL({required int id}) => "stores/products/update_product/$id";
  static  String kUpdateOfferProductURL({required int id}) => "stores/offer/update_product/$id";
  static const String kAddProductURL = "stores/products/add_product";
  static const String kAddOfferProductURL = "stores/offer/add";

  ///more
  static const String kGetPrivacyURL = "privacy-policy-restaurant";
  static const String kGetTermsURL = "terms-restaurant";
  static const String kGetAboutUsURL = "how-we-are";



/// Prescription
  static const String kGetPrescriptionURL = "stores/prescriptions";
  static const String kSendPricePrescriptionURL = "stores/prescriptions/add-price";









  /////////////////////////////////////////
  ///Auth

  static const String kForgetPasswordURI = "auth/otp";
  static const String kCheckOTPURI = "auth/check-otp";
  static const String kResetPasswordURI = "";
  static const String kDeleteAccountURI = "";

  ///home
  static const String kHomeURI = "home";
  static const String kOffersURI = "stores/offers";
  static  String kCategoriesURI (int id)=> "stores/all-categories?store_id=$id";
  static  String kItemExtraURI (int id)=> "stores/items/single?item_id=$id";
  static  String kCategoriesItemsURI ({required int categoryId,required int storeId})=> "stores/categories?category_id=$categoryId&store_id=$storeId";
  ///Cart
  static const String kGetCartURL = "shopping-cart";
  static const String kAddQtURL = "shopping-cart/add";
  static const String kSubQtURL = "shopping-cart/sub";
  static const String kAddItemURL = "shopping-cart/insert";
  static const String kUpdateItemURL = "shopping-cart/update";
  static const String kDeleteItemURL = "shopping-cart/delete";
  static const String kGetMainAddressURL = "other-trip/get-main-address";
  static const String kGetLastAddressURL = "last-address";
  static const String kGetAllAddressURL = "other-trip/all-address";
  static const String kAddMainAddressURL = "other-trip/main-address";
  ///checkout
  static const String kCheckOutURL = "stores/checkout/store";

 /// favorite
  static const String kGetFavoriteURL = "fav/list";
  static const String kAddFavoriteURL = "fav/add";
  static const String kRemoveFavoriteURL = "fav/remove";


  ///Time
  static const String kAddStoreTimeURL = "stores/profile/change-time";
  static const String kAddDeliveryTimeURL = "stores/profile/store-delivery-time";



  /// order
  static  String kAllOrdersURL({required String status,required int page,required String branchId}) => "stores/orders/status?status=$status&page=$page&branch_id=$branchId";
  static const String kAcceptOrderURL = "stores/orders/accept-order";
  static  String kRejectOrderURL({required int id}) => "stores/orders/reject_order/$id";
  static  String kChangeRestaurantStateURL ="stores/profile/change_status";
  static  String kGetOrdersByDateStateURL({required String date}) =>"stores/orders/date/$date";
  static  String kInProgressOrderURL({required int id}) => "stores/orders/progress-order/$id";
  static  String kDeliveredOrderURL({required int id}) => "stores/orders/delivered-driver-order/$id";
        static  String kFinishOrderURL({required int id}) => "stores/orders/done-order/$id";

  ///setting
  static const String kGetCitiesURL = "";
  static const String kGetCategoriesURL = "";
  static const String kContactUsRequestURL = "";
  static const String kGetFAGsURL = "";

  ///notifications
  static const String kGetNotificationsURI = '';

  ///offer
  static const String kGetOffersURI = '';
  static const String kGetOfferDetailsURI = '';



}
