library fussengine.components;
import "component.dart";
import "dart:html";

class SpriteRenderer implements Component {
  var name = "SpriteRenderer";
  var path;
  ImageElement img;
  
  SpriteRenderer(path) {
    this.path = path;
    this.img = new ImageElement();
    this.img.src = this.path;
  }  

  render(CanvasRenderingContext2D ctx, transform) {
    ctx.drawImage(img, transform.x, transform.y);
  }
  
  update() {}
}