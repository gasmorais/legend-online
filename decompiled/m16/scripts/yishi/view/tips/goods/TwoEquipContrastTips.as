package yishi.view.tips.goods
{
   import com.pickgliss.utils.ObjectUtils;
   import yishi.view.tips.BaseTip;
   
   public class TwoEquipContrastTips extends BaseTip
   {
      
      private var tip1:FashionCardTip;
      
      private var tip2:FashionCardTip;
      
      public function TwoEquipContrastTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         tip1 = new FashionCardTip();
         tip2 = new FashionCardTip();
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 2)
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
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

