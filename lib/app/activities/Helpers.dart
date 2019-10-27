
// navigating without animation
import 'package:flutter/material.dart';
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