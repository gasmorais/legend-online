package battle.qte
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.utils.GraphicsUtils;
   
   public class QteTimeView extends Sprite implements Disposeable
   {
      
      private var _timeCircle:MovieClip;
      
      private var _mask:Sprite;
      
      public var currentAngle:int = 0;
      
      public function QteTimeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _timeCircle = ComponentFactory.Instance.creatCustomObject("qte.QTETime");
         _mask = new Sprite();
         _mask.rotation = -90;
         addChild(_timeCircle);
         addChild(_mask);
         _mask.scaleY = -1;
         _mask.x = 29;
         _mask.y = 29;
         _timeCircle["time_mask"].mask = _mask;
      }
      
      public function set time(param1:Number) : void
      {
         TweenLite.to(this,param1,{
            "currentAngle":360,
            "onUpdate":updateMask
         });
      }
      
      private function updateMask() : void
      {
         GraphicsUtils.changeSectorAngle(_mask,0,0,20,0,currentAngle);
      }
      
      private function uninit() : void
      {
         _timeCircle.stop();
         _timeCircle = null;
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

