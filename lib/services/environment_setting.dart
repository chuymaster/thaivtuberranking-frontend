import 'package:flutter/foundation.dart';

enum DeployEnvironment { Debug, Qa, Production }

class EnvironmentSetting {
  static EnvironmentSetting shared = EnvironmentSetting();

  var deployEnvironment = DeployEnvironment.Debug;
  var isReleaseMode = kReleaseMode;

  EnvironmentSetting() {
    const env =
        String.fromEnvironment('DEPLOY_ENVIRONMENT', defaultValue: "Debug");
    switch (env) {
      case "Production":
        deployEnvironment = DeployEnvironment.Production;
        break;
      case "Qa":
        deployEnvironment = DeployEnvironment.Qa;
        break;
      default:
        deployEnvironment = DeployEnvironment.Debug;
        break;
    }
  }
}
