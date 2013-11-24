import 'dart:html';
import 'dart:async';

import 'package:fussengine/engine.dart';
import 'package:fussengine/editor.dart';

var scene;
var actions;
var hierarchy;
var inspector;
var renderer;
var dd;

void main() {
  scene = new Scene("My scene");
  
  actions = new Menu(scene);
  actions.register();
  
  hierarchy = new Hierarchy(querySelector('#hierarchy'), scene);
  hierarchy.register();
  
  inspector = new Inspector(querySelector('#inspector'), scene);
  inspector.register();

  renderer = new CanvasSceneRenderer(querySelector('#sceneView'), scene);

  dd = new DragGameObjectSystem(querySelector('#sceneView'), scene);

  querySelector('#scene-title').text = scene.name;

  // main loop
  var future = new Timer.periodic(const Duration(milliseconds: 30), mainLoop);
}

void mainLoop(timer) {
//  print('loop');
  dd.update();
  //inspector.update();
  scene.update();
  renderer.renderScene(scene);
}

/*void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
*/