part of fussengine.engine;

class CanvasSceneRenderer {
  var canvas;
  var ctx;
  var scene;
  
  CanvasSceneRenderer(this.canvas, Scene this.scene) {
    this.ctx = this.canvas.getContext('2d');
  }

  renderScene(Scene scene) {
    this.emptyCanvas();

    for(var go in scene.gameObjects) {
      this.renderGameObject(go);
    }

    this.highlight(scene.selected);
  }

  emptyCanvas() {
    this.ctx.clearRect(0, 0, canvas.width, canvas.height);
  }

  // TODO extract this to somewhere else? a gui layer probably...
  highlight(GameObject go) {
    if(go == null) return;
    
    Transform transform = go.components["Transform"];
    ctx.strokeStyle = "magenta";
    ctx.beginPath();
    ctx.rect(transform.x, transform.y, transform.width, transform.height);
    ctx.stroke();
  }

  renderGameObject(go) {
    for(var component in go.components.values) {
       this.renderComponent(component, go);
    }
  }

  renderComponent(renderer, go) {
    renderer.render(ctx, go.components["Transform"]);
  }
}