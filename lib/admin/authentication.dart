import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thaivtuberranking/firebase_options.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';

class Authentication {
  static late Authentication instance = Authentication();
  final FirebaseOptions options = EnvironmentSetting.shared.deployEnvironment ==
          DeployEnvironment.Production
      ? DefaultFirebaseOptions.currentPlatform
      : DefaultFirebaseOptions.currentDevPlatform;

  late FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<String?> get accessToken async {
    return await auth.currentUser?.getIdToken(false);
  }
}
