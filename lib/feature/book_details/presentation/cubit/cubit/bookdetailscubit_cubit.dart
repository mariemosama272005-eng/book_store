import 'package:bloc/bloc.dart';
import 'package:bookia/feature/book_details/data/models/bookDitalisModel.dart';
import 'package:bookia/feature/book_details/data/repo/bookDetails_repo.dart';
import 'package:meta/meta.dart';

part 'bookdetailscubit_state.dart';

class BookdetailscubitCubit extends Cubit<BookdetailscubitState> {
  BookdetailscubitCubit() : super(BookdetailscubitInitial());

  getDetails(int id) async {
    emit(BookdetailscubitLoading());

    final data = await BookdetailsRepo.getbookDetails(id);

    if (data is bookdetailsModel && data.data != null) {
      emit(BookdetailscubitSuccess(data.data!));
    } else {
      emit(BookdetailscubitError());
    }
  }
}