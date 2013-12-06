part of fussengine.editor;

class Inspector {
  var view;
  var editor;
  
  Inspector(Element this.view, Editor this.editor);

  update() {
    if(editor.selected == null) return;
    view.nodes.clear();
    this.renderInspector();
  }
  
  register() {
    editor.onSelectGameObject.listen(onSelectGameObject);
  }
  
  onSelectGameObject(e) {
    view.nodes.clear();
    renderInspector();
  }

  renderInspector() {
    var go = editor.selected;
    for(var component in go.components.values) {
      renderComponent(component);
    }
  }

  // TODO implement using metadata api?
  renderComponent(Component component) {
    _renderTitle(component);
    
    var instance = reflect(component);
    for(var declaration in instance.type.declarations.values) {
      if(declaration is VariableMirror) {
        _renderVariable(component.name, MirrorSystem.getName(declaration.simpleName), instance.getField(declaration.simpleName).reflectee);
      }
    }
  }

  _renderTitle(Component component) {
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..classes.add('bold')
      ..text = component.name;
    view.append(li);
  }

  _renderVariable(componentName, name, value) {
    if(name == "name") return;
    
    var badge = new SpanElement()
      ..classes.add('badge pointer')
      ..text = value.toString()
      ..dataset["component"] = componentName
      ..dataset["field"] = name.toString()
      ..onClick.listen(onClickBadge);
    
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..text = name.toString()
      ..append(badge);
    view.append(li);
  }
  
  onClickBadge(Event e) {
    Element badge = e.target;
    var drawer = _createDrawer(badge.dataset["component"], badge.dataset["field"]);
    badge.parent.append(drawer);
  }
  
  InstanceMirror _fieldByName(String componentName, String fieldName) {
    var fieldSym = new Symbol(fieldName);
    Component component = editor.selected.components[componentName];
    var field = reflect(component).getField(fieldSym);
    return field;
  }
  
  _createDrawer(String componentName, String fieldName) {
    var field = _fieldByName(componentName, fieldName);
    var value = field.reflectee.toString();
    
    var form = new FormElement()
      ..onSubmit.listen(_saveField);
    
    var meta = new Element.html('<div><input type="hidden" name="component" value="${componentName}"/><input type="hidden" name="field" value="${fieldName}"/></div>');
    var drawer = new Element.html('<div class="form-group"><input type="text" name="value" value="${value}" class="form-control"/></div>');
    var button = new Element.html('<div class="form-group"><input type="submit" value="Save" class="btn btn-default"/></div>');
    
    form.append(meta);
    form.append(drawer);
    form.append(button);
    return form;
  }
  
  _saveField(Event e) {
    FormElement form = e.target;
    
    var componentElement = form.querySelector('input[name="component"]') as HiddenInputElement;
    var fieldElement = form.querySelector('input[name="field"]') as HiddenInputElement;
    var field = _fieldByName(componentElement.value, fieldElement.value);
    var input = form.querySelector('input[name="value"]') as TextInputElement;
    
    _setField(componentElement.value, fieldElement.value, input.value);
    
    update();
    e.preventDefault();
  }
  
  _setField(String componentName, String fieldName, String value) {
    var fieldSym = new Symbol(fieldName);
    Component component = editor.selected.components[componentName];
    var mirror = reflect(component);
    var field = mirror.getField(fieldSym);
    
    switch(field.type.reflectedType.toString()) {
      case 'String':
        mirror.setField(fieldSym, value.toString());
        break;
      case 'int':
        mirror.setField(fieldSym, int.parse(value));
        break;
      default:
        throw new Exception('Field type not supported: ${fieldName}, ${field.type.reflectedType}');
    }
  }
}