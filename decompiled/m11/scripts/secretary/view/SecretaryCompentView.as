package secretary.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import flash.display.Sprite;
   import mvc.module.secretary.SecretaryItemData;
   import secretary.item.SecretaryAltarItem;
   import secretary.item.SecretaryCompentItem;
   
   public class SecretaryCompentView extends Sprite
   {
      
      private var item:SecretaryCompentItem;
      
      public var _otherSpane:ScrollPanel;
      
      public var _otherVbox:VBox;
      
      private var _type:int;
      
      public function SecretaryCompentView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _otherSpane = ComponentFactory.Instance.creatComponentByStylename("secretary.view.SecretaryCompentView.otherSpane");
         _otherVbox = ComponentFactory.Instance.creatCustomObject("ui.kingback.otherVbox");
         addChild(_otherSpane);
         _otherSpane.setView(_otherVbox);
      }
      
      public function refrshView(param1:Array) : void
      {
         var _loc6_:SecretaryItemData = null;
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         var _loc5_:Array = param1;
         var _loc3_:int = int(_loc5_ ? _loc5_.length : 0);
         _otherVbox.removeAllChild();
         _otherVbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc5_[_loc4_];
            if(_loc6_.type == 9)
            {
               _loc2_ = new SecretaryAltarItem();
               _loc2_.data = _loc6_;
            }
            else
            {
               _loc2_ = new SecretaryCompentItem();
               _loc2_.data = _loc6_;
            }
            _otherVbox.addChild(_loc2_);
            _loc4_++;
         }
         _otherVbox.commitChanges();
         _otherSpane.invalidateViewport();
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
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

