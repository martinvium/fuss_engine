library fussengine.editor;
import "dart:html";

class InspectorView {
  var view;
  var scene;
  
  InspectorView(view, scene) {
    this.view = view;
    this.scene = scene;
  }

  update() {
    if(scene.selected == null) return;
    view.nodes.clear();
    this.renderInspector(scene.selected);
  }
  
  register() {
    scene.onSelectGameObject.listen(this.onSelectedGameObject);
  }
  
  onSelectedGameObject(e) {
    view.empty();
    renderInspector(scene.selected);
  }

  renderInspector(go) {
    for(var component in go.components.values) {
      this.renderComponent(component);
    }
  }

  // TODO implement using metadata api?
  renderComponent(component) {
    this.renderTitle(component);
//    for(var z in component) {
//      if(component.hasOwnProperty(z) && z != "name" && typeof component[z] != "function") {
//        this.renderProperty(z, component[z]);
//      }
//    }
  }

  renderTitle(component) {
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..classes.add('bold')
      ..text = component.name;
    view.append(li);
  }

  renderProperty(name, value) {
    var badge = new SpanElement()
      ..classes.add('badge')
      ..text = value;
    
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..append(badge)
      ..text = name;
    view.append(li);
  }
}