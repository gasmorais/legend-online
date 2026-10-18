package castle.view.layer
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IStopEffect;
   import yishi.manager.NotificationManager;
   
   public class CastleAnimalLayer extends Sprite implements Disposeable, IStopEffect
   {
      
      private var _animal:MovieClip;
      
      public function CastleAnimalLayer()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _animal = ComponentFactory.Instance.creatCustomObject("castle.BgAnimal");
         _animal.mouseEnabled = _animal.mouseChildren = false;
         addChild(_animal);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("STOP_EFFECT",__notificationHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("STOP_EFFECT",__notificationHandler);
      }
      
      private function __notificationHandler(param1:NotificationEvent) : void
      {
         if(param1.data)
         {
            startEffet();
         }
         else
         {
            stopEffect();
         }
      }
      
      public function stopEffect() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < _animal.numChildren)
         {
            _loc1_ = _animal.getChildAt(_loc2_);
            if(_loc1_ is MovieClip)
            {
               _loc1_["stop"]();
            }
            _loc2_++;
         }
      }
      
      public function startEffet() : void
      {
         _animal.gotoAndPlay(1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_animal);
         _animal = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

