import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/category_list/category_list_screen.dart';
import 'package:shop_app/screens/contact_us/contact_us.dart';
import 'package:shop_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:shop_app/screens/maid_screen/maid_screen.dart';
import 'package:shop_app/screens/orders/orders_screen.dart';
import 'package:shop_app/screens/detail_client/detail_client_screen.dart';

import 'package:shop_app/screens/categories/categories_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/screens/orders_detail/orders_detail.dart';
import 'package:shop_app/screens/maid_detail/maids_detail.dart';

import 'package:shop_app/screens/payment/payment_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/rating_screen/rating_screen.dart';
import 'package:shop_app/screens/register_maid_screen/register_maid_screen.dart';
import 'package:shop_app/screens/reschedule_order/reschedule_order.dart';
import 'package:shop_app/screens/reshedule_screen/reschedule_screen.dart';
import 'package:shop_app/screens/review_screen/review_screen.dart';
import 'package:shop_app/screens/settings/settings_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/tabs/tabs_screen.dart';
import 'package:shop_app/screens/tabsMaid/tabs_screenMaid.dart';
import 'package:shop_app/screens/tabs_admin/tabs_admin.dart';
import 'package:shop_app/screens/update_maid_screen/update_maid_screen.dart';
import 'package:shop_app/screens/user_screen/user_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  TabsScreen.routeName: (context) => TabsScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CategoriesScreen.routeName: (context) => CategoriesScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  DetailClientScreen.routeName: (context) => DetailClientScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  ContactUsScreen.routeName: (context) => ContactUsScreen(),
  CategoryListScreen.routeName: (context) => CategoryListScreen(),
  TabsScreenMaid.routeName: (context) => TabsScreenMaid(),
  TabsAdmin.routeName: (context) => TabsAdmin(),
  RegisterMaidScreen.routeName: (context) => RegisterMaidScreen(),
  MaidScreen.routeName: (context) => MaidScreen(),
  UpdateMaidScreen.routeName: (context) => UpdateMaidScreen(),
  RescheduleOrderScreen.routeName: (context) => RescheduleOrderScreen(),
  RescheduleScreen.routeName: (context) => RescheduleScreen(),
  OrdersDetailScreen.routeName: (context) => OrdersDetailScreen(),
  MaidsDetailScreen.routeName: (context) => MaidsDetailScreen(),
  ReviewScreen.routeName: (context) => ReviewScreen(),
  RatingScreen.routeName: (context) => RatingScreen(),
  UserScreen.routeName: (context) => UserScreen(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
};
