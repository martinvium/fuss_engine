part of fussengine.editor;

class Hierarchy {
  var view;
  var editor;
  
  Hierarchy(Element this.view, Editor this.editor);

  register() {
    editor.onAddGameObject.listen(fillList);
    editor.onLoadScene.listen(fillList);
  }
  
  fillList(e) {
    print("filling hierarchy list");
    view.children.clear();
    for(var go in editor.gameObjects) {
      var a = new AnchorElement()
        ..href = "#"
        ..dataset['id'] = go.id.toString()
        ..text = go.name
        ..onClick.listen(this.onClick);
      
      var li = new LIElement()
        ..append(a);
      
      if(editor.selected == go) {
        li.classes.add('active');
      }
      
      view.append(li);
    }
  }

  onClick(e) {
    var id = e.target.dataset['id'];
    for(var element in view.querySelectorAll('li.active')) {
      element.classes.remove('active');
    }
    
    editor.selectGameObject(id);
    e.target.parent.classes.add('active');
    e.preventDefault();
  }
}