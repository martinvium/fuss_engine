part of fussengine.editor;

class SceneView {
  var startX = 0, startY = 0;
  var drag = false;
  var mouseX = 0, mouseY = 0;
  var mousePressed = false;
  Editor editor;
    
  SceneView(Editor this.editor);
  
  register(Element canvas) {
    canvas.onMouseMove.listen(onMouseMove);
    canvas.onMouseDown.listen(onMouseDown);
    canvas.onMouseUp.listen(onMouseUp);
    canvas.onClick.listen(onClick);
    editor.onLoadScene.listen(onLoadScene);
  }
  
  onLoadScene(e) {
    querySelector('#scene-title').text = editor.scene.name;
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
    if(editor.selected == null) return;

    Transform transform = editor.selected.components["Transform"];

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
      transform.x = mouseX - startX;
      transform.y = mouseY - startY;
    }
  }
}