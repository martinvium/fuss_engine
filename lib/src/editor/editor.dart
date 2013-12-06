part of fussengine.editor;

class Editor {
  Scene _scene;
  var actions;
  var hierarchy;
  var inspector;
  var renderer;
  var sceneView;
  var storage;
  
  // proxy stuff
  set selected(GameObject go) => scene.selected;
  GameObject get selected {
    if(scene != null) {
      return scene.selected;
    } else {
      return null;
    }
  }
  
  List<GameObject> get gameObjects => scene.gameObjects;
  Future querySceneNames() => storage.querySceneNames();
  loadScene(String sceneName) => storage.loadScene(sceneName);
  
  // scene loaded callback
  StreamController _onLoadSceneController = new StreamController.broadcast();
  Stream get onLoadScene => _onLoadSceneController.stream;
  
  StreamController _onAddGameObjectController = new StreamController.broadcast();
  Stream get onAddGameObject => _onAddGameObjectController.stream;
  
  StreamController _onSelectGameObjectController = new StreamController.broadcast();
  Stream get onSelectGameObject => _onSelectGameObjectController.stream;
  
  selectGameObject(id) { 
    var go = scene.findById(id);
    scene.selected = go;
    _onSelectGameObjectController.add(go);
  }
  
  addGameObject(GameObject go) {
    if(scene == null) {
      print("Cannot add game object, scene not loaded");
      return;
    }
    
    scene.gameObjects.add(go);
    _onAddGameObjectController.add(go);
  }
  
  Scene get scene => _scene;
  set scene(Scene scene) {
    print("Loaded scene ${scene.name}");
    _scene = scene;
    _onLoadSceneController.add(_scene);
  }
  
  Editor.initialized() {
    initialize();
  }
  
  saveScene() {
    storage.saveScene(scene);
  }
  
  initialize() {
    storage = new SceneStorage();
    
    actions = new Menu(this);
    actions.init();
    
    hierarchy = new Hierarchy(querySelector('#hierarchy'), this);
    hierarchy.register();
    
    inspector = new Inspector(querySelector('#inspector'), this);
    inspector.register();
    
    renderer = new CanvasSceneRenderer(querySelector('#sceneView'));

    sceneView = new SceneView(this);
    sceneView.register(querySelector('#sceneView'));
    
    // main loop
    var future = new Timer.periodic(const Duration(milliseconds: 30), mainLoop);
  }
  
  
  void mainLoop(timer) {
    if(scene != null) {
      sceneView.update();
      renderer.renderScene(scene);
    }
  }
}