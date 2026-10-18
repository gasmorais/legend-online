package yishi.utils
{
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.ResourceManager;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreHelper
   {
      
      public function StoreHelper()
      {
         super();
      }
      
      public static function getSuccessRate(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         var _loc3_:int = 0;
         if(param1.isViceEquip)
         {
            if(param1)
            {
               _loc3_ = param1.strengthenGrade % 10 + 1;
               if(_loc3_ <= 5)
               {
                  _loc3_ = 50 - 10 * (_loc3_ - 1);
               }
               else
               {
                  _loc3_ = 5;
               }
            }
            return int(_loc3_ > 100 ? 100 : _loc3_);
         }
         if(param1)
         {
            _loc3_ = 100 - param1.strengthenGrade * 10;
            _loc3_ = int(_loc3_ > 100 ? 100 : (_loc3_ < 10 ? 10 : _loc3_));
         }
         if(param2)
         {
            _loc3_ += param2.templateInfo.Property1;
         }
         return int(_loc3_ > 100 ? 100 : _loc3_);
      }
      
      public static function checkCanIntensify(param1:int, param2:GoodsInfo) : Boolean
      {
         var _loc5_:int = param2.strengthenGrade;
         var _loc3_:int = ResourceManager.instance.gold.count;
         var _loc4_:String = "";
         if(param1 > _loc3_)
         {
            _loc4_ = LanguageMgr.GetTranslation("store.utils.StoreHelper.command01",param1 - _loc3_);
            MessageTipManager.instance().show(_loc4_);
            return false;
         }
         if(_loc5_ >= param2.templateInfo.StrengthenMax)
         {
            _loc4_ = LanguageMgr.GetTranslation("store.utils.StoreHelper.command02");
            MessageTipManager.instance().show(_loc4_);
            return false;
         }
         return true;
      }
      
      public static function getMouldSuccessRate(param1:GoodsInfo) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1)
         {
            if(param1.mouldStar == 10)
            {
               _loc2_ = 1;
            }
            else
            {
               _loc2_ = param1.mouldStar + 1;
            }
            if(_loc2_ <= 5)
            {
               _loc3_ = 50 - 10 * (_loc2_ - 1);
            }
            else
            {
               _loc3_ = 5;
            }
         }
         return int(_loc3_ > 100 ? 100 : _loc3_);
      }
   }
}

