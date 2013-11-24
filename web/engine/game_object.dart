library fussengine.engine;
import "../components/component.dart";

class GameObject {
  int id;
  String name;
  Map<String,Component> components = {};
  static int _gameObjectCount = 0;
  
  GameObject() {
    _gameObjectCount++;
    this.id = _gameObjectCount;
    this.name = "Game Object ${this.id}";
  }
  
  void add(Component component) {
    this.components[component.name] = component;
  }
}