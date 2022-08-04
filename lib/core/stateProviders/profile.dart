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
    _profileData = _profileRepository.toUserDataFromMap(data);
    notifyListeners();
  }

  ProfileStateProvider() {
    _authRepo.authStream.listen((user) {
      if (user != null) {
        _email = user.email!;
        _profileRepository.listenUser(_email!, _setData);
      }
    });
  }

  UserData? get getProfileData => _profileData;
}
