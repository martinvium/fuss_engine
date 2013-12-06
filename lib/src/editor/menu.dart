part of fussengine.editor;

class Menu {
  static const String DEFAULT_SCENE_NAME = 'Untitled scene';
  static var _squareCount = 0;
  static var _imageCount = 0;
  
  Editor editor;
  
  Menu(Editor this.editor);
  
  init() {
    querySelector('#new-scene').onClick.listen(this.actionNewScene);
    querySelector('#save-scene').onClick.listen(this.actionSaveScene);
    
    var list = querySelector('#menu-file-load-list');
    editor.querySceneNames().then((cursors) {
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
    editor.loadScene((e.target as AnchorElement).text).then((scene) {
      editor.scene = scene;
    });
    e.preventDefault();
  }
  
  actionNewScene(e) {
    editor.scene = new Scene.create(DEFAULT_SCENE_NAME);
    e.preventDefault();
  }
  
  actionSaveScene(e) {
    editor.saveScene();
    e.preventDefault();
  }

  actionCreateSquare(e) {
    var go = new GameObject.create()
      ..name = "Square ${_squareCount++}"
      ..add(new Transform.create(100, 50, 100, 100))
      ..add(new ShapeRenderer.create("rgb(200,0,0)"));
    editor.addGameObject(go);
    e.preventDefault();
  }

  actionCreateImage(e) {
    var go = new GameObject.create()
      ..name = "Image ${_imageCount}"
      ..add(new Transform.create(150, 10, 75, 75))
      ..add(new SpriteRenderer.create("assets/images/face.png"));
    editor.addGameObject(go);
    e.preventDefault();
  }
}