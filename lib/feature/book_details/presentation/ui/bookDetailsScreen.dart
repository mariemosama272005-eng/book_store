import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/feature/book_details/presentation/cubit/cubit/bookdetailscubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bookdetailsscreen extends StatelessWidget {
  const Bookdetailsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: BlocBuilder<BookdetailscubitCubit, BookdetailscubitState>(
        builder: (context, state) {
          if (state is BookdetailscubitLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BookdetailscubitSuccess) {
            final book = state.details;
            return SafeArea(
              child: Column(
                children: [
                  
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: const AppbarWedgit(),
                  ),

               
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.w,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),

                          Container(
                            width: 230.w,
                            height: 340.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.network(
                                book.image ?? '', 
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 25.h),

                        
                          Text(
                            book.name ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'serif',
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(height: 8.h),

                       
                          Text(
                            book.category ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffC9A24D),
                            ),
                          ),

                          SizedBox(height: 28.h),

                       
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              book.description ?? '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15.sp,
                                height: 1.8,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'serif',
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),

                 
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 15.h,
                    ),
                    color: const Color(0xffF8F9FA),
                    child: Row(
                      children: [
                     
                        Expanded(
                          child: Text(
                            '₹${book.priceAfterDiscount ?? book.price ?? 0}',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'serif',
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),

                        SizedBox(width: 15.w),

                  
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 70.h,
                            child: ElevatedButton(
                              onPressed: () {
                               
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff303030),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Add To Cart',
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'serif',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Something went wrong',
              ),
            );
          }
        },
      ),
    );
  }
}