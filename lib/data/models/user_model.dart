class UserModel {
  String userId;
  String userName;
  String email;
  String imageUrl;
  String createdAt;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.imageUrl,
    required this.createdAt,
  });

  UserModel copyWith({
    String? userId,
    String? userName,
    String? email,
    String? imageUrl,
    String? createdAt,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      userId: jsonData['userId'] as String? ?? "",
      userName: jsonData['userName'] as String? ?? '',
      email: jsonData['email'] as String? ?? '',
      imageUrl: jsonData['imageUrl'] as String? ?? '',
      createdAt: jsonData['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return ''''
       userId : $userId,
       userName : $userName,
       email : $email,
       imageUrl : $imageUrl,
       createdAt : $createdAt, 
      ''';
  }
}