part of fussengine.editor;

class Inspector {
  var view;
  var editor;
  var _componentDrawers = new List<ComponentDrawer>();
  
  Inspector(Element this.view, Editor this.editor);

  register() {
    editor.onSelectGameObject.listen((e) => renderInspector());
    editor.onLoadScene.listen((e) => renderInspector());
  }
  
  update() {
    if(editor.selected == null) return;
    
    for(var drawer in _componentDrawers) {
      drawer.update();
    }
  }
  
  renderInspector() {
    view.nodes.clear();
    
    if(editor.selected == null) {
      return;
    }
    
    var go = editor.selected;
    _renderComponents(go);
  }
  
  _renderComponents(GameObject go) {
    for(var component in go.components.values) {
      var drawer = new ComponentDrawer(component);
      _componentDrawers.add(drawer);
      drawer.draw(view);
    }
  }
}