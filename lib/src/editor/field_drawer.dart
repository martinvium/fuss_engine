part of fussengine.editor;

class FieldDrawer {
  Component _component;
  
  FieldDrawer(Component this._component);
  
  draw(Element parent, name, value) {
    if(name == "name") return;
    
    var badge = new SpanElement()
      ..classes.add('badge pointer')
      ..text = value.toString()
      ..dataset["field"] = name.toString()
      ..onClick.listen(onClickBadge);
    
    var li = new LIElement()
      ..classes.add('list-group-item')
      ..text = name.toString()
      ..append(badge);
    parent.append(li);
  }
  
  onClickBadge(Event e) {
    Element badge = e.target;
    var drawer = _createDrawer(badge.dataset["field"]);
    badge.parent.append(drawer);
  }
  
  _createDrawer(String fieldName) {
    var field = _fieldByName(fieldName);
    var value = field.reflectee.toString();
    
    var form = new FormElement()
      ..onSubmit.listen(_saveField);
    
    var meta = new Element.html('<div><input type="hidden" name="field" value="${fieldName}"/></div>');
    var drawer = new Element.html('<div class="form-group"><input type="text" name="value" value="${value}" class="form-control"/></div>');
    var button = new Element.html('<div class="form-group"><input type="submit" value="Save" class="btn btn-default"/></div>');
    
    form.append(meta);
    form.append(drawer);
    form.append(button);
    return form;
  }
  
  _saveField(Event e) {
    FormElement form = e.target;
    
    var fieldElement = form.querySelector('input[name="field"]') as HiddenInputElement;
    var field = _fieldByName(fieldElement.value);
    var input = form.querySelector('input[name="value"]') as TextInputElement;
    
    _setField(fieldElement.value, input.value);
    
    e.preventDefault();
  }
  
  InstanceMirror _fieldByName(String fieldName) {
    var fieldSym = new Symbol(fieldName);
    var field = reflect(_component).getField(fieldSym);
    return field;
  }
  
  _setField(String fieldName, String value) {
    var fieldSym = new Symbol(fieldName);
    var mirror = reflect(_component);
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