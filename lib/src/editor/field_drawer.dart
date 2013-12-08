part of fussengine.editor;

class FieldDrawer {
  InstanceMirror _component;
  VariableMirror _fieldDeclaration;
//  InstanceMirror _field;
  var oldValue;
  Element _badge;
  
  FieldDrawer(InstanceMirror this._component, VariableMirror this._fieldDeclaration);
  
  String get name {
    return MirrorSystem.getName(_fieldDeclaration.simpleName);
  }
  
  String get value {
    return _field.reflectee.toString();
  }
  
  Symbol get symbol {
    return new Symbol(name);
  }
  
  String get type {
    return _field.type.reflectedType.toString();
  }
  
  InstanceMirror get _field {
    return _component.getField(_fieldDeclaration.simpleName);
  }
  
  update() {
    if(isHidden()) return;
    if(value == oldValue) return;
    _setBadgeValue();
  }
  
  draw(Element parent) {
    if(isHidden()) return;
    
    _badge = new SpanElement()
      ..classes.add('badge pointer')
      ..onClick.listen(onClickBadge);
    
    var label = new LabelElement()
      ..style.fontWeight = "normal"
      ..text = name;
    
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..append(label)
      ..append(_badge);
    parent.append(li);
    
    _setBadgeValue();
  }
  
  _setBadgeValue() {
    _badge.text = value;
    oldValue = value;
  }
  
  isHidden() {
    return name == "name";
  }
  
  onClickBadge(Event e) {
    Element badge = e.target;
    var drawer = _createForm();
    badge.parent.append(drawer);
  }
  
  _createForm() {
    var form = new FormElement()
      ..onSubmit.listen(_saveField);
    
    var drawer = new Element.html('<div class="form-group"><input type="text" name="value" value="${value}" class="form-control"/></div>');
    var button = new Element.html('<div class="form-group"><input type="submit" value="Save" class="btn btn-default"/></div>');
    
    form.append(drawer);
    form.append(button);
    return form;
  }
  
  _saveField(Event e) {
    FormElement form = e.target;
    var input = form.querySelector('input[name="value"]') as TextInputElement;
    _setField(input.value);
    e.preventDefault();
  }
  
  _setField(String value) {
    switch(type) {
      case 'String':
        _component.setField(symbol, value.toString());
        break;
      case 'int':
        _component.setField(symbol, int.parse(value));
        break;
      default:
        throw new Exception('Field type not supported: ${name}, ${type}');
    }
  }
}