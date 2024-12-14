class AppUser {
  final String id;
  final String email;
  final String name;

  AppUser({required this.id, required this.email, required this.name});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'AppUser{id: $id, email: $email, name: $name}';
  }
  
}
