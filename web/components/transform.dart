library fussengine.components;
import "component.dart";

class Transform implements Component {
  var name = "Transform";
  var x;
  var y;
  var width;
  var height;
  
  Transform(x, y, width, height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  render(ctx, transform) {}
  update() {}
}