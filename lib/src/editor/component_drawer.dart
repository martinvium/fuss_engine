part of fussengine.editor;

class ComponentDrawer {
  var _component;
  var _reflected;
  
  ComponentDrawer(Component this._component) {
    _reflected = reflect(_component);
  }
  
  draw(Element parent) {
    renderComponent(parent);
  }
  
// TODO implement using metadata api?
  renderComponent(Element parent) {
    _renderTitle(parent);
    
    for(var declaration in _reflected.type.declarations.values) {
      if(declaration is VariableMirror) {
        var drawer = new FieldDrawer(_component);
        var fieldName = MirrorSystem.getName(declaration.simpleName);
        var fieldValue = _reflected.getField(declaration.simpleName).reflectee;
        drawer.draw(parent, fieldName, fieldValue);
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