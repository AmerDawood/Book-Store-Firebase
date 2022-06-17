class Users {
  String id;
  String name;
  String email;
  String password;

  Users({
    this.id = '0',
    this.email ='',
    this.name = '',
    this.password = ','

  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['email']= email;
    map['name']= name;
    map['password'] = password;

    return map;
  }
}
