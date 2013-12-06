part of fussengine.engine;

class Scene {
  var gameObjects = new List<GameObject>();
  GameObject selected;
  var name = "";
  
  Scene();
  Scene.create(String this.name);

  GameObject findById(String id) {
    return this.gameObjects.firstWhere((go) => go.id == int.parse(id));
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