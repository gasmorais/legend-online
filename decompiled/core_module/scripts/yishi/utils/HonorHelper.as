package yishi.utils
{
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class HonorHelper
   {
      
      public function HonorHelper()
      {
         super();
      }
      
      public static function getHonorNameByValue(param1:int) : UpgradeTemplateInfo
      {
         var _loc3_:int = 0;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc4_:Array = TempleteManager.instance.getTemplatesByType(14);
         _loc4_.sortOn("Data",0x10 | 2);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_] as UpgradeTemplateInfo;
            if(param1 >= _loc2_.Data)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
   }
}

