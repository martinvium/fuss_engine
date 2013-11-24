library fussengine.engine;
import "../components/component.dart";
import "dart:collection";

class GameObject {
  int id;
  String name;
  Map<String,Component> components = new HashMap<String,Component>();
  static int _gameObjectCount = 0;
  
  GameObject() {
    _gameObjectCount++;
    this.id = _gameObjectCount;
    this.name = "Game Object ${this.id}";
  }
  
  add(Component component) {
    this.components[component.name] = component;
  }
}