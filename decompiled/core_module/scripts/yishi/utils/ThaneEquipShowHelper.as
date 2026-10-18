package yishi.utils
{
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   
   public class ThaneEquipShowHelper
   {
      
      public static const POS_WEAPON:int = 0;
      
      public static const POS_HEADDRESS:int = 1;
      
      public static const POS_CLOTHES:int = 2;
      
      public static const POS_WING:int = 8;
      
      public static const POS_HEADDRESS_FASHION:int = 9;
      
      public static const POS_CLOTHES_FASHION:int = 10;
      
      public static const POS_WEAPON_FASHION:int = 11;
      
      public function ThaneEquipShowHelper()
      {
         super();
      }
      
      public static function getAvatarByEquipPos(param1:int) : String
      {
         var _loc5_:String = "";
         var _loc3_:GoodsInfo = new GoodsInfo();
         var _loc2_:int = 4;
         var _loc4_:int = ArmyManager.instance.thane.id;
         _loc3_ = GoodsManager.instance.getItemByPOB(param1,_loc4_,_loc2_);
         if(!_loc3_)
         {
            return _loc5_;
         }
         if(_loc3_.templateInfo)
         {
            return _loc3_.templateInfo.Avata;
         }
         return _loc5_;
      }
      
      public static function getAvatarByEquipInfo(param1:GoodsInfo) : String
      {
         var _loc3_:String = "";
         var _loc2_:int = ArmyManager.instance.thane.id;
         if(!param1)
         {
            return _loc3_;
         }
         if(param1.templateInfo)
         {
            return param1.templateInfo.Avata;
         }
         return _loc3_;
      }
      
      public static function getAvatarByEquipTemplateInfo(param1:GoodsTemplateInfo, param2:Boolean) : String
      {
         var _loc4_:String = "";
         var _loc3_:int = ArmyManager.instance.thane.id;
         if(!param1)
         {
            return _loc4_;
         }
         if(param1)
         {
            return param1.Avata;
         }
         return _loc4_;
      }
   }
}

