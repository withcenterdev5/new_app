import 'package:fireflutter/fireflutter.dart';

userInit() {
  UserService.instance.get(myUid ?? '');
}
