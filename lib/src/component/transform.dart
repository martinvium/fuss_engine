part of fussengine.component;

class Transform implements Component {
  var name = "Transform";
  int x;
  int y;
  int width;
  int height;
  
  Transform.create(int this.x, int this.y, int this.width, int this.height);
  
  render(ctx, transform) {
    
  }
  
  update() {
    
  }
}