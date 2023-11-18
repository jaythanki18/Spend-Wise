part of 'create_categorybloc_bloc.dart';

sealed class CreateCategoryblocEvent extends Equatable {
  const CreateCategoryblocEvent();

  @override
  List<Object> get props => [];
}

class CreateCategory  extends CreateCategoryblocEvent {
  final Category category ;
  const CreateCategory(this.category);

  @override
  List<Object> get props => [category];
}
