part of fussengine.editor;

class ComponentDrawer {
  var _component;
  var _reflectedComponent;
  var _fieldDrawers = new List<FieldDrawer>();
  
  ComponentDrawer(Component this._component) {
    _reflectedComponent = reflect(_component);
  }
  
  draw(Element parent) {
    renderComponent(parent);
  }
  
  update() {
    for(var drawer in _fieldDrawers) {
      drawer.update();
    }
  }
  
// TODO implement using metadata api?
  renderComponent(Element parent) {
    _renderTitle(parent);
    
    for(var declaration in _reflectedComponent.type.declarations.values) {
      if(declaration is VariableMirror) {
        var drawer = new FieldDrawer(_reflectedComponent, declaration);
        _fieldDrawers.add(drawer);
        drawer.draw(parent);
      }
    }
  }

  _renderTitle(Element parent) {
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..classes.add('bold')
      ..text = _component.name;
    parent.append(li);
  }
}