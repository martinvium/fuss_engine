part of fussengine.editor;

class Menu {
  static var _squareCount = 0;
  static var _imageCount = 0;
  
  var scene;
  SceneStorage storage;
  
  Menu(Scene this.scene, SceneStorage this.storage);
  
  init() {
    querySelector('#save-scene').onClick.listen(this.actionSaveScene);
    
    var list = querySelector('#menu-file-load-list');
    storage.querySceneNames().then((cursors) {
      cursors.listen((cursor) {
        _createLoadSceneMenuItem(list, cursor);
      });
    });
    
    querySelector('#create-square').onClick.listen(this.actionCreateSquare);
    querySelector('#create-image').onClick.listen(this.actionCreateImage);
  }
  
  _createLoadSceneMenuItem(list, cursor) {
    var anchor = new AnchorElement(href: '#')
    ..tabIndex = -1
    ..text = cursor.key.toString()
    ..onClick.listen(_onClickLoadScene);
    
    var li = new LIElement()
    ..append(anchor);
    
    list.append(li);
  }
  
  _onClickLoadScene(e) {
    print('please load');
    storage.loadScene((e.target as AnchorElement).text).then((scene) {
      print('loaded ${scene.name}');
    });
    e.preventDefault();
  }
  
  actionSaveScene(e) {
    storage.saveScene(scene);
    e.preventDefault();
  }

  actionCreateSquare(e) {
    var go = new GameObject.create()
      ..name = "Square ${_squareCount++}"
      ..add(new Transform.create(100, 50, 100, 100))
      ..add(new ShapeRenderer.create("rgb(200,0,0)"));
    scene.addGameObject(go);
    e.preventDefault();
  }

  actionCreateImage(e) {
    var go = new GameObject.create()
      ..name = "Image ${_imageCount}"
      ..add(new Transform.create(150, 10, 75, 75))
      ..add(new SpriteRenderer.create("assets/images/face.png"));
    scene.addGameObject(go);
    e.preventDefault();
  }
}