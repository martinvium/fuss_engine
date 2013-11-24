library fussengine.editor;
import "dart:html";

class GameObjectList {
  var view;
  var scene;
  
  GameObjectList(view, scene) {
    this.view = view;
    this.scene = scene;
  }

  register() {
    scene.onAddGameObject.listen(this.update);
  }

  update(e) {
    view.children.clear();
    this.fillList();
  }

  fillList() {
    for(var go in scene.gameObjects) {
      var elem = new LinkElement()
        ..href = "#"
        ..dataset['id'] = go.id.toString()
        ..text = go.name
        ..onClick.listen(this.onClick);
      var wrapper = new LIElement().append(elem);
      view.append(wrapper);
    }
  }

  onClick(e) {
    var id = e.target.dataset['id'];
    view.find('li.active').removeClass('active');
    scene.selectGameObject(id);
    e.target.parent().addClass('active');
    e.preventDefault();
  }
}