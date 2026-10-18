package yishi.scene
{
   import com.pickgliss.GC;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.ui.LayerManager;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import yishi.datas.consant.ClientStateType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.CursorManagerII;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.community.LoadingSceneView;
   
   public class SceneManager extends EventDispatcher
   {
      
      private static var _instance:SceneManager;
      
      private var _sceneDict:Dictionary;
      
      private var _currentScene:BaseSceneView;
      
      private var _nextScene:BaseSceneView;
      
      private var _data:Object;
      
      public var currentType:String;
      
      private var _create:ISceneCreate;
      
      private var _sceneSwitchAnimation:ISceneSwitchAnimation;
      
      private var _lock:Boolean;
      
      private var _loadType:int;
      
      public var isEnterFullScene:Boolean = false;
      
      private var _dealyShowSmallLoadingTime:int;
      
      private var _startTime:Number = 0;
      
      private var _tempType:String;
      
      public function SceneManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : SceneManager
      {
         if(!_instance)
         {
            _instance = new SceneManager();
         }
         return _instance;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _lock = param1;
         this.dispatchEvent(new SceneEvent("SWITCH_SCENE_LOCK",_lock));
      }
      
      public function get lock() : Boolean
      {
         return _lock;
      }
      
      public function get currentScene() : BaseSceneView
      {
         return _currentScene;
      }
      
      public function backSceneCall() : void
      {
         var _loc1_:String = _currentScene.backSceneName;
         setScene(_loc1_);
      }
      
      public function setup() : void
      {
         lock = false;
         _create = new SceneCreate();
         _sceneDict = new Dictionary();
      }
      
      public function set lockScene(param1:Boolean) : void
      {
         var _loc2_:Sprite = LayerManager.Instance.getLayerByType(2);
         _loc2_.parent.mouseChildren = !param1;
         _loc2_ = LayerManager.Instance.getLayerByType(6);
         _loc2_.mouseChildren = !param1;
         if(param1)
         {
            CursorManagerII.instance.hide();
         }
         else
         {
            CursorManagerII.instance.show();
         }
      }
      
      public function get lockScene() : Boolean
      {
         var _loc1_:Sprite = LayerManager.Instance.getLayerByType(2);
         return _loc1_.parent.mouseChildren;
      }
      
      private function dealyShowSmallLoading(param1:String, param2:String) : void
      {
         clearInterval(_dealyShowSmallLoadingTime);
         _dealyShowSmallLoadingTime = 0;
         if(param1 == currentType && param2 != currentType)
         {
            LoadingSceneView.instance.show();
         }
      }
      
      public function setScene(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false, param5:int = 0) : void
      {
         if(_lock)
         {
            return;
         }
         LoaderManagerII.instance.removeCanClearList();
         LoadingSceneView.instance.switchSceneFlag = true;
         if(param2 && param2.isDealyShowSmallLoading)
         {
            param2.isShowLoading = false;
         }
         _startTime = getTimer();
         KeyBoardRegister.instance.keyEnable = false;
         _loadType = param5;
         if(_sceneSwitchAnimation)
         {
            _sceneSwitchAnimation.stop();
            _sceneSwitchAnimation = null;
         }
         _sceneSwitchAnimation = createSwitchAnimationByType(param1);
         _data = param2;
         sendClientCurrentState(param1);
         if(param1 == currentType)
         {
            if(param3)
            {
               forceSetScene(param1);
            }
            return;
         }
         lock = true;
         if(param1 == null)
         {
            throw new Error("setScene is null");
         }
         if(param2 && param2.isShowLoading || param2 && !param2.hasOwnProperty("isShowLoading") || !param2)
         {
            LoadingSceneView.instance.show();
         }
         if(param1 == "CASTLE_SCENE")
         {
            SocketSendManager.instance.enterCastle(true);
            PlayerManager.instance.currentPlayerModel.inCastle = true;
         }
         else if(param1 == "FARM")
         {
            SocketSendManager.instance.enterCastle(true);
         }
         else if(param1 == "SPACE_SCENE")
         {
            SocketSendManager.instance.enterCastle(false);
         }
         var _loc6_:BaseSceneView = getSceneByType(param1);
         if(_loc6_)
         {
            setSceneImp(_loc6_);
         }
         else
         {
            createSceneAsynsImp(param1,createSceneCallBack);
         }
      }
      
      private function createSwitchAnimationByType(param1:String) : ISceneSwitchAnimation
      {
         var _loc2_:ISceneSwitchAnimation = null;
         if(param1 == "BATTLE_SCENE")
         {
            _loc2_ = new EnterBattleSceneSwitchAnimation(sceneAninmationBack);
         }
         else
         {
            _loc2_ = new SceneSwitchAninmation(sceneAninmationBack);
         }
         return _loc2_;
      }
      
      private function forceSetScene(param1:String) : void
      {
         _tempType = param1;
         lock = true;
         if(_data && _data.isShowLoading)
         {
            LoadingSceneView.instance.show();
         }
         var _loc2_:BaseSceneView = getSceneByType("EMPTY_SCENE");
         if(_loc2_)
         {
            emptyScene(_loc2_);
         }
         else
         {
            createSceneAsynsImp("EMPTY_SCENE",emptyScene);
         }
      }
      
      private function emptyScene(param1:BaseSceneView) : void
      {
         _nextScene = param1;
         _nextScene.enter(_currentScene,_data);
         _currentScene.leaving();
         if(_currentScene.parent)
         {
            _currentScene.parent.removeChild(_currentScene);
         }
         _currentScene = _nextScene;
         _sceneDict[_currentScene.SceneName] = _currentScene;
         currentType = _currentScene.SceneName;
         LayerManager.Instance.addToLayer(_currentScene,6);
         lock = false;
         _nextScene = null;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SWITCH_SCENE",_currentScene.SceneName));
         _currentScene.enterOver();
         setScene(_tempType,_data,false,false,_loadType);
      }
      
      private function createSceneCallBack(param1:BaseSceneView) : void
      {
         if(param1)
         {
            setSceneImp(param1);
         }
         else
         {
            lock = false;
         }
      }
      
      private function setSceneImp(param1:BaseSceneView) : void
      {
         if(param1 && param1 != _currentScene)
         {
            _nextScene = param1;
            if(!_nextScene.prepared)
            {
               _nextScene.prepare();
            }
            if(_data && _data.isDealyShowSmallLoading)
            {
               _dealyShowSmallLoadingTime = setInterval(dealyShowSmallLoading,2000,new String(currentType),_nextScene.SceneName);
            }
            _nextScene.preLoadingStart(_data);
         }
         else
         {
            lock = false;
         }
      }
      
      public function preLoadingBack() : void
      {
         LoadingSceneView.instance.hide();
         LoadingSceneView.instance.switchSceneFlag = false;
         if(!_currentScene)
         {
            addNextSceneImp();
            return;
         }
         _sceneSwitchAnimation.nextScene = _nextScene;
         _sceneSwitchAnimation.curScene = _currentScene;
         _sceneSwitchAnimation.start();
      }
      
      private function addNextSceneImp() : void
      {
         _nextScene.enter(_currentScene,_data);
         _currentScene = _nextScene;
         _sceneDict[_currentScene.SceneName] = _currentScene;
         currentType = _currentScene.SceneName;
         LayerManager.Instance.addToLayer(_currentScene,6);
         lock = false;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SWITCH_SCENE",_currentScene.SceneName));
         _nextScene = null;
         _currentScene.enterOver();
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      public function sceneAninmationBack() : void
      {
         _currentScene.leaving();
         if(_currentScene.parent)
         {
            _currentScene.parent.removeChild(_currentScene);
         }
         _nextScene.enter(_currentScene,_data);
         _currentScene = _nextScene;
         _sceneDict[_currentScene.SceneName] = _currentScene;
         currentType = _currentScene.SceneName;
         LayerManager.Instance.addToLayer(_currentScene,6);
         lock = false;
         _nextScene = null;
         KeyBoardRegister.instance.keyEnable = true;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SWITCH_SCENE",_currentScene.SceneName));
         _currentScene.enterOver();
         LoaderSavingManager.saveFilesToLocal();
         NotificationManager.instance.dispatchEvent(new SceneEvent("SCENE_SWITCH_CALL",null));
         GC.doClearance();
      }
      
      private function sendClientCurrentState(param1:String) : void
      {
         var _loc2_:int = ClientStateType.getClientState(param1);
         if(_loc2_ >= 0)
         {
            SocketSendManager.instance.sendCurrentClientState(_loc2_);
         }
      }
      
      private function createSceneAsynsImp(param1:String, param2:Function) : void
      {
         _create.createAsync(param1,param2);
      }
      
      private function getSceneByType(param1:String, param2:Boolean = false) : BaseSceneView
      {
         var _loc3_:BaseSceneView = _sceneDict[param1] as BaseSceneView;
         if(_loc3_ && param2)
         {
            _loc3_ = _create.create(param1);
         }
         return _loc3_;
      }
      
      public function removeSceneType() : void
      {
         delete _sceneDict[currentType];
      }
   }
}

