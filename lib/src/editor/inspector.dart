part of fussengine.editor;

class Inspector {
  var view;
  var scene;
  
  Inspector(view, scene) {
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
    view.nodes.clear();
    renderInspector(scene.selected);
  }

  renderInspector(go) {
    for(var component in go.components.values) {
      this.renderComponent(component);
    }
  }

  // TODO implement using metadata api?
  renderComponent(Component component) {
    this.renderTitle(component);
    
    InstanceMirror instance = reflect(component);
    for(var declaration in instance.type.declarations.values) {
      if(declaration is VariableMirror) {
        this.renderVariable(MirrorSystem.getName(declaration.simpleName), instance.getField(declaration.simpleName).reflectee);
      }
    }
  }

  renderTitle(component) {
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..classes.add('bold')
      ..text = component.name;
    view.append(li);
  }

  renderVariable(name, value) {
    if(name == "name") return;
    
    var badge = new SpanElement()
      ..classes.add('badge')
      ..text = value.toString();
    
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..text = name.toString()
      ..append(badge);
    view.append(li);
  }
}