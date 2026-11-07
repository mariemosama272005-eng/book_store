import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/presentation/ui/home_screen.dart';
import 'package:bookia/feature/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/ui/cart_screen.dart';
import 'package:bookia/feature/profile/presentation/cubit/cubit/profile_cubit.dart';
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
  int currentIndex = 0;
  late final CartCubit _cartCubit;

  final List<Widget> screens = const [
    HomeScreen(),
    Center(child: Text("Bookmark Screen")),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _cartCubit = CartCubit()..showCart();
  }

  @override
  void dispose() {
    _cartCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cartCubit),
        BlocProvider(
          create: (context) => ProfileCubit()..getProfileData(),
        ),
      ],
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (v) {
            if (v == 2) {
              _cartCubit.showCart();
            }
            setState(() {
              currentIndex = v;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white70,
          selectedItemColor: AppColors.mainColor,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.home,
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? AppColors.mainColor
                      : AppColors.drarkColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.bookmark,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? AppColors.mainColor
                      : AppColors.drarkColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "BookMark",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.category,
                colorFilter: ColorFilter.mode(
                  currentIndex == 2
                      ? AppColors.mainColor
                      : AppColors.drarkColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.profile,
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? AppColors.mainColor
                      : AppColors.drarkColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
