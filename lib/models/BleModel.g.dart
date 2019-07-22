// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BleModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$BleModel on _BleModel, Store {
  final _$receivedValueAtom = Atom(name: '_BleModel.receivedValue');

  @override
  String get receivedValue {
    _$receivedValueAtom.context.enforceReadPolicy(_$receivedValueAtom);
    _$receivedValueAtom.reportObserved();
    return super.receivedValue;
  }

  @override
  set receivedValue(String value) {
    _$receivedValueAtom.context.conditionallyRunInAction(() {
      super.receivedValue = value;
      _$receivedValueAtom.reportChanged();
    }, _$receivedValueAtom, name: '${_$receivedValueAtom.name}_set');
  }

  final _$_BleModelActionController = ActionController(name: '_BleModel');

  @override
  void updateValue(String val) {
    final _$actionInfo = _$_BleModelActionController.startAction();
    try {
      return super.updateValue(val);
    } finally {
      _$_BleModelActionController.endAction(_$actionInfo);
    }
  }
}
