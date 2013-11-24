library fussengine.engine;
import "game_object.dart";
import 'dart:async';

var gameObjectCount = 0;

class Scene {
  List<GameObject> gameObjects = [];
  var selected = null;
  var name = "";
  
  StreamController _onAddGameObjectController = new StreamController.broadcast();
  Stream get onAddGameObject => _onAddGameObjectController.stream;
  StreamController _onSelectGameObjectController = new StreamController.broadcast();
  Stream get onSelectGameObject => _onSelectGameObjectController.stream;
  
  Scene(name) {
    this.name = name;
  }

  void addGameObject(go) {
    this.gameObjects.add(go);
    this._onAddGameObjectController.add(go);
  }

  void selectGameObject(id) {
    var go = this.findById(id);
    this.selected = go;
    this._onSelectGameObjectController.add(go);
  }

  GameObject findById(int id) {
    return this.gameObjects.firstWhere((go) => go.id == id);
  }
  
  void update() {
    // TODO implement
  }
}