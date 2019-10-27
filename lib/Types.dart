

/* To make it easy to serialize project into json*/
// https://github.com/Lelelo1/tns-linkimager/blob/master/app/Mixins/Mixins.ts

abstract class Linkable {
  List<Linkable> owners;
  Media media;
  String url;
  List<Linkable> links;
  PercentRectangle percentRectangle;
}

class LinkImage extends Linkable {
  LinkImage(Media media, String url, [ PercentRectangle percentRectangle ]) {
    this.owners = List<Linkable>();
    this.media = media;
    this.url = url;
    this.links = List<Linkable>();
    if(percentRectangle != null) {
      this.percentRectangle = percentRectangle;
    }
    // this.percentRectangle origin linkimage never has it
  }
}

enum Media {
  Photo,
  Video,
  Sound
}

class PercentRectangle {
  double xPercentage;

  double yPercentage;

  double widthPercentage;

  double heightPercentage;

  PercentRectangle(double xPercentage, double yPercentage, double widthPercentage, double heightPercentage) {
    var errorMsg = "should be between 0 and 1. Could not contruct PercentageRectangle";
    if(xPercentage < 0 || xPercentage > 1) {
      throw ArgumentError("xPercentage " + errorMsg);
    }
    if(yPercentage < 0 || yPercentage > 1) {
      throw ArgumentError("yPercentage " + errorMsg);
    }
    if(widthPercentage < 0 || widthPercentage > 1) {
      throw ArgumentError("widthPercentage " + errorMsg);
    }
    if(heightPercentage < 0 || heightPercentage > 1) {
      throw ArgumentError("xPercentage " + errorMsg);
    }
    this.xPercentage = xPercentage;
    this.yPercentage = yPercentage;
    this.widthPercentage = widthPercentage;
    this.heightPercentage = heightPercentage;
  }
}