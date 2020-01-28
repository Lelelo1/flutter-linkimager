import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../Types.dart';
import '../../ViewModel.dart';
import 'Helpers.dart';

class ImagerView extends StatefulWidget {
  final LinkImage project;
  final ViewModel viewModel;
  // const ImagerView({Key key, this.project}): super(key: key);
  ImagerView(this.project, this.viewModel);

  @override
  State<StatefulWidget> createState() => ImagerViewState(project, viewModel);
}

enum Activity { view, build, take }

class ImagerViewState extends State<ImagerView>
    with AfterLayoutMixin<ImagerView> {
  LinkImage currentLinkImage;
  ViewModel viewModel;
  Activity activity = Activity.view;
  Stack rootStack;
  ImagerViewState(LinkImage project, ViewModel viewModel) {
    this.currentLinkImage = project;
    this.viewModel = viewModel;

    autorun((_) {
      debugPrint("size changed to: " + viewModel.screenSize.toString());
      debugPrint(
          "statusBarHeight changed to " + viewModel.statusBarHeight.toString());
    });
  }
  GlobalKey _appBarKey = GlobalKey();
  GlobalKey _screenKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: <Widget>[
            renderScreen(),
            renderSideBar(),
            renderAppBar()
          ],
        ));
  }

  Widget renderScreen() {
    List<Widget> content = [Column()];
    if (this.activity == Activity.view || this.activity == Activity.build) {
      content.clear();
      content = renderContent();
    }
    rootStack = Stack(children: content);
    return FractionallySizedBox(
      child: rootStack,
      widthFactor: 1,
      heightFactor: 1,
      key: _screenKey,
    );
  }

  List<Widget> renderContent() {
    var color;
    if (activity == Activity.view) {
      color = Color.fromARGB(0, 0, 0, 0);
    }
    return List.from(areas(currentLinkImage.links, color))
      ..insert( // puts image at the bottom z index 0, and puts all areas on top
        0,
        Image.network(
          currentLinkImage.url,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
  }

  Widget renderSideBar() {
    Widget sideBar = Column();
    if(activity == Activity.build) {
      sideBar = Observer(
          builder: (_) => Positioned(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        child: IconButton(
                          icon: Icon(Icons.text_fields),
                          onPressed: () {
                            debugPrint("pressed text!");
                          },
                        ),
                        color: Color.fromARGB(0, 0, 0, 0),
                      )
                    ],
                  ),
                  color: Color.fromARGB(100, 20, 40, 80),
                  margin:
                      EdgeInsets.only(left: SideBar.getLeftMargin(viewModel)),
                ),
                right: 0,
                top: SideBar.getY(viewModel),
                bottom: 0,
                width: SideBar.getWidth(viewModel),
              )
            );
    }
    return sideBar;
  }
  Widget renderAppBar() {
    Widget appBar = Column();
    if(activity == Activity.build || activity == Activity.view || activity == Activity.take) {
      appBar = Positioned(
              child: AppBar(
                title: Text("Hello!"),
                backgroundColor: Color.fromARGB(20, 1, 1, 1), // transparent
                elevation: 0, // remove shadow
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => _navigateBack(currentLinkImage),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      _activityButton()
                    ),
                    onPressed: () => _changeActivity(),
                  )
                ],
                key: _appBarKey,
              ),
              left: 0,
              top: 0,
              right: 0,
            );
    }
    return appBar;
  }
  IconData _activityButton() {
    IconData icon;
    switch(activity) {
      case Activity.view:
        icon = Icons.build;
      break;
      case Activity.build:
        icon = Icons.image;
        break;
      case Activity.take:
        return icon; // 
        break;
    }
    return icon;
  }
  double getSideBarWidth() {
    debugPrint("sideBarWidth: " + viewModel.appBarSize.height.toString());
    return viewModel.appBarSize.height;
  }

  _changeActivity() {
    try {
      setState(() {
        activity = Activity.values[activity.index + 1];
      });
      if(activity == Activity.take) {
        setState(() {
          activity = Activity.values[activity.index + 1];
        });
      }
    } catch(Exception) {
      setState(() {
        activity = Activity.values[0];
      });
    }
    /*
    Navigator.push(context,
        GhostRoute<MaterialPageRoute>(builder: (context) => ImagerEdit()));
        */
  }

  _navigateBack(LinkImage currentLinkImage) {
    LinkImage backTo;
    try {
      backTo = currentLinkImage.owners.first;
    } catch (Exception) {}
    if (backTo != null) {
      debugPrint("backTo: " + backTo.toString());
      setState(() {
        this.currentLinkImage = backTo;
      });
    }
  }

  List<Widget> areas(List<Linkable> links, Color color) {
    debugPrint("links size: " + links.length.toString());
    // getting weird smaller sized readin from this: var query = MediaQuery.of(context);
    debugPrint("size is; " + viewModel.screenSize.toString());
    return links
        .map((link) => Observer(
              builder: (_) => Positioned(
                child: GestureDetector(
                  child: Image.network(
                    link.url,
                    width: Screen.getWidth(link.percentRectangle, viewModel),
                    height: Screen.getHeight(link.percentRectangle, viewModel),
                    fit: BoxFit.cover,
                    color: color,
                  ),
                  onTap: () => _areaPressed(link),
                ),
                left: Screen.getX(link.percentRectangle, viewModel),
                top: Screen.getY(link.percentRectangle, viewModel),
              ),
            ))
        .toList();
  }

  _getAreaAction(Linkable link) {
    
  }
  _areaPressed(Linkable link) {
    
  }

  @override
  void afterFirstLayout(BuildContext context) {
    debugPrint("setting appBar size and screen size");
    viewModel.appBarSize = AfterLayout.getSizeOf(_appBarKey);
    viewModel.screenSize = AfterLayout.getSizeOf(_screenKey);
    viewModel.statusBarHeight = MediaQuery.of(context).padding.top;
    debugPrint("statusBarHeight: " + viewModel.statusBarHeight.toString());
  }
}

/*
  Note BoxFit.cover maintains aspect ratio wwhile BoxFit.fill distorts it.
  BoxFit.cover is just like apsectFill in nativescript!
*/
