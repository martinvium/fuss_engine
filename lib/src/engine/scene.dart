part of fussengine.engine;

class Scene {
  var gameObjects = new List<GameObject>();
  GameObject selected;
  var name = "";
  
  StreamController _onAddGameObjectController = new StreamController.broadcast();
  Stream get onAddGameObject => _onAddGameObjectController.stream;
  StreamController _onSelectGameObjectController = new StreamController.broadcast();
  Stream get onSelectGameObject => _onSelectGameObjectController.stream;
  
  Scene(String this.name);

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
}