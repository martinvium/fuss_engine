library fussengine.components;
import "component.dart";
import "dart:math";

class inspect {
  const inspect();
}

class Transform implements Component {
  var name = "Transform";
  
  @inspect() var x;
  @inspect() var y;
  @inspect() var width;
  @inspect() var height;
  
  Transform(x, y, width, height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  Rectangle rect() {
    return new Rectangle(x, y, width, height);
  }
  
  render(ctx, transform) {}
  update() {}
}