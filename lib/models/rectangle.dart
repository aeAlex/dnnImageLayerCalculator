class Rectangle {
  int w;
  int h;
  Rectangle({this.w, this.h});

  Map<String, dynamic> toMap() {
    return {'width': this.w, 'height': this.h};
  }
}
