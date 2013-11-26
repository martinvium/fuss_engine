part of fussengine.component;

class ShapeRenderer implements Component {
  var name = "ShapeRenderer";
  String color;
  
  ShapeRenderer(String this.color);

  render(ctx, transform) {
    ctx.fillStyle = color;
    ctx.fillRect(transform.x, transform.y, transform.width, transform.height);
  }
  
  update() {
    
  }
}
