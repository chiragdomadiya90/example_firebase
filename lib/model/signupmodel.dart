class signupmodel {
  String? firstName;
  String? lastName;
  String? username;
  String? password;

  signupmodel({this.firstName, this.lastName, this.username, this.password});

  signupmodel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
