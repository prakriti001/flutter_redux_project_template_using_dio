import 'package:personal_pjt/data/api/api_client.dart';
import 'package:personal_pjt/data/api/api_routes.dart';

enum Env {
  test,
  prod,
}

final Env devEnvironment = Env.prod;

class AppConstants {
  static const String MobileNumberPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  static const String IFSCCodePattern = r'(^[A-Za-z]{4}[a-zA-Z0-9]{7}$)';
  static String cashFreeAppStage =
      (devEnvironment == Env.test) ? 'TEST' : 'PROD';
  static String cashFreeAppID = (devEnvironment == Env.test)
      ? "813537cba666175caa9708c9c35318"
      : "1281501e428be2dc917daefccb051821";
  static String cashFreeAppNotifyURL = (devEnvironment == Env.test)
      ? "https://api.uat.finobuddy.com/api/v1/webhook/cashfree/payment_success"
      : "https://api.staging.finobuddy.com/api/v1/webhook/cashfree/payment_success";

  static String bajajFdLimit = (devEnvironment == Env.test) ? '1' : '25000';

  static String digiTapClientId = '25306576';
  static String digiTapClientSecret = 'jqW13cW2MMjstr21RFVSL15QAmP2NWZa';

//"813537cba666175caa9708c9c35318"; test
//"1281501e428be2dc917daefccb051821"; live
}
