class Users {
  String id;
  String name;
  String email;
  String phoneNumber;
  String type;
  String url;
  Users(
      {this.id, this.name, this.email, this.phoneNumber, this.type, this.url});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
