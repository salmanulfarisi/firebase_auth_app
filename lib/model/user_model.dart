class UserModel {
  String id;
  final String? name;
  final String? email;
  final String? image;
  final String? contact;
  final String? location;

  UserModel(
      {required this.name,
      this.email,
      this.image,
      this.contact,
      this.location,
      this.id = ''});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user name': name!,
      'email': email,
      'image': image,
      'location': location,
      'contact': contact
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['user name'],
        email: json['email'],
        image: json['image'],
        location: json['location'],
        contact: json['contact']);
  }
}
