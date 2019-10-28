// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ViewModel on _ViewModel, Store {
  final _$screenSizeAtom = Atom(name: '_ViewModel.screenSize');

  @override
  Size get screenSize {
    _$screenSizeAtom.context.enforceReadPolicy(_$screenSizeAtom);
    _$screenSizeAtom.reportObserved();
    return super.screenSize;
  }

  @override
  set screenSize(Size value) {
    _$screenSizeAtom.context.conditionallyRunInAction(() {
      super.screenSize = value;
      _$screenSizeAtom.reportChanged();
    }, _$screenSizeAtom, name: '${_$screenSizeAtom.name}_set');
  }

  final _$appBarSizeAtom = Atom(name: '_ViewModel.appBarSize');

  @override
  Size get appBarSize {
    _$appBarSizeAtom.context.enforceReadPolicy(_$appBarSizeAtom);
    _$appBarSizeAtom.reportObserved();
    return super.appBarSize;
  }

  @override
  set appBarSize(Size value) {
    _$appBarSizeAtom.context.conditionallyRunInAction(() {
      super.appBarSize = value;
      _$appBarSizeAtom.reportChanged();
    }, _$appBarSizeAtom, name: '${_$appBarSizeAtom.name}_set');
  }

  final _$statusBarHeightAtom = Atom(name: '_ViewModel.statusBarHeight');

  @override
  double get statusBarHeight {
    _$statusBarHeightAtom.context.enforceReadPolicy(_$statusBarHeightAtom);
    _$statusBarHeightAtom.reportObserved();
    return super.statusBarHeight;
  }

  @override
  set statusBarHeight(double value) {
    _$statusBarHeightAtom.context.conditionallyRunInAction(() {
      super.statusBarHeight = value;
      _$statusBarHeightAtom.reportChanged();
    }, _$statusBarHeightAtom, name: '${_$statusBarHeightAtom.name}_set');
  }
}
