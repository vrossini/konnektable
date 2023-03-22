class Profile {
  int? id;
  String? name;
  String? login;
  String? location;
  String? avatar;
  String? bio;
  String? repos;
  String? followers;

  Profile({this.id, this.name, this.login, this.location, this.avatar, this.bio, this.repos, this.followers});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    location = json['location'];
    avatar = json['avatar_url'];
    bio = json['bio'];
    repos = json['public_repos'].toString();
    followers = json['followers'].toString();
  }
}
