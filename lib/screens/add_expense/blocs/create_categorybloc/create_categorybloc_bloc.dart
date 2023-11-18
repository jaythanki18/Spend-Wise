import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_categorybloc_event.dart';
part 'create_categorybloc_state.dart';

class CreateCategoryblocBloc extends Bloc<CreateCategoryblocEvent, CreateCategoryblocState> {
  final ExpenseRepository expenseRepository ;


  CreateCategoryblocBloc(this.expenseRepository) : super(CreateCategoryblocInitial()) {
    on<CreateCategory>((event, emit) async{
        emit (CreateCategoryblocLoading());
        try {
          await expenseRepository.createCategory(event.category);
          emit (CreateCategoryblocSuccess());
        }catch (e) {
          emit(CreateCategoryblocFailure());
        }


    });
  }
}
