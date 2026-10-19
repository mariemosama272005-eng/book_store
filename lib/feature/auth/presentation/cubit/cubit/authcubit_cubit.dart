import 'package:bloc/bloc.dart';
import 'package:bookia/feature/auth/data/Repo/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'authcubit_state.dart';

class AuthcubitCubit extends Cubit<AuthcubitState> {
  AuthcubitCubit() : super(AuthcubitInitial());

login({required String email,required String password})async{
  emit(loginLoadingState());
  final response=await AuthRepo.Login(email: email, password: password);
  if(response){
    emit(LoginSuccessState());
  }else{
    emit(LoginErrorState());
  }
}

}
