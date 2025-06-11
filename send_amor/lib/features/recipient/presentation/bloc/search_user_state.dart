part of 'search_user_bloc.dart';

abstract class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object?> get props => [];
}

class SearchUserInitial extends SearchUserState {}

class SearchUserLoading extends SearchUserState {}

class SearchUserSuccess extends SearchUserState {
  final List<SearchList> searchUsersList;
  const SearchUserSuccess({required this.searchUsersList});

  @override
  List<Object?> get props => [searchUsersList];
}

class SearchUserFailure extends SearchUserState {
  final String error;
  const SearchUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}
