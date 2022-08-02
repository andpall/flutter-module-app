import 'package:flutter/widgets.dart';
import 'package:flutter_mod_app/core/models/user_data.dart';
import 'package:flutter_mod_app/core/repositories/auth.dart';
import 'package:flutter_mod_app/core/repositories/userProfile.dart';

class ProfileStateProvider with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();
  final AuthRepository _authRepo = AuthRepository();
  late UserData _profileData;
  late String _email;

  void _setData(UserData data) {
    _profileData = data;
    notifyListeners();
  }

  ProfileStateProvider() {
    _authRepo.authStream.listen((user) {
      if (user != null) {
        _email = user.email!;
      }
    });
    _profileRepository.listenUser(_email, _setData);
    _email = _authRepo.getUser()!.email!;
    _profileRepository.getUserMap(_email).then(
        (map) => _profileData = _profileRepository.getUserDataFromMap(map!));
  }

  UserData? get getProfileData => _profileData;
}
