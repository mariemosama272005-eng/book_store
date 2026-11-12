import 'package:bloc/bloc.dart';
import 'package:bookia/feature/auth/data/Repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'authcubit_state.dart';

class AuthcubitCubit extends Cubit<AuthcubitState> {
  AuthcubitCubit() : super(AuthcubitInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(loginLoadingState());

    try {
      final response = await AuthRepo.Login(
        email: email,
        password: password,
      );

      if (response) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('Login failed. Please try again.'));
      }
    } catch (e) {
      emit(
        LoginErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String city,
  }) async {
    emit(registerLoadingState());

    try {
      final response = await AuthRepo.Register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        city: city,
        address: address,
      );

      if (response) {
        emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState('Registration failed. Please try again.'));
      }
    } catch (e) {
      emit(
        RegisterErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}