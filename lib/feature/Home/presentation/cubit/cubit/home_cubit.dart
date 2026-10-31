import 'package:bloc/bloc.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:bookia/feature/Home/data/models/sliderModel.dart';
import 'package:bookia/feature/Home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  getbestsellerBooks()async{
emit(getbestsellerLoading());
final response = await HomeRepo.getBestseller();
if(response is BookModel){
  emit(getbestsellerSuccess(response.data?.products));
}else{
  emit(getbestsellerError());
}

  }


search(String text)async{
  emit(SearchLoading());
  final data =await HomeRepo.search(text);
  if(data is List<Products>){
    emit(SearchSuccess(data));
  }
  else{
    emit(SearchError());
  }

}
slider()async{
  emit(SliderLoading());
  final res =await HomeRepo.slider();
  if(res is SliderModel){
    emit(SliderSuccess(res.data?.sliders));
  }
  else{
    emit(SliderError());
  }
}

}
