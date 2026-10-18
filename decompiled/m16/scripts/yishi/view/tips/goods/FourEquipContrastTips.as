package yishi.view.tips.goods
{
   import com.pickgliss.utils.ObjectUtils;
   import yishi.view.tips.BaseTip;
   
   public class FourEquipContrastTips extends BaseTip
   {
      
      private var tip1:FashionCardTip;
      
      private var tip2:FashionCardTip;
      
      private var tip3:FashionCardTip;
      
      private var tip4:FashionCardTip;
      
      public function FourEquipContrastTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         tip1 = new FashionCardTip();
         tip2 = new FashionCardTip();
         tip3 = new FashionCardTip();
         tip4 = new FashionCardTip();
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(param1[_loc2_])
            {
               _loc3_ = _loc2_ + 1;
               this["tip" + _loc3_].tipData = param1[_loc2_];
               addChild(this["tip" + _loc3_]);
            }
            _loc2_++;
         }
         tip2.x = tip1.x + tip1.width;
         tip3.x = tip2.x + tip2.width;
         tip4.x = tip3.x + tip3.width;
      }
      
      override public function dispose() : void
      {
         if(tip1)
         {
            tip1.dispose();
         }
         tip1 = null;
         if(tip2)
         {
            tip2.dispose();
         }
         tip2 = null;
         if(tip3)
         {
            tip3.dispose();
         }
         tip3 = null;
         if(tip4)
         {
            tip4.dispose();
         }
         tip4 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

