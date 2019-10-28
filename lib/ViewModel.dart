

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

// to make a store - the actual store used hat to be generated
// https://mobx.pub/getting-started 
part 'ViewModel.g.dart';
class ViewModel = _ViewModel with _$ViewModel;

abstract class _ViewModel with Store{
  @observable
  Size screenSize = Size(0, 0);
  @observable
  Size appBarSize = Size(0, 0);
}