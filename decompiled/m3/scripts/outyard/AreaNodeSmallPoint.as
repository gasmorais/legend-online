package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.outyard.AreaPoint;
   
   public class AreaNodeSmallPoint extends Component
   {
      
      private var _info:AreaPoint;
      
      private var _point:Bitmap;
      
      public function AreaNodeSmallPoint()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _point = ComponentFactory.Instance.creatBitmap("asset.outyard.areaSmallPoint");
         addChild(_point);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set info(param1:AreaPoint) : void
      {
         if(!_info)
         {
         }
         _info = param1;
         if(!_info)
         {
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_point);
         _point = null;
         _info = null;
         super.dispose();
      }
   }
}

