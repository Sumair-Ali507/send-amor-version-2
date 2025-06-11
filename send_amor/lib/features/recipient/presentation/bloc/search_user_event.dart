part of 'search_user_bloc.dart';

abstract class SearchUserEvent extends Equatable {
  const SearchUserEvent();
  @override
  List<Object?> get props => [];
}

class FetchSearchUsersEvent extends SearchUserEvent {
  final AppUser appUser;
  final String query;
  final BuildContext context;

  const FetchSearchUsersEvent({
    required this.query,
    required this.context,
    required this.appUser,
  });

  @override
  List<Object> get props => [query, context];
}
