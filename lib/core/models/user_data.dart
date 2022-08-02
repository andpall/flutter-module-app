class UserData {
  String email;
  String? nick;
  String? name;
  String? surname;
  String? age;
  String? city;
  String? avatarUrl;

  Map<String, dynamic> toMap() => {
        "email": email,
        "nick": nick,
        "name": name,
        "surname": surname,
        "age": age,
        "city": city,
        "avatarUrl": avatarUrl
      };

  UserData(this.email, this.nick, this.name, this.surname, this.age, this.city,
      this.avatarUrl);

// UserData(Map<String, dynamic> map) {
//   email = map["email"];
//   nick = map["nick"];
//   name = map["name"];
//   surname = map["surname"];
//   age = map["age"];
//   city = map["city"];
//   avatarUrl = map["avatarUrl"];
// }
}
