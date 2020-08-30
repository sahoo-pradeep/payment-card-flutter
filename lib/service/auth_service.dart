import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {

  Future<bool> authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("ERROR in canCheckBiometrics: $e");
      return false;
    }

    print("Biometric is available: $canCheckBiometrics");

    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("ERROR in getAvailableBiometrics: $e");
      return false;
    }

    print("Following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((biometric) {
        print("\tBiometric: $biometric");
      });
    } else {
      print("No biometrics are available");
      return false;
    }

    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Touch your finger to check card details',
          useErrorDialogs: true,
          stickyAuth: false,
          androidAuthStrings:
              AndroidAuthMessages(signInTitle: 'Verify User'));
    } catch (e) {
      print("ERROR in authenticateWithBiometrics: $e");
      return false;
    }

    print("authenticated: $authenticated");
    return authenticated;
  }
}
