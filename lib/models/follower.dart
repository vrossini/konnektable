class Follower {
  String? login;
  String? avatar;

  Follower({this.login, this.avatar});

  Follower.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    avatar = json['avatar_url'];
  }
}
