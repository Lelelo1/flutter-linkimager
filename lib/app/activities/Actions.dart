

import 'package:flutter/material.dart';
import 'package:flutter_linkimager/Types.dart';
import 'package:flutter_linkimager/app/activities/ImagerView.dart';

class Action {
  Action _instance;
  Action get(ImagerViewState state) {
    if(_instance == null) {
      _instance = Action();
    }
    _instance.state = state;
    return _instance;
  }
  ImagerViewState state;


  onPressedArea(Linkable link) {
    
    switch (state.activity) {
      case Activity.view:
        _activity_view_pressed(link);
      break;
      case Activity.build:
        _activity_build_pressed(link);
      break;
      case Activity.take:
        // no area should present
        break;
    }
  }

  _activity_view_pressed(Linkable link) {
    
    var navigate = () {
      /* can't seem to use setState outside state
      state.setState(() {
          var to = LinkImage(link.media, link.url, link.percentRectangle);
          to.owners = link.owners;
          to.links = link.links;
          state.currentLinkImage = to;
        })
        */
      var to = LinkImage(link.media, link.url, link.percentRectangle);
      to.owners = link.owners;
      to.links = link.links;
      state.currentLinkImage = to;
    };
    switch(link.media) {
      case Media.Photo:
        navigate();
        break;
      case Media.Video:
        // play video
        break;
      case Media.Sound:
        // play sound
        break;
      }
    }
  }
  _activity_build_pressed(Linkable link) {
    
  }

  _pre
}