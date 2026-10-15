import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/feature/auth/presentation/ui/login_screen.dart';
import 'package:bookia/feature/welcome/presentation/ui/register_screen.dart';
import 'package:bookia/feature/welcome/presentation/ui/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
 static Route? onGenerateRoute(RouteSettings setting){
     switch(setting.name){
          case AppRoutes.loginScreen:
          return MaterialPageRoute(builder:(_)=>LoginScreen());
          case AppRoutes.welcomeScreen:
          return MaterialPageRoute(builder:(_)=>WelcomeScreen());
          case AppRoutes.registerScreen:
          return MaterialPageRoute(builder:(_)=>RegisterScreen());
        }

  }
}