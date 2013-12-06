part of fussengine.editor;

class Editor {
  Scene scene;
  var actions;
  var hierarchy;
  var inspector;
  var renderer;
  var sceneView;
  var storage;
  
  // proxy stuff
  GameObject get selected => scene.selected;
  Stream get onSelectGameObject => scene.onSelectGameObject;
  Stream get onAddGameObject => scene.onAddGameObject;
  List<GameObject> get gameObjects => scene.gameObjects;
  StreamController _onLoadSceneController = new StreamController.broadcast();
  Stream get onLoadScene => _onLoadSceneController.stream;
  selectGameObject(id) => scene.selectGameObject(id);
  addGameObject(GameObject go) => scene.addGameObject(go);
  Future querySceneNames() => storage.querySceneNames();
  loadScene(String sceneName) => storage.loadScene(sceneName);
  
  Editor.initialized() {
    initialize();
  }
  
  saveScene() {
    storage.saveScene(scene);
  }
  
  initialize() {
    scene = new Scene.create("My scene");
    storage = new SceneStorage();
    
    actions = new Menu(this);
    actions.init();
    
    hierarchy = new Hierarchy(querySelector('#hierarchy'), this);
    hierarchy.register();
    
    inspector = new Inspector(querySelector('#inspector'), this);
    inspector.register();

    renderer = new CanvasSceneRenderer(querySelector('#sceneView'), scene);

    sceneView = new SceneView(querySelector('#sceneView'), scene);
    
    querySelector('#scene-title').text = scene.name;

    // main loop
    var future = new Timer.periodic(const Duration(milliseconds: 30), mainLoop);
  }
  
  void mainLoop(timer) {
    sceneView.update();
    //inspector.update();
    scene.update();
    renderer.renderScene(scene);
  }
}