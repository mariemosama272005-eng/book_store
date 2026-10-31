import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/data/models/sliderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class CustomSliderWidget extends StatefulWidget {
  final List<Sliders> slidersList;

  const CustomSliderWidget({super.key, required this.slidersList});

  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h, 
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.slidersList?.length??0,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    widget.slidersList[index].image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        16.verticalSpace,


        SmoothPageIndicator(
          controller: _pageController,
          count: widget.slidersList.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: AppColors.mainColor,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 4,
            dotColor: AppColors.hintColor,
          ),
        ),
      ],
    );
  }
}