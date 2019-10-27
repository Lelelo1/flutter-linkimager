
import 'package:flutter/material.dart';

import 'Types.dart';

connect(LinkImage owner, LinkImage link) {
    // only if the connection did not exist it shoul be made
    if(!owner.links.contains(link) && !link.owners.contains((owner))) {
      owner.links.add(link);
      link.owners.add(owner);
      debugPrint("connected " + link.toString() + " and " + owner.toString() + " succesfully");
      return;
    }
    
    throw Exception("Failed to connect " +  link.toString() + " and " + owner.toString() + " as they either partially or fully already was connected ");
  }