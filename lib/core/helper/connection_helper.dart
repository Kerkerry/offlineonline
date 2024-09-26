import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:offlineapp/core/helper/log_helper.dart';

class InternetConnectionHelper {
  // Function to check if the device is connected to the internet
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    logger.d("Connection result is: ${connectivityResult[0]}");
    if (connectivityResult[0] == ConnectivityResult.none) {
      return false; // Not connected to any network
    } else if (connectivityResult[0] == ConnectivityResult.mobile ||
        connectivityResult[0] == ConnectivityResult.wifi ||
        connectivityResult[0] == ConnectivityResult.vpn) {
      return true; // Connected to either mobile data or wifi
    }
    return false; // Default to not connected
  }
}
