
// navigating without animation
import 'package:flutter/material.dart';
import 'package:flutter_linkimager/Types.dart';

import '../../ViewModel.dart';
class GhostRoute<T> extends MaterialPageRoute<T> {
  GhostRoute({ // boilerplate so that parent contructor params don't get missing: https://stackoverflow.com/questions/54161343/how-can-i-initialize-super-class-variables-in-dart-language
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super (builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);
 @override
 Widget buildTransitions(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
    return child;
 }
}

/* get screen sized */
class Screen  {
  static double getX(PercentRectangle percentRectangle, ViewModel viewModel) {
    return percentRectangle.xPercentage * viewModel.screenSize.width;
  }

  static double getY(PercentRectangle percentRectangle, ViewModel viewModel) {
    var y = percentRectangle.yPercentage * viewModel.screenSize.height;
    debugPrint("y: " + y.toString());
    return y;
  }

  static double getWidth(PercentRectangle percentRectangle, ViewModel viewModel) {
    var w = percentRectangle.widthPercentage * viewModel.screenSize.width;
    debugPrint("w: " + w.toString());
    return w;
  }

  static double getHeight(PercentRectangle percentRectangle, ViewModel viewModel) {
    var h = percentRectangle.heightPercentage * viewModel.screenSize.height;
    debugPrint("h: " + h.toString());
    return h;
  }
}

class AfterLayout {
  static Size getSizeOf(GlobalKey key) {
    RenderBox box = key.currentContext.findRenderObject();
    return box.size;
  }
}

class SideBar {
  static getY(ViewModel viewModel) {
    return viewModel.appBarSize.height;
  }
  static getWidth(ViewModel viewModel) {
    return viewModel.appBarSize.height;
  }
  static getHeight(ViewModel viewModel) {
    
  }
  static getLeftMargin(ViewModel viewModel) {
    return viewModel.statusBarHeight;
  }
}