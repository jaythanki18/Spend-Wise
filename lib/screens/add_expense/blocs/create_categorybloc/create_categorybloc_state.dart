part of 'create_categorybloc_bloc.dart';

sealed class CreateCategoryblocState extends Equatable {
  const CreateCategoryblocState();
  
  @override
  List<Object> get props => [];
}

final class CreateCategoryblocInitial extends CreateCategoryblocState {}


final class CreateCategoryblocFailure extends CreateCategoryblocState {}
final class CreateCategoryblocLoading extends CreateCategoryblocState {}
final class CreateCategoryblocSuccess extends CreateCategoryblocState {}