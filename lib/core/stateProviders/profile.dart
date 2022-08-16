import 'package:flutter/widgets.dart';
import 'package:flutter_mod_app/core/models/user_data.dart';
import 'package:flutter_mod_app/core/repositories/auth.dart';
import 'package:flutter_mod_app/core/repositories/userProfile.dart';

class ProfileStateProvider with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();
  final AuthRepository _authRepo = AuthRepository();
  late UserData? _profileData;
  late String? _email;

  void _setData(Map<String, dynamic> data) {
    _profileData = UserData.fromMap(data);
    notifyListeners();
  }

  void updateProfile(UserData data) {
    _profileRepository.setInfo(_email!, data);
  }

  ProfileStateProvider() {
    _authRepo.authStream.listen((user) {
      if (user != null) {
        _email = user.email!;
        var userStream = _profileRepository.getUserStream(_email!);
        userStream.listen((event) {
          var data = event.data();
          if (data != null) {
            _setData(event.data()!);
          } else {
            _profileRepository
                .addUserInfo(UserData(_email!, "", "", "", "", "", ""));
          }
        });
      }
    });
  }

  UserData? get getProfileData => _profileData;
}
