import 'package:fluttertoast/fluttertoast.dart';

class BaseToast {
  static void show(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
}
