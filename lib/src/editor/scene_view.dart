part of fussengine.editor;

class SceneView {
  var startX = 0, startY = 0;
  var drag = false;
  var mouseX = 0, mouseY = 0;
  var mousePressed = false;
  Scene scene;
    
  SceneView(canvas, scene) {
    this.scene = scene;
    
    canvas.onMouseMove.listen(this.onMouseMove);
    canvas.onMouseDown.listen(this.onMouseDown);
    canvas.onMouseUp.listen(this.onMouseUp);
    canvas.onClick.listen(this.onClick);
  }
  
  onClick(e) {
    print("Click select not yet supported");
  }
  
  onMouseMove(e) {
    mouseX = e.offsetX;
    mouseY = e.offsetY;
  }
  
  onMouseDown(e) {
    mousePressed = true;
  }
  
  onMouseUp(e) {
    mousePressed = false;
  }

  update() {
    if(scene.selected == null) return;

    Transform transform = scene.selected.components["Transform"];

    if (mousePressed){
        var left = transform.x;
        var right = transform.x + transform.width;
        var top = transform.y;
        var bottom = transform.y + transform.height;
        if (!drag){
          startX = mouseX - transform.x;
          startY = mouseY - transform.y;
        }
        if (mouseX < right && mouseX > left && mouseY < bottom && mouseY > top){
           drag = true;
        }
    }else{
       drag = false;
    }

    if (drag){
        scene.selected.components["Transform"].x = mouseX - startX;
        scene.selected.components["Transform"].y = mouseY - startY;
    }
  }
}