import 'package:fluttertoast/fluttertoast.dart';
import 'index.dart';

void showToast({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.blueColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
