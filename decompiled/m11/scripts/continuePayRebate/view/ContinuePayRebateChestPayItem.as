package continuePayRebate.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import yishi.utils.NumberViewUtils;
   
   public class ContinuePayRebateChestPayItem extends Sprite implements Disposeable
   {
      
      private var _back:Image;
      
      private var _daySp:Sprite;
      
      private var _dayNum:BitmapData;
      
      private var _dayCount:int;
      
      public function ContinuePayRebateChestPayItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chestPayItem.back");
         _daySp = ComponentFactory.Instance.creatCustomObject("continuePayRebate.chestPayItem.numSP");
         _dayNum = ComponentFactory.Instance.creatBitmapData("asset.continuePayRebate.chestItem.money");
         addChild(_back);
         addChild(_daySp);
      }
      
      public function set dayCount(param1:int) : void
      {
         if(!param1)
         {
            return;
         }
         _dayCount = param1;
         NumberViewUtils.refreshValue(_dayCount,_daySp,_dayNum,20,20,16,20,"0123456789");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_daySp);
         _daySp = null;
         ObjectUtils.disposeObject(_dayNum);
         _dayNum = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

