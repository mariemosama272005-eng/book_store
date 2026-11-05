import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/presentation/cubit/cubit/home_cubit.dart';
import 'package:bookia/feature/Home/presentation/ui/home_screen.dart';
import 'package:bookia/feature/profile/presentation/ui/profile_screen.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ButtomnavbarScreen extends StatefulWidget {
  const ButtomnavbarScreen({super.key});

  @override
  State<ButtomnavbarScreen> createState() => _ButtomnavbarScreenState();
}

class _ButtomnavbarScreenState extends State<ButtomnavbarScreen> {
  int currentIndex=0 ;
  List<Widget>screens=[
    BlocProvider(
      create: (context) => HomeCubit()..getbestsellerBooks(),
      child: HomeScreen(),
    ),

  const Center(child: Text("Bookmark Screen")),
    const Center(child: Text("Cart Screen")),       
   const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:screens[currentIndex] ,





    bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (v){
setState(() {
  currentIndex=v;
});
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white70,
    selectedItemColor: AppColors.mainColor,
      items:[
      BottomNavigationBarItem(icon:SvgPicture.asset(
  Assets.icons.home,
  colorFilter: ColorFilter.mode(currentIndex==0?AppColors.mainColor:AppColors.drarkColor,BlendMode.srcIn),
  ),label: "Home",
  ),
      BottomNavigationBarItem(icon:SvgPicture.asset(
  Assets.icons.bookmark,
  colorFilter: ColorFilter.mode(currentIndex==1?AppColors.mainColor:AppColors.drarkColor,BlendMode.srcIn),
  ),label: "BookMark"
  ),
      BottomNavigationBarItem(icon:SvgPicture.asset(
  Assets.icons.category,
  colorFilter: ColorFilter.mode(currentIndex==2?AppColors.mainColor:AppColors.drarkColor,BlendMode.srcIn),
  ),label: "Cart"
  ),
      BottomNavigationBarItem(icon:SvgPicture.asset(
  Assets.icons.profile,
  colorFilter: ColorFilter.mode(currentIndex==3?AppColors.mainColor:AppColors.drarkColor,BlendMode.srcIn),
  ),label: "Profile"
  ),

    ]
    
    ),
    );
  }
}