import 'package:flutter/material.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/reports_screen.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const dashboard = '/dashboard';
  static const transactions = '/transactions';
  static const addTransaction = '/add-transaction';
  static const reports = '/reports';

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case transactions:
        return MaterialPageRoute(builder: (_) => const TransactionsScreen());

      case addTransaction:
        return MaterialPageRoute(builder: (_) => const AddTransactionScreen());

      case reports:
        return MaterialPageRoute(builder: (_) => const ReportsScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
