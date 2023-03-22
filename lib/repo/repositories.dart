import 'dart:convert';

import 'package:http/http.dart';
import 'package:konnektable/models/repo.dart';
import 'package:konnektable/models/user.dart';
import 'package:konnektable/models/profile.dart';
import 'package:konnektable/models/follower.dart';

class GithubUserRepository {
  final String _usersUrl = 'https://gist.githubusercontent.com/paulmillr/4524946/raw/c462a62ac9f3a072fc4106bbd131335ad730da16/github-users-stats.json';

  Future<List<GithubUser>> getGithubUsers() async {
    Response res = await get(Uri.parse(_usersUrl));

    if (res.statusCode == 200) {
      final List result = jsonDecode(res.body);
      return result.map((e) => GithubUser.fromJson(e)).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}

class ProfileRepository {
  String login;
  final String _baseUrl = 'https://api.github.com/users/';

  ProfileRepository(this.login);

  Future<Profile> getProfile() async {
    Response res = await get(Uri.parse('$_baseUrl$login') );

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);
      return Profile.fromJson(data);
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}

class RepoRepository {
  String login;
  final String _baseUrl = 'https://api.github.com/users/';

  RepoRepository(this.login);

  Future<List<Repo>> getRepos() async {
    Response res = await get(Uri.parse('$_baseUrl$login/repos'));

    if (res.statusCode == 200) {
      final List result = jsonDecode(res.body);
      return result.map((e) => Repo.fromJson(e)).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}

class FollowerRepository {
  String login;
  final String _baseUrl = 'https://api.github.com/users/';

  FollowerRepository(this.login);

  Future<List<Follower>> getFollowers() async {
    Response res = await get(Uri.parse('$_baseUrl$login/followers'));

    if (res.statusCode == 200) {
      final List result = jsonDecode(res.body);
      return result.map((e) => Follower.fromJson(e)).toList();
    } else {
      throw Exception(res.reasonPhrase);
    }
  }
}
