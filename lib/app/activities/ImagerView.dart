import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_linkimager/mocks/ProjectsMock.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../Types.dart';
import '../../ViewModel.dart';

class ImagerView extends StatefulWidget {
  final LinkImage project = Projects.one;

  @override
  State<StatefulWidget> createState() => _ImagerViewState(project, ViewModel());
}

class _ImagerViewState extends State<ImagerView>
    with AfterLayoutMixin<ImagerView> {
  LinkImage currentLinkImage;
  ViewModel viewModel;
  _ImagerViewState(LinkImage project, ViewModel viewModel) {
    this.currentLinkImage = project;
    this.viewModel = viewModel;

    autorun((_) {
      debugPrint("size changed to: " + viewModel.size.toString());
    });
  }

  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(children: <Widget>[
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
          key: _key,
        ),
        Positioned(
          child: AppBar(
            title: Text("Hello!"),
            backgroundColor: Color.fromARGB(20, 1, 1, 1), // transparent
            elevation: 0, // remove shadow
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => _navigateBack(currentLinkImage),
              )
            ),
          left: 0,
          top: 0,
          right: 0,
          )
        ]
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    debugPrint("setting imagerScreen size");
    viewModel.size = _getImagerScreen(_key);
  }

  _navigateBack(LinkImage currentLinkImage) {
    LinkImage backTo;
    try {
      backTo = currentLinkImage.owners.first;
    } catch(Exception) {
      
    }
    if(backTo != null) {
      debugPrint("backTo: " + backTo.toString());
      setState(() {
        this.currentLinkImage = backTo;
      });
    }
  }

  Size _getImagerScreen(GlobalKey key) {
    RenderBox box = key.currentContext.findRenderObject();
    debugPrint("got imagerRectangle: " +
        box.size.width.toString() +
        ", " +
        box.size.height.toString());
    return Size(box.size.width, box.size.height);
  }

  List<Widget> areas(List<Linkable> links) {
    debugPrint("links size: " + links.length.toString());
    // getting weird smaller sized readin from this: var query = MediaQuery.of(context);
    debugPrint("size is; " + viewModel.size.toString());
    return links
        .map((link) => Observer(
              builder: (_) => Positioned(
                child: GestureDetector(
                  child: Image.network(
                    link.url,
                    width: _getWidth(link.percentRectangle.widthPercentage),
                    height: _getHeight(link.percentRectangle.heightPercentage),
                    fit: BoxFit.fill,
                  ),
                  onTap: () => _areaPressed(link),
                ),
                left: _getX(link.percentRectangle.xPercentage),
                top: _getY(link.percentRectangle.yPercentage),
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

  double _getX(double percent) {
    var x = percent * viewModel.size.width;
    debugPrint("x: " + x.toString());
    return x;
  }

  double _getY(double percent) {
    var y = percent * viewModel.size.height;
    debugPrint("y: " + y.toString());
    return y;
  }

  double _getWidth(double percent) {
    var w = percent * viewModel.size.width;
    debugPrint("w: " + w.toString());
    return w;
  }

  double _getHeight(double percent) {
    var h = percent * viewModel.size.height;
    debugPrint("h: " + h.toString());
    return h;
  }
}
/*
  Note BoxFit.cover maintains aspect ratio wwhile BoxFit.fill distorts it.
  BoxFit.cover is just like apsectFill in nativescript!
*/
