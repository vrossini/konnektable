class Repo {
  String? name;
  String? description;
  double? stars;

  Repo({this.name, this.description, this.stars});

  Repo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    stars = json['stargazers_count'] <= 5 ? json['stargazers_count'].toDouble() : 5.0;
  }
}
