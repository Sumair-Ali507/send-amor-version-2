import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/recipient/domain/recipients_repository.dart';
import '../../data/payload/search_user.dart';
part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final RecipientsRepository _recipientsRepository;

  SearchUserBloc({required RecipientsRepository recipientsRepository})
      : _recipientsRepository = recipientsRepository,
        super(SearchUserInitial()) {
    on<FetchSearchUsersEvent>(_onFetchSearchRecipients);
  }

  Future<void> _onFetchSearchRecipients(
      FetchSearchUsersEvent event, Emitter<SearchUserState> emit) async {
    emit(SearchUserLoading());
    try {
      final searchUsers = await _recipientsRepository.searchRecipientsList(
          context: event.context, query: event.query, appUser: event.appUser);

      if (searchUsers != null) {
        final users = searchUsers.searchList ?? [];
        emit(SearchUserSuccess(searchUsersList: users));
      } else {
        emit(const SearchUserFailure('Failed to load users'));
      }
    } catch (e) {
      emit(const SearchUserFailure('Failed to load users'));
    }
  }
}
