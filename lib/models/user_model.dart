

class UserModel {
  String? userid;
  String? email;
  String? firstname;
  String? lastname;
  String? role;
  String? image;

  UserModel(
      {this.userid,
      this.email,
      this.firstname,
      this.lastname,
      this.role,
      this.image});
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      image: data["profile"] ?? "",
      userid: data['userId'],
      email: data['email'],
      firstname: data['firstname'],
      lastname: data['lastname'],
      role: data['role'],
    );
  }
}
