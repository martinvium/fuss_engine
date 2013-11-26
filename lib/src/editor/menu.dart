part of fussengine.editor;

class Menu {
  var scene;
  static var _squareCount = 0;
  static var _imageCount = 0;
  
  Menu(Scene this.scene);
  
  register() {
    querySelector('#create-square').onClick.listen(this.actionCreateSquare);
    querySelector('#create-image').onClick.listen(this.actionCreateImage);
  }

  actionCreateSquare(e) {
    var go = new GameObject()
      ..name = "Square ${_squareCount++}"
      ..add(new Transform(100, 50, 100, 100))
      ..add(new ShapeRenderer("rgb(200,0,0)"));
    scene.addGameObject(go);
    e.preventDefault();
  }

  actionCreateImage(e) {
    var go = new GameObject()
      ..name = "Image ${_imageCount}"
      ..add(new Transform(150, 10, 75, 75))
      ..add(new SpriteRenderer("assets/images/face.png"));
    scene.addGameObject(go);
    e.preventDefault();
  }
}