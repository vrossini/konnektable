import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:konnektable/models/repo.dart';
import 'package:konnektable/models/user.dart';
import 'package:konnektable/models/follower.dart';
import 'package:konnektable/models/profile.dart';

class TextInputState {}

class TextInputInitState extends TextInputState {
  String text;
  TextInputInitState({required this.text});
}

class TextInputDataChange extends TextInputState {
  String text;
  TextInputDataChange({required this.text});
}


@immutable
abstract class GithubUserState extends Equatable {}

class InitGithubUserState extends GithubUserState {
  @override
  List<Object?> get props => [];
}

class GithubUserLoadingState extends GithubUserState {
  @override
  List<Object?> get props => [];
}

class GithubUserLoadedState extends GithubUserState {
  final List<GithubUser> githubUsers;
  GithubUserLoadedState(this.githubUsers);
  @override
  List<Object?> get props => [githubUsers];
}

class GithubUserErrorState extends GithubUserState {
  final String error;
  GithubUserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}


@immutable
abstract class ProfileState extends Equatable {}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final Profile profile;
  ProfileLoadedState(this.profile);
  @override
  List<Object?> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String error;
  ProfileErrorState(this.error);
  @override
  List<Object?> get props => [error];
}


@immutable
abstract class RepoState extends Equatable {}

class RepoLoadingState extends RepoState {
  @override
  List<Object?> get props => [];
}

class RepoLoadedState extends RepoState {
  final List<Repo> repos;
  RepoLoadedState(this.repos);
  @override
  List<Object?> get props => [repos];
}

class RepoErrorState extends RepoState {
  final String error;
  RepoErrorState(this.error);
  @override
  List<Object?> get props => [error];
}


@immutable
abstract class FollowerState extends Equatable {}

class FollowerLoadingState extends FollowerState {
  @override
  List<Object?> get props => [];
}

class FollowerLoadedState extends FollowerState {
  final List<Follower> followers;
  FollowerLoadedState(this.followers);
  @override
  List<Object?> get props => [followers];
}

class FollowerErrorState extends FollowerState {
  final String error;
  FollowerErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
