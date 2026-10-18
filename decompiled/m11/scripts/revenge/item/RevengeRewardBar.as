package revenge.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RevengeRewardBar extends Sprite
   {
      
      public var _bar1:Bitmap;
      
      public var _bar2:Bitmap;
      
      public var _rewardHbox:VBox;
      
      public function RevengeRewardBar()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bar1 = ComponentFactory.Instance.creatBitmap("asset.revengeroad.bar1");
         _bar2 = ComponentFactory.Instance.creatBitmap("asset.revengeroad.bar2");
         _rewardHbox = ComponentFactory.Instance.creatCustomObject("ui.revengeroad.rewardVbox");
         addChild(_bar1);
         addChild(_bar2);
         addChild(_rewardHbox);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bar1);
         _bar1 = null;
         ObjectUtils.disposeObject(_bar2);
         _bar2 = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

