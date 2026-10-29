import 'package:bookia/core/shared_wedgits/textForm_wedgit.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:bookia/feature/Home/presentation/cubit/cubit/home_cubit.dart';
import 'package:bookia/feature/Home/presentation/ui/wedgit/bookItem_wedgit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppbarWedgit(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: TextformWedgit(
                controller: null,
                hintT: 'search',
                autoFocus: true,
                onChanged: (v) {
                  context.read<HomeCubit>().search(v ?? "");
                },
              ),
            ),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Expanded(
                    child: Skeletonizer(
                      enabled: true,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) => BookitemWedgit(
                          prodcut: Products(
                            name: "test",
                            price: "333",
                            image:
                                "https://image-processor-storage.s3.us-west-2.amazonaws.com/images/3cf61c1011912a2173ea4dfa260f1108/halo-of-neon-ring-illuminated-in-the-stunning-landscape-of-yosemite.jpg",
                          ),
                        ),
                        itemCount: 4,
                      ),
                    ),
                  );
                } else if (state is SearchSuccess) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) => BookitemWedgit(
                        prodcut: state.products?[index],
                      ),
                      itemCount: state.products?.length ?? 0,
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text("Not found"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}