import 'package:mobx/mobx.dart';

part 'BleModel.g.dart';

class BleModel = _BleModel with _$BleModel;

abstract class _BleModel with Store {
  @observable
  String receivedValue = "n/a";

  @action
  void updateValue(String val) {
    receivedValue = val;
  }
}
