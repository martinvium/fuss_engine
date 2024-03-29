part of fussengine.engine;

class GameObject {
  int id;
  String name;
  Map<String,Component> components = new HashMap<String,Component>();
  static int _gameObjectCount = 0;
  
  GameObject();
  
  GameObject.create() {
    _gameObjectCount++;
    this.id = _gameObjectCount;
    this.name = "Game Object ${this.id}";
  }
  
  add(Component component) {
    this.components[component.name] = component;
  }
}