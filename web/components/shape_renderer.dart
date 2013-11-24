library fussengine.components;
import "component.dart";

class ShapeRenderer implements Component {
  var name = "ShapeRenderer";
  var color;
  
  ShapeRenderer(color) {
    this.color = color;
  }

  render(ctx, transform) {
    ctx.fillStyle = color;
    ctx.fillRect(transform.x, transform.y, transform.width, transform.height);
  }
}
