package sandbox.daylight
{
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.controler.DayLightController;
   import sandbox.net.DayLightOuterManager;
   import yishi.manager.FrameControllerManager;
   
   public class DayLightSceneView extends Sprite implements Disposeable
   {
      
      private var _sprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _view:DayLightView;
      
      private var _controller:DayLightController = FrameControllerManager.instance.dayLightControler;
      
      private var _model:DayLightModel = _controller.model;
      
      public function DayLightSceneView()
      {
         super();
         initView();
         addEvent();
         __resizeHanlder(null);
         DayLightOuterManager.requestData();
         DayLightOuterManager.clearCD();
      }
      
      private function initView() : void
      {
         ComponentGroupManager.Instance.disposeAllOpenFrame();
         _sprite = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("asset.daylight.DayLightFrameBg");
         _view = new DayLightView();
         addChild(_sprite);
         addChild(_bg);
         addChild(_view);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_sprite);
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         setShape(_loc2_,_loc3_);
         x = 0;
         y = 0;
         _bg.x = (_loc2_ - _bg.width) * 0.5;
         _bg.y = -(900 - _loc3_) * 0.5;
         _view.x = _bg.x + 163;
         _view.y = _bg.y + 90;
      }
      
      private function setShape(param1:int, param2:int) : void
      {
         _sprite.graphics.clear();
         _sprite.graphics.beginFill(0,1);
         _sprite.graphics.drawRect(0,0,param1,param1);
         _sprite.graphics.endFill();
      }
      
      public function onStageScale() : void
      {
         this.scaleX = 1;
         this.scaleY = 1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

