part of fussengine.editor;

class Inspector {
  var view;
  var editor;
  
  Inspector(Element this.view, Editor this.editor);

  register() {
    editor.onSelectGameObject.listen((e) => renderInspector());
    editor.onLoadScene.listen((e) => renderInspector());
  }
  
  update() {
    if(editor.selected == null) return;
  }
  
  renderInspector() {
    view.nodes.clear();
    
    if(editor.selected == null) {
      return;
    }
    
    var go = editor.selected;
    for(var component in go.components.values) {
      var drawer = new ComponentDrawer(component);
      drawer.draw(view);
    }
  }
}