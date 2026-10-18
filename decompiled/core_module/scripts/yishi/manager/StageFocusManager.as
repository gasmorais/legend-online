package yishi.manager
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.ShowTipManager;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import yishi.scene.SceneManager;
   
   public class StageFocusManager
   {
      
      private static var instance:StageFocusManager;
      
      private var _count:int;
      
      private var _stage:Stage;
      
      private var _view:Sprite;
      
      private var _icon:Sprite;
      
      private var _isActivate:Boolean = true;
      
      private var _currentActiveObject:InteractiveObject;
      
      public function StageFocusManager()
      {
         super();
      }
      
      public static function getInstance() : StageFocusManager
      {
         if(instance == null)
         {
            instance = new StageFocusManager();
         }
         return instance;
      }
      
      public function setup(param1:Stage) : void
      {
         _stage = param1;
         _view = new Sprite();
         addEvent();
         __resizeHandler(null);
      }
      
      public function removeEvent() : void
      {
         _stage.removeEventListener("deactivate",__deactivateHandler);
         _stage.removeEventListener("activate",__activateHandler);
         _stage.removeEventListener("resize",__resizeHandler);
      }
      
      public function addEvent() : void
      {
         _stage.addEventListener("deactivate",__deactivateHandler);
         _stage.addEventListener("activate",__activateHandler);
         _stage.addEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _view.graphics.clear();
         _view.graphics.beginFill(0,0.6);
         _view.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _view.graphics.endFill();
         _view.buttonMode = true;
         if(_icon)
         {
            _icon.x = StageReferance.stageWidth / 2;
            _icon.y = StageReferance.stageHeight / 2;
         }
      }
      
      private function __deactivateHandler(param1:Event) : void
      {
         _isActivate = false;
         ShowTipManager.Instance.removeCurrentTip();
         if(SceneManager.instance.currentType != "BATTLE_SCENE")
         {
            return;
         }
         if(!_icon)
         {
            loadRes();
         }
         _stage.addChild(_view);
         fadein();
      }
      
      private function loadRes() : void
      {
         var _loc1_:String = ComponentSetting.getUISourcePath("stagefocus");
         LoaderManagerII.instance.load(_loc1_,3,0,completeHandler);
      }
      
      private function completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("core.StageFocus");
         _icon.x = StageReferance.stageWidth / 2;
         _icon.y = StageReferance.stageHeight / 2;
         _view.addChild(_icon);
      }
      
      private function __activateHandler(param1:Event) : void
      {
         _isActivate = true;
         stopFade();
         if(_view.stage && _currentActiveObject)
         {
            _view.stage.focus = _currentActiveObject;
         }
         if(_view.parent)
         {
            _view.parent.removeChild(_view);
         }
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         _count = _count + 1;
         if(_count >= 2)
         {
            _view.removeEventListener("enterFrame",__enterFrameHandler);
            if(_view.parent)
            {
               _view.parent.removeChild(_view);
            }
            _count = 0;
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      public function get isActivate() : Boolean
      {
         return _isActivate;
      }
      
      public function setActiveFocus(param1:InteractiveObject) : void
      {
         _currentActiveObject = param1;
      }
      
      private function fadein() : void
      {
         _view.alpha = 0;
         _view.addEventListener("enterFrame",__onFadein);
      }
      
      private function stopFade() : void
      {
         _view.alpha = 1;
         _view.removeEventListener("enterFrame",__onFadein);
      }
      
      private function __onFadein(param1:Event) : void
      {
         if(_view.alpha < 0.95)
         {
            _view.alpha += 0.05;
         }
         else
         {
            _view.alpha = 1;
            _view.removeEventListener("enterFrame",__onFadein);
         }
      }
   }
}

