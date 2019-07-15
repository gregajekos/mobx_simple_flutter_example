// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimeTask.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$TimeTask on _TimeTask, Store {
  final _$timeAtom = Atom(name: '_TimeTask.time');

  @override
  int get time {
    _$timeAtom.context.enforceReadPolicy(_$timeAtom);
    _$timeAtom.reportObserved();
    return super.time;
  }

  @override
  set time(int value) {
    _$timeAtom.context.conditionallyRunInAction(() {
      super.time = value;
      _$timeAtom.reportChanged();
    }, _$timeAtom, name: '${_$timeAtom.name}_set');
  }

  final _$_TimeTaskActionController = ActionController(name: '_TimeTask');

  @override
  void updateTime() {
    final _$actionInfo = _$_TimeTaskActionController.startAction();
    try {
      return super.updateTime();
    } finally {
      _$_TimeTaskActionController.endAction(_$actionInfo);
    }
  }
}
