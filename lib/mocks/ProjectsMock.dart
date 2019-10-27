
import 'package:flutter_linkimager/Types.dart';

import '../Utils.dart';

void test() {

}

class Projects {
  static LinkImage one = _getProject1();
}

LinkImage _getProject1() {
  var startImage = LinkImage(
    Media.Photo,
    "https://media-cdn.tripadvisor.com/media/photo-s/0e/38/76/58/korridor.jpg"
  );

  var centerImage = LinkImage(
    Media.Photo,
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6zSasJr1EegqFFC8uZCRA34oWFTh0ozSCRYrNN8AFsJ1tRPH50g",
    PercentRectangle(0.38, 0.37, 0.25, 0.25)
  );

  var rightImage = LinkImage(
    Media.Photo,
    "https://www.stenaline.co.uk/-/media/Images/Global-images/Ships/Stena-lagan-mersey/lagan-mersey-4b-inside-cabin-1.jpg?w=220",
    new PercentRectangle(0.70, 0.38, 0.20, 0.30)
  );

  var leftImage = LinkImage(
    Media.Photo,
    "https://ae01.alicdn.com/kf/HTB1ZEqEBY5YBuNjSspoq6zeNFXa2/Nature-Landscape-3D-Window-View-Wall-Stickers-For-Living-Room-Bedroom-Decorative-Decoration-Home-PVC-Decor.jpg",
    PercentRectangle(0.10, 0.35, 0.10, 0.15)
  );
  connect(startImage, centerImage);
  connect(startImage, rightImage);
  connect(startImage, leftImage);
  return startImage;
}