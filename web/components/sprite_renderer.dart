library fussengine.components;
import "component.dart";
import "dart:html";

class SpriteRenderer implements Component {
  var name = "SpriteRenderer";
  var path;
  var img;
  
  SpriteRenderer(path) {
    this.path = path;
    this.img = new ImageElement();
    this.img.src = this.path;
  }  

  render(ctx, transform) {
    ctx.drawImage(img, transform.x, transform.y, transform.width, transform.height);
  }
  
  update() {}
}