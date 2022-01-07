class TweetModel {
  late int id;
  late String image, description;

  TweetModel({
    required this.id,
    required this.description,
    required this.image,
  });

  TweetModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    image = map['image']['url'];
  }
}
