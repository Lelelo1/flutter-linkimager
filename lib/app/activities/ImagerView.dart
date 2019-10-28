import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkimager/app/activities/ImagerEdit.dart';

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
  State<StatefulWidget> createState() => _ImagerViewState(project, viewModel);
}

class _ImagerViewState extends State<ImagerView>
    with AfterLayoutMixin<ImagerView> {
  LinkImage currentLinkImage;
  ViewModel viewModel;
  _ImagerViewState(LinkImage project, ViewModel viewModel) {
    this.currentLinkImage = project;
    this.viewModel = viewModel;

    autorun((_) {
      debugPrint("size changed to: " + viewModel.screenSize.toString());
      debugPrint("statusBarHeight changed to "  + viewModel.statusBarHeight.toString());
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
            FractionallySizedBox(
              child: Stack(
                  children: List.from(areas(currentLinkImage.links))
                    ..insert(
                      0,
                      Image.network(currentLinkImage.url,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover),
                    )),
              widthFactor: 1,
              heightFactor: 1,
              key: _screenKey,
            ),
            Positioned(
              child: Observer(builder: (_) => Container(
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
                margin: EdgeInsets.only(left: SideBar.getLeftMargin(viewModel)),
              ),
            ),
              
              right: 0,
              top: SideBar.getY(viewModel),
              bottom: 0,
              width: SideBar.getWidth(viewModel),
              
            ),
            Positioned(
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
                        Icons.edit,
                      ),
                      onPressed: () => _editMode(),
                    )
                  ],
                  key: _appBarKey,
                ),
                left: 0,
                top: 0,
                right: 0,
            )
          ],
        ));
  }
  double getSideBarWidth() {
    debugPrint("sideBarWidth: " + viewModel.appBarSize.height.toString());
    return viewModel.appBarSize.height;
  } 
  @override
  void afterFirstLayout(BuildContext context) {
    debugPrint("setting appBar size and screen size");
    viewModel.appBarSize = AfterLayout.getSizeOf(_appBarKey);
    viewModel.screenSize = AfterLayout.getSizeOf(_screenKey);
    viewModel.statusBarHeight = MediaQuery.of(context).padding.top;
    debugPrint("statusBarHeight: " + viewModel.statusBarHeight.toString());
  }

  _editMode() {
    Navigator.push(context,
        GhostRoute<MaterialPageRoute>(builder: (context) => ImagerEdit()));
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

  List<Widget> areas(List<Linkable> links) {
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
                  ),
                  onTap: () => _areaPressed(link),
                ),
                left: Screen.getX(link.percentRectangle, viewModel),
                top: Screen.getY(link.percentRectangle, viewModel),
              ),
            ))
        .toList();
  }

  _areaPressed(Linkable link) {
    setState(() {
      var to = LinkImage(link.media, link.url, link.percentRectangle);
      to.owners = link.owners;
      to.links = link.links;
      currentLinkImage = to;
    });
  }
}
/*
  Note BoxFit.cover maintains aspect ratio wwhile BoxFit.fill distorts it.
  BoxFit.cover is just like apsectFill in nativescript!
*/
