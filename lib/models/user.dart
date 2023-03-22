class GithubUser {
  String? name;
  String? login;
  String? location;
  String? gravatar;

  GithubUser({this.name, this.login, this.location, this.gravatar});

  GithubUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    login = json['login'];
    location = json['location'];
    gravatar = json['gravatar'];
  }
}
