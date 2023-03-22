import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class GithubUserEvent extends Equatable {
  const GithubUserEvent();
}

class InitGithubUserEvent extends GithubUserEvent {
  @override
  List<Object?> get props => [];
}

class LoadGithubUserEvent extends GithubUserEvent {
  @override
  List<Object?> get props => [];
}

class TextChangeEvent extends GithubUserEvent {
  final String data;
  const TextChangeEvent({required this.data});

  @override
  List<Object?> get props => [];
}


@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}


@immutable
abstract class RepoEvent extends Equatable {
  const RepoEvent();
}

class LoadRepoEvent extends RepoEvent {
  @override
  List<Object?> get props => [];
}


@immutable
abstract class FollowerEvent extends Equatable {
  const FollowerEvent();
}

class LoadFollowerEvent extends FollowerEvent {
  @override
  List<Object?> get props => [];
}
