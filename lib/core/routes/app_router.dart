import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/feature/Home/presentation/cubit/cubit/home_cubit.dart';
import 'package:bookia/feature/Home/presentation/ui/home_screen.dart';
import 'package:bookia/feature/Home/presentation/ui/searchscreen.dart';
import 'package:bookia/feature/auth/presentation/cubit/cubit/authcubit_cubit.dart';
import 'package:bookia/feature/auth/presentation/ui/forgetPass_screen.dart';
import 'package:bookia/feature/auth/presentation/ui/login_screen.dart';
import 'package:bookia/feature/auth/presentation/ui/register_screen.dart';
import 'package:bookia/feature/welcome/presentation/ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
 static Route? onGenerateRoute(RouteSettings setting){
     switch(setting.name){

          case AppRoutes.loginScreen:
          return MaterialPageRoute(builder:(_){
            return BlocProvider(
              create: (context) => AuthcubitCubit(),
              child: LoginScreen(),
            );
            },
            );

          case AppRoutes.welcomeScreen:
          return MaterialPageRoute(builder:(_)=>WelcomeScreen());

          case AppRoutes.registerScreen:
          return MaterialPageRoute(builder:(_){
            return BlocProvider(
              create: (context) =>  AuthcubitCubit(),
              child: RegisterScreen(),
            );
            }
            );
            
          case AppRoutes.forgetpassScreen:
          return MaterialPageRoute(builder:(_)=>ForgetPasswordScreen());

          case AppRoutes.homeScreen:
          return MaterialPageRoute(builder:(_){
           return BlocProvider(
              create: (context) => HomeCubit()..getbestsellerBooks(),
              child: HomeScreen(),
            );
            
            }
            );
 
        
       case AppRoutes.searchScreen:
       return MaterialPageRoute(builder:(_)=>
        BlocProvider(
          create: (context) => HomeCubit()..search(""),
          child: Searchscreen(),
        )
        );

     }

  }
}