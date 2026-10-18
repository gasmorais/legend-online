package yishi.view.frame.discount
{
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   
   public class DiscountUtil
   {
      
      public function DiscountUtil()
      {
         super();
      }
      
      public static function getDiscountNumByIdAndPrice(param1:int, param2:int) : int
      {
         var _loc5_:ConfigInfosTempInfo = null;
         var _loc6_:int = 0;
         var _loc4_:int = DiscountCons.DISCOUNT_ID_ARR.indexOf(param1);
         if(_loc4_ == -1)
         {
            return 0;
         }
         _loc5_ = TempleteManager.instance.getConfigInfoByConfigName(DiscountCons.TEMPLATE_CONFIG_NAMES[_loc4_]);
         var _loc3_:Array = _loc5_.ConfigValue.split("|");
         if(_loc3_.length == 1)
         {
            if(param2 >= _loc3_[0].split(",")[0])
            {
               return _loc3_[0].split(",")[1];
            }
         }
         else if(_loc3_.length > 1)
         {
            _loc6_ = _loc3_.length - 1;
            while(_loc6_ >= 0)
            {
               if(param2 >= _loc3_[_loc6_].split(",")[0])
               {
                  return _loc3_[_loc6_].split(",")[1];
               }
               _loc6_--;
            }
         }
         return 0;
      }
      
      public static function isInitDiscountUI(param1:int) : Boolean
      {
         for each(var _loc2_:int in DiscountCons.DISCOUNT_ID_ARR)
         {
            if(_loc2_ >= 3171001)
            {
               if(param1 == 1 && _loc2_ == 3171001)
               {
                  if(GoodsManager.instance.getBagGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getMailGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getBottleGoodsByTemplateId(_loc2_).length > 0)
                  {
                     return true;
                  }
               }
               else if(param1 == 2 && _loc2_ == 3172001)
               {
                  if(GoodsManager.instance.getBagGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getMailGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getBottleGoodsByTemplateId(_loc2_).length > 0)
                  {
                     return true;
                  }
               }
               else if(param1 == 3 && _loc2_ == 3173001)
               {
                  if(GoodsManager.instance.getBagGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getMailGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getBottleGoodsByTemplateId(_loc2_).length > 0)
                  {
                     return true;
                  }
               }
            }
            else if(GoodsManager.instance.getBagGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getMailGoodsByTemplateId(_loc2_).length > 0 || GoodsManager.instance.getBottleGoodsByTemplateId(_loc2_).length > 0)
            {
               return true;
            }
         }
         return false;
      }
   }
}

