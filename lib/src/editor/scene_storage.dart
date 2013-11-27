part of fussengine.editor;

class SceneStorage {
  static const String DB_NAME = 'fussDB';
  static const String SCENES_STORE = 'fussEditor';
  static const String SCENES_INDEX = 'scenes';
  
  Future querySceneNames() {
    if(!IdbFactory.supported) {
      window.alert('Browser storage is not supported!');
      return null;
    }
    
    Future future = _open().then((Database db) {
      var trans = db.transaction(SCENES_STORE, 'readonly');
      var store = trans.objectStore(SCENES_STORE);
      return store.openCursor(autoAdvance: true).asBroadcastStream();
    });
    
    return future;
  }
  
  loadScene(String sceneName) {
    if(!IdbFactory.supported) {
      window.alert('Browser storage is not supported!');
      return null;
    }
    
    var future = _open().then((Database db) {
      var trans = db.transaction(SCENES_STORE, 'readonly');
      var store = trans.objectStore(SCENES_STORE);
      return store.getObject(sceneName).then((data) {
        return Scene.unserialize(data);
      });
    });
    
    return future;
  }
  
  saveScene(Scene scene) {
    if(!IdbFactory.supported) {
      window.alert('Browser storage is not supported!');
      return;
    }
    
    _open().then((Database db) {
      var serialized = scene.serialize();
      var trans = db.transaction(SCENES_STORE, 'readwrite');
      var store = trans.objectStore(SCENES_STORE);
      store.put(serialized, scene.name).then((key) => print('Saved ${scene.name}'));
    });
  }
  
  Future _open() {
    return window.indexedDB.open(DB_NAME, version: 1, onUpgradeNeeded: _initializeDatabase);
  }
  
  _initializeDatabase(VersionChangeEvent e) {
    Database db = (e.target as Request).result;
    var objectStore = db.createObjectStore(SCENES_STORE, autoIncrement: true);
    var index = objectStore.createIndex(SCENES_INDEX, 'sceneName', unique: true);
  }
}