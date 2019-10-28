

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

// to make a store - the actual store used hat to be generated
// https://mobx.pub/getting-started 

// mobx observables values has to get used via methods/getters - the Observer component won't update
// when making Observer the builder should take builder: (_) => FlutterWidget
part 'ViewModel.g.dart';
class ViewModel = _ViewModel with _$ViewModel;

abstract class _ViewModel with Store{
  @observable
  Size screenSize = Size(0, 0);
  @observable
  Size appBarSize = Size(0, 0);
  @observable
  double statusBarHeight = 0;
}