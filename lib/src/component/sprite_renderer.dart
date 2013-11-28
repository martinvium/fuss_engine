part of fussengine.component;

class SpriteRenderer implements Component {
  var name = "SpriteRenderer";
  var path;
  ImageElement img;
  
  SpriteRenderer.create(String this.path) {
    this.img = new ImageElement();
    this.img.src = this.path;
  }  

  render(CanvasRenderingContext2D ctx, transform) {
    ctx.drawImage(img, transform.x, transform.y);
  }
  
  update() {
    
  }
}