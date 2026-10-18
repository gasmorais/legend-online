package com.speedEngine.game
{
   import com.speedEngine.game.base.AppStage;
   import com.speedEngine.game.base.DriverType;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.error.ErrorManager;
   import com.speedEngine.game.log.LogManager;
   import com.speedEngine.game.manager.BaseManager;
   import com.speedEngine.game.manager.EnterFrameManager;
   import com.speedEngine.game.manager.EventManager;
   import com.speedEngine.game.manager.LayerManager;
   import com.speedEngine.game.manager.TimerManager;
   import com.speedEngine.game.manager.TweenManager;
   import com.speedEngine.game.tween.Tween;
   import com.speedEngine.game.view.BaseSprite;
   import com.speedEngine.game.view.InfoSprite;
   import com.speedEngine.speedBones.display.Stage;
   import com.speedEngine.speedBones.manager.RenderManager;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   use namespace basegame_internal;
   
   public class Director
   {
      
      private static var _instance:Director;
      
      private var _managerList:Vector.<BaseManager>;
      
      private var _isPause:Boolean = false;
      
      private var _stage2d:flash.display.Stage;
      
      private var _stage3d:com.speedEngine.speedBones.display.Stage;
      
      private var _enterFrameInstance:EnterFrameManager;
      
      private var _timerInstance:TimerManager;
      
      private var _tweenInstance:TweenManager;
      
      private var _eventInstance:EventManager;
      
      private var _errorInstance:ErrorManager;
      
      private var _logInstance:LogManager;
      
      private var _layerInstance:LayerManager;
      
      private var _lastFrameRate:int;
      
      private var _mask:BaseSprite = new BaseSprite();
      
      private var _rightMenu:Array = [];
      
      private var _contextMenu:ContextMenu;
      
      private var _infoSprite:InfoSprite = null;
      
      private var _isShowInfoSprite:Boolean = true;
      
      private var _frameInitComplete:Function = null;
      
      private var _renderTextureMax:int;
      
      public function Director(param1:SingleHelper)
      {
         super();
         if(param1 == null)
         {
            ErrorManager.instance.throwSingletonError();
         }
      }
      
      public static function get instance() : Director
      {
         if(_instance == null)
         {
            _instance = new Director(new SingleHelper());
         }
         return _instance;
      }
      
      public function init(param1:flash.display.Stage, param2:int = 1024, param3:Boolean = true) : void
      {
         _renderTextureMax = param2;
         AppStage.init(param1,createContext3DCallback,param3);
         _stage2d = AppStage.stage2d;
         _stage3d = AppStage.stage3d;
         _enterFrameInstance = EnterFrameManager.instance;
         _timerInstance = TimerManager.instance;
         _tweenInstance = TweenManager.instance;
         _eventInstance = EventManager.instance;
         _errorInstance = ErrorManager.instance;
         _logInstance = LogManager.instance;
         _layerInstance = LayerManager.instance;
         _enterFrameInstance.init();
         _timerInstance.init();
         _tweenInstance.init();
         _eventInstance.init();
         _errorInstance.init();
         _managerList = new Vector.<BaseManager>();
         _managerList.push(_enterFrameInstance,_timerInstance);
         _mask.graphics.beginFill(16711680,0);
         _mask.graphics.drawRect(0,0,param1.stageWidth,param1.stageHeight);
         _mask.graphics.endFill();
         if(AppStage.stage3d == null && AppStage.stage2d == null)
         {
            _errorInstance.throwErrorMsg("stage为null,Director.init之前必须初始{invalid_utf8=229}{invalid_utf8=140}? AppStage");
         }
         _contextMenu = new ContextMenu();
         _contextMenu.hideBuiltInItems();
         (param1.getChildAt(0) as Sprite).contextMenu = _contextMenu;
         AppStage.stage2d.addEventListener("enterFrame",__onUpdate);
      }
      
      public function isOpenDriver() : Boolean
      {
         if(AppStage.context3D)
         {
            return AppStage.context3D.driverInfo.indexOf("userDisabled") == -1;
         }
         throw new Error("Context3D未初始化，请调用Director.instance.init()");
      }
      
      public function get driverType() : String
      {
         if(AppStage.context3D)
         {
            return DriverType.getDriverType(AppStage.context3D.driverInfo);
         }
         throw new Error("Context3D未初始化，请调用Director.instance.init()");
      }
      
      public function get speedEngineVersion() : String
      {
         return "1.1.10";
      }
      
      public function get driverInfo() : String
      {
         if(AppStage.context3D)
         {
            return AppStage.context3D.driverInfo;
         }
         return null;
      }
      
      private function createContext3DCallback() : void
      {
         if(_isShowInfoSprite)
         {
            showInfoSprite();
         }
         RenderManager.instance.initContext3d(AppStage.context3D,_stage2d,_renderTextureMax);
         if(_frameInitComplete != null)
         {
            _frameInitComplete.call(null);
         }
      }
      
      public function set frameInitComplete(param1:Function) : void
      {
         _frameInitComplete = param1;
      }
      
      public function get frameInitComplete() : Function
      {
         return _frameInitComplete;
      }
      
      public function setPositionInfoSprite(param1:Number, param2:Number) : void
      {
         if(_infoSprite)
         {
            _infoSprite.x = param1;
            _infoSprite.y = param2;
         }
      }
      
      public function hideInfoSprite() : void
      {
         if(_infoSprite)
         {
            _infoSprite.dispose();
            _stage2d.removeChild(_infoSprite);
         }
         _infoSprite = null;
      }
      
      public function showInfoSprite() : void
      {
         _infoSprite = new InfoSprite();
         _stage2d.addChild(_infoSprite);
      }
      
      public function showDebugLog(param1:String) : void
      {
         _logInstance.show(param1);
      }
      
      public function hideDebugLog(param1:String) : void
      {
         _logInstance.hide(param1);
      }
      
      public function cleanDebugLog() : void
      {
         _logInstance.clear();
      }
      
      private function __onUpdate(param1:Event) : void
      {
         if(_isPause)
         {
            return;
         }
         for each(var _loc2_:BaseManager in _managerList)
         {
            _loc2_.update();
         }
      }
      
      public function resume() : void
      {
         if(!_isPause)
         {
            return;
         }
         _isPause = false;
         AppStage.stage2d.frameRate = _lastFrameRate;
         _mask.parent.removeChild(_mask);
      }
      
      public function pause() : void
      {
         if(_isPause)
         {
            return;
         }
         _isPause = true;
         _lastFrameRate = AppStage.stage2d.frameRate;
         AppStage.stage2d.frameRate = 0;
         (AppStage.stage2d.root as DisplayObjectContainer).addChild(_mask);
      }
      
      public function get contextMenu() : ContextMenu
      {
         return _contextMenu;
      }
      
      public function pushRightMenu(param1:String, param2:Function) : void
      {
         _rightMenu.push({
            "title":param1,
            "callBack":param2
         });
         var _loc3_:ContextMenuItem = new ContextMenuItem(param1);
         _contextMenu.customItems.push(_loc3_);
         _loc3_.addEventListener("menuItemSelect",__onMenuSelect);
      }
      
      public function pushRightItem(param1:ContextMenuItem) : void
      {
         _contextMenu.customItems.push(param1);
         _rightMenu.push({"title":param1.label});
      }
      
      protected function __onMenuSelect(param1:ContextMenuEvent) : void
      {
         var _loc5_:ContextMenuItem = param1.target as ContextMenuItem;
         var _loc2_:String = _loc5_.caption;
         var _loc3_:int = getTitleIndex(_loc2_);
         var _loc4_:Function = _rightMenu[_loc3_]["callBack"];
         if(_loc4_ != null)
         {
            _loc4_();
         }
      }
      
      public function removeRightMenu(param1:String) : void
      {
         var _loc2_:int = getTitleIndex(param1);
         if(_loc2_ > -1)
         {
            _rightMenu.splice(_loc2_,1);
            _contextMenu.customItems.splice(_loc2_,1);
         }
      }
      
      private function getTitleIndex(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(_rightMenu.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_rightMenu[_loc3_]["title"] == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function initLayer3D(param1:Array) : void
      {
         _layerInstance.init3d(param1);
      }
      
      public function initLayer2D(param1:Array) : void
      {
         _layerInstance.init2d(param1);
      }
      
      public function addToLayer(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false, param5:Number = 0.5) : void
      {
         _layerInstance.addToLayer(param1,param2,param3,param4,param5);
      }
      
      public function getLayer(param1:String) : Object
      {
         return _layerInstance.getLayerByName(param1);
      }
      
      public function removeToLayer(param1:String, param2:Object) : void
      {
         _layerInstance.removeToLayer(param1,param2);
      }
      
      public function clearLayerChild(param1:String, param2:Object = null) : void
      {
         _layerInstance.clearLayerChild(param1,param2);
      }
      
      public function clearAllLayerChild() : void
      {
         _layerInstance.clearAllLayerChild();
      }
      
      public function addEnterFrameEvent(param1:Function) : void
      {
         _enterFrameInstance.addEnterFrameEvent(param1);
      }
      
      public function removeEnterFrameEvent(param1:Function) : void
      {
         _enterFrameInstance.removeEnterFrameEvent(param1);
      }
      
      public function removeAllEnterFrameEvents() : void
      {
         _enterFrameInstance.removeAllEnterFrameEvents();
      }
      
      public function addEvent(param1:Object, param2:String, param3:Function = null, param4:Boolean = false) : void
      {
         _eventInstance.addEvent(param1,param2,param3,param4);
      }
      
      public function addEventOnce(param1:Object, param2:String, param3:Function = null) : void
      {
         _eventInstance.addEventOnce(param1,param2,param3);
      }
      
      public function removeEvent(param1:Object, param2:String = null, param3:Function = null) : void
      {
         _eventInstance.removeEvent(param1,param2,param3);
      }
      
      public function dispatchEventWith(param1:Object, param2:String, param3:Object = null) : void
      {
         _eventInstance.dispatchEventWith(param1,param2,param3);
      }
      
      public function addTimer(param1:Number, param2:int = -1, param3:Function = null, param4:Function = null, param5:Boolean = false, param6:Object = null) : int
      {
         return _timerInstance.addTimer(param1,param2,param3,param4,param5,param6);
      }
      
      public function removeTimer(param1:int) : void
      {
         _timerInstance.removeTimer(param1);
      }
      
      public function startTimer(param1:int) : void
      {
         _timerInstance.startTimer(param1);
      }
      
      public function stopTimer(param1:int) : void
      {
         _timerInstance.stopTimer(param1);
      }
      
      public function resetTimer(param1:int) : void
      {
         _timerInstance.resetTimer(param1);
      }
      
      public function getTimerCurrCount(param1:int) : int
      {
         return _timerInstance.getTimerCurrCount(param1);
      }
      
      public function createTween(param1:Class, param2:Object, param3:Number, param4:Object, param5:Boolean = true) : Tween
      {
         return _tweenInstance.createTween(param1,param2,param3,param4,param5);
      }
      
      public function toTween(param1:Tween) : void
      {
         return _tweenInstance.to(param1);
      }
      
      public function fromTween(param1:Tween) : void
      {
         return _tweenInstance.from(param1);
      }
      
      public function killTween(param1:Tween) : void
      {
         _tweenInstance.kill(param1);
      }
      
      public function killAllTween(param1:Object) : void
      {
         _tweenInstance.killAll(param1);
      }
      
      public function trace(param1:int, param2:String, ... rest) : void
      {
         _logInstance.writeLog(param1,param2,rest);
      }
      
      public function traceMe(param1:int, ... rest) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = new Error().getStackTrace();
         try
         {
            _loc3_ = "module:" + _loc4_.split(/\tat /)[2].split("[")[0] + " line: " + _loc4_.split(/\tat /)[2].split(":")[4].split("]")[0];
            _logInstance.writeLog(param1,_loc3_,rest);
         }
         catch(e:Error)
         {
         }
      }
      
      public function throwError(param1:String) : void
      {
         _errorInstance.throwErrorMsg(param1);
      }
      
      public function get stage2d() : flash.display.Stage
      {
         return _stage2d;
      }
      
      public function get stage3d() : com.speedEngine.speedBones.display.Stage
      {
         return _stage3d;
      }
      
      public function get isDebug() : Boolean
      {
         return _logInstance.isDebug;
      }
      
      public function set isDebug(param1:Boolean) : void
      {
         _logInstance.isDebug = param1;
      }
      
      public function set printState(param1:Array) : void
      {
         _logInstance.printState = param1;
      }
      
      public function get printState() : Array
      {
         return _logInstance.printState;
      }
      
      public function get modelState() : Array
      {
         return _logInstance.modelState;
      }
      
      public function set modelState(param1:Array) : void
      {
         _logInstance.modelState = param1;
      }
      
      public function get isShowInfoSprite() : Boolean
      {
         return _isShowInfoSprite;
      }
      
      public function set isShowInfoSprite(param1:Boolean) : void
      {
         _isShowInfoSprite = param1;
      }
   }
}

class SingleHelper
{
   
   public function SingleHelper()
   {
      super();
   }
}
