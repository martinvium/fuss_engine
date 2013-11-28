part of fussengine.engine;

class Scene {
  var gameObjects = new List<GameObject>();
  GameObject selected;
  var name = "";
  
  StreamController _onAddGameObjectController = new StreamController.broadcast();
  Stream get onAddGameObject => _onAddGameObjectController.stream;
  StreamController _onSelectGameObjectController = new StreamController.broadcast();
  Stream get onSelectGameObject => _onSelectGameObjectController.stream;
  
  Scene();
  Scene.create(String this.name);

  addGameObject(GameObject go) {
    this.gameObjects.add(go);
    this._onAddGameObjectController.add(go);
  }

  selectGameObject(String id) {
    var go = this.findById(id);
    this.selected = go;
    this._onSelectGameObjectController.add(go);
  }

  GameObject findById(String id) {
    return this.gameObjects.firstWhere((go) => go.id == int.parse(id));
  }
  
  update() {
    // TODO implement
  }
  
  serialize() {
    return _serializer.write(this);
  }
  
  static Scene unserialize(data) {
    return _serializer.read(data);
  }
  
  static get _serializer {
    var serializer = new Serialization()
      ..addRuleFor(new Scene());
    return serializer;
  }
}