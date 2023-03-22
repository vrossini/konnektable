import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konnektable/bloc/app_events.dart';
import 'package:konnektable/bloc/app_states.dart';
import 'package:konnektable/models/user.dart';
import 'package:konnektable/repo/repositories.dart';

class GithubUserBloc extends Bloc<GithubUserEvent, GithubUserState> {
  final GithubUserRepository _userRepository;

  GithubUserBloc(this._userRepository) : super(GithubUserLoadingState()) {
    on<InitGithubUserEvent>((event, emit) async {
      emit(InitGithubUserState());
    });
    on<TextChangeEvent>((event, emit) async {
      emit(GithubUserLoadingState());
      try {
        final users = await _userRepository.getGithubUsers();
        List<GithubUser> outputList = users.where((o) => o.login.toString().contains(event.data)).toList();
        emit(GithubUserLoadedState(outputList));
      } catch (e) {
        emit(GithubUserErrorState(e.toString()));
      }
    });
  }
}


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await _profileRepository.getProfile();
        emit(ProfileLoadedState(profile));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });
  }
}


class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final RepoRepository _repoRepository;

  RepoBloc(this._repoRepository) : super(RepoLoadingState()) {
    on<LoadRepoEvent>((event, emit) async {
      emit(RepoLoadingState());
      try {
        final repos = await _repoRepository.getRepos();
        emit(RepoLoadedState(repos));
      } catch (e) {
        emit(RepoErrorState(e.toString()));
      }
    });
  }
}


class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  final FollowerRepository _followerRepository;

  FollowerBloc(this._followerRepository) : super(FollowerLoadingState()) {
    on<LoadFollowerEvent>((event, emit) async {
      emit(FollowerLoadingState());
      try {
        final followers = await _followerRepository.getFollowers();
        emit(FollowerLoadedState(followers));
      } catch (e) {
        emit(FollowerErrorState(e.toString()));
      }
    });
  }
}
