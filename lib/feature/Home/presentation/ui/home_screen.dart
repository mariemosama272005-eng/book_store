import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:bookia/feature/Home/presentation/cubit/cubit/home_cubit.dart';
import 'package:bookia/feature/Home/presentation/ui/wedgit/bookItem_wedgit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
                      child: Expanded(
                      child: Skeletonizer(
                        enabled: true,
                       
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) => BookitemWedgit(
                            prodcut:Products(name: "test",
                            price: "333",
                            image: "https://image-processor-storage.s3.us-west-2.amazonaws.com/images/3cf61c1011912a2173ea4dfa260f1108/halo-of-neon-ring-illuminated-in-the-stunning-landscape-of-yosemite.jpg",
                            )
                           ),
                          itemCount: 4,
                        ),
                      ),
                    )
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
