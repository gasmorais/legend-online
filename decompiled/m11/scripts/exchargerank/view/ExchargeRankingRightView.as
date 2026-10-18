package exchargerank.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mvc.controler.ExchargeRankController;
   import mvc.module.exchargerank.ExchargeData;
   
   public class ExchargeRankingRightView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _data:ExchargeData;
      
      private var _exchargeBagView:ExchargeRankBagView;
      
      private var _timer:Timer;
      
      private var _controler:ExchargeRankController;
      
      public function ExchargeRankingRightView()
      {
         super();
         initView();
         initEvent();
         _controler = new ExchargeRankController();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      public function set data(param1:ExchargeData) : void
      {
         _data = param1;
         if(_data.type == 196)
         {
            _exchargeBagView.visible = false;
            _controler.loadXML();
         }
         else if(_data.type == 67)
         {
            _exchargeBagView.visible = true;
            _exchargeBagView.data = param1;
         }
      }
      
      private function initView() : void
      {
         _exchargeBagView = new ExchargeRankBagView();
         addChild(_exchargeBagView);
         _exchargeBagView.visible = false;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         _timer = null;
         _data = null;
         if(_exchargeBagView)
         {
            _exchargeBagView.dispose();
         }
         _exchargeBagView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

