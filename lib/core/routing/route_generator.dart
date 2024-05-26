
import 'package:cogina_restaurants/core/routing/platform_page_route.dart';
import 'package:cogina_restaurants/core/routing/undefined_route_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../presentation/modules/auth/auth_screen.dart';
import '../../presentation/modules/branches/add_beanch/add_branch_screen.dart';
import '../../presentation/modules/branches/branches_screen.dart';
import '../../presentation/modules/branches/edit_branch/edit_branch_screen.dart';
import '../../presentation/modules/elements/elements_screen.dart';
import '../../presentation/modules/layout/layout_screen.dart';
import '../../presentation/modules/layout/screens/account/about_us/about_us_screen.dart';
import '../../presentation/modules/layout/screens/account/bank/bank_details.dart';
import '../../presentation/modules/layout/screens/account/contact_us/contact_us.dart';
import '../../presentation/modules/layout/screens/account/edit_profile/change_password/change_password_screen.dart';
import '../../presentation/modules/layout/screens/account/edit_profile/edit_profile/edit_profile_screen.dart';
import '../../presentation/modules/layout/screens/account/my_files/edit_file_screen.dart';
import '../../presentation/modules/layout/screens/account/my_files/my_files_screen.dart';
import '../../presentation/modules/layout/screens/account/privacy_policy/privacy_policy.dart';
import '../../presentation/modules/layout/screens/account/settings/settings_screen.dart';
import '../../presentation/modules/layout/screens/account/terms_conditions/terms_conditions.dart';
import '../../presentation/modules/layout/screens/account/update_restaurant/update_restaurant.dart';
import '../../presentation/modules/layout/screens/home/notification/notification_screen.dart';
import '../../presentation/modules/layout/screens/home/product/add_product_screen.dart';
import '../../presentation/modules/layout/screens/home/product/product_details_screen.dart';
import '../../presentation/modules/layout/screens/home/product/update_product_screen.dart';
import '../../presentation/modules/layout/screens/orders/order_details/order_details.dart';
import '../../presentation/modules/messages/chat_details.dart';
import '../../presentation/modules/messages/messages_screen.dart';
import '../../presentation/modules/orders/provider_orders_screen.dart';
import '../../presentation/modules/splash/splash_screen.dart';
import 'routes.dart';

class RouteGenerator {
  static Route generateBaseRoute(RouteSettings settings) {
    Map? arguments = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
        case Routes.splashScreen:
        return platformPageRoute( const SplashScreen());
        case Routes.aboutUsScreen:
        return platformPageRoute( const AboutUsScreen());
        case Routes.termsConditionScreen:
        return platformPageRoute( const TermsConditionScreen());
        case Routes.privacyPolicyScreen:
        return platformPageRoute( const PrivacyPolicyScreen());
        case Routes.authScreen:
        return platformPageRoute(  const AuthScreen());
        case Routes.changeProfilePasswordScreen:
        return platformPageRoute(   ChangeProfilePasswordScreen());
      case Routes.elementsScreen:
        return platformPageRoute(   const ElementsScreen());
        case Routes.updateProductScreen:
        return platformPageRoute(    UpdateProductScreen(product: arguments?['product'],));
        case Routes.providerOrdersScreen:
        return platformPageRoute( const  ProviderOrdersScreen());
        case Routes.productDetailsScreen:
        return platformPageRoute(   ProductDetailsScreen(product: arguments?['product'],));
        case Routes.orderDetailsScreen:
        return platformPageRoute(   OrderDetailsScreen(ordersModelData: arguments?['ordersModelData'],));
        case Routes.addBranchScreen:
        return platformPageRoute( const  AddBranchScreen());
        case Routes.settingsScreen:
        return platformPageRoute( const  SettingsScreen());
        case Routes.updateRestaurant:
        return platformPageRoute( const  UpdateRestaurant());
        case Routes.bankDetailsScreen:
        return platformPageRoute( const  BankDetailsScreen());
        case Routes.chatDetailsScreen:
        return platformPageRoute( const  ChatDetailsScreen());
        case Routes.messagesScreen:
        return platformPageRoute( const  MessagesScreen());
        case Routes.editFileScreen:
        return platformPageRoute(   EditFileScreen(type: arguments?['type'], title: arguments?['title'], text: arguments?['text'],));
        case Routes.myFilesScreen:
        return platformPageRoute( const  MyFilesScreen());
        case Routes.editBranchScreen:
        return platformPageRoute(   EditBranchScreen(branchesModelData: arguments?['branchesModelData'],));
        case Routes.branchesScreen:
        return platformPageRoute( const  BranchesScreen());
        case Routes.notificationScreen:
        return platformPageRoute( const  NotificationScreen());
        case Routes.contactUsScreen:
        return platformPageRoute( const  ContactUsScreen());
        case Routes.editProviderProfileScreen:
        return platformPageRoute(  const EditProviderProfileScreen());
        case Routes.addMealScreen:
        return platformPageRoute(  const AddProductScreen());
        case Routes.layoutScreen:
        return platformPageRoute(   LayoutScreen(
          currentPage: arguments?['currentPage'],));
      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
