import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_achi_example/domain/usecases/fetch_users_usecase.dart';
import 'package:flutter_clean_achi_example/presentation/bloc/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final FetchUsersUsecase _usecase;

  UsersCubit(this._usecase) : super(UsersInit());

  void fetchUsers(int count) async {
    emit(UsersLoading());
    final eitherUsers = await _usecase(FetchUsersUsecaseParams(count));
    eitherUsers.fold((failure) {
      emit(UsersError(failure.message));
    }, (users) {
      emit(UsersAvailable(users));
    });
  }
}
