class UserData {
  String email;
  String? nick;
  String? name;
  String? surname;
  String? age;
  String? city;
  String? avatarUrl;

  UserData(this.email, this.nick, this.name, this.surname, this.age, this.city,
      this.avatarUrl);

  Map<String, dynamic> toMap() => {
        "email": email,
        "nick": nick,
        "name": name,
        "surname": surname,
        "age": age,
        "city": city,
        "avatarUrl": avatarUrl
      };

  factory UserData.fromMap(Map<String, dynamic> map) {
    String email = map["email"];
    String? nick = map["nick"];
    String? name = map["name"];
    String? surname = map["surname"];
    String? age = map["age"];
    String? city = map["city"];
    String? avatarUrl = map["avatarUrl"];
    return UserData(email, nick, name, surname, age, city, avatarUrl);
  }

  factory UserData.createEmpty() => UserData("", "", "", "", "", "", "");

  UserData copyWith({
    String? email,
    String? nick,
    String? name,
    String? surname,
    String? age,
    String? city,
    String? avatarUrl,
  }) {
    return UserData(
        email ?? this.email,
        nick ?? this.nick,
        name ?? this.nick,
        surname ?? this.surname,
        age ?? this.age,
        city ?? this.city,
        avatarUrl ?? this.avatarUrl);
  }
}
