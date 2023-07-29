
abstract class DeleteNoteCubitState {}

class DeleteNoteCubitInitial extends DeleteNoteCubitState {}

class DeleteNoteCubitLoading extends DeleteNoteCubitState {}

class DeleteNoteCubitFailure extends DeleteNoteCubitState {
  final String errMessage;
  DeleteNoteCubitFailure(this.errMessage);
}

class DeleteNoteCubitSuccess extends DeleteNoteCubitState {
  //handle success state
}
