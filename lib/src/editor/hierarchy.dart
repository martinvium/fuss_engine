part of fussengine.editor;

class Hierarchy {
  var view;
  var scene;
  
  Hierarchy(Element this.view, Scene this.scene);

  register() {
    scene.onAddGameObject.listen(this.onAddGameObject);
  }

  onAddGameObject(e) {
    print('Added game object');
    view.children.clear();
    this.fillList();
  }

  fillList() {
    for(var go in scene.gameObjects) {
      var a = new AnchorElement()
        ..href = "#"
        ..dataset['id'] = go.id.toString()
        ..text = go.name
        ..onClick.listen(this.onClick);
      
      var li = new LIElement()
        ..append(a);
      view.append(li);
    }
  }

  onClick(e) {
    var id = e.target.dataset['id'];
    for(var element in view.querySelectorAll('li.active')) {
      element.classes.remove('active');
    }
    
    scene.selectGameObject(id);
    e.target.parent.classes.add('active');
    e.preventDefault();
  }
}