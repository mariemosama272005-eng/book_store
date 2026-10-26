import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/presentation/cubit/cubit/home_cubit.dart';
import 'package:bookia/feature/Home/presentation/ui/wedgit/bookItem_wedgit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
          
               BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is getbestsellerLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
                  } else if (state is getbestsellerSuccess) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) => BookitemWedgit(prodcut: state.products?[index],),
                        itemCount: state.products?.length,
                      ),
                    );
                  } else {
                    return const Center(child: Text("Error"));
                  }
                },
              ),
            
          ],
        ),
      ),
    );
  }
}
