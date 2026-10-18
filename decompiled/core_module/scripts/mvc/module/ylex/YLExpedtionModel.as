package mvc.module.ylex
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   
   public class YLExpedtionModel
   {
      
      public static const OPEN:int = 1;
      
      public static const STATIONED:int = 2;
      
      public static const BUY_COVER:int = 3;
      
      public static const DEFENSE:int = 4;
      
      public static const BUY_ENERGY:int = 5;
      
      public static const AWARD:int = 6;
      
      public static const OP_SNEAK:int = 7;
      
      public static const EVENT_UPDATE_INFO:String = "YLExpedtionModel.EVENT_UPDATE_INFO";
      
      public static const EVENT_SELECTED_ADD:String = "YLExpedtionModel.EVENT_SELECTED_ADD";
      
      public static const EVENT_SELECTED_DEL:String = "YLExpedtionModel.EVENT_SELECTED_DEL";
      
      public var camp_list:Dictionary;
      
      public var child_list:Dictionary;
      
      public var sneakTimeCD:int = 0;
      
      public var sneakAttackLossPrecent:int = 0;
      
      public var buyEnergyPoint:Array = [];
      
      public var buyCoverPoint:Array = [];
      
      public var energyRecoveryTimeCD:int = 0;
      
      public var doubleExpPoint:int = 0;
      
      public function YLExpedtionModel()
      {
         var _loc1_:ConfigInfosTempInfo = null;
         super();
         camp_list = new Dictionary();
         child_list = new Dictionary();
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("childcamp_sneak_attack_time");
         if(_loc1_)
         {
            sneakTimeCD = int(_loc1_.ConfigValue);
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("childcamp_sneak_attack_loss");
         if(_loc1_)
         {
            sneakAttackLossPrecent = int(_loc1_.ConfigValue);
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("childcamp_buy_energy_point");
         if(_loc1_)
         {
            buyEnergyPoint = _loc1_.ConfigValue.split(",");
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("childcamp_buy_cover_point");
         if(_loc1_)
         {
            buyCoverPoint = _loc1_.ConfigValue.split(",");
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("childcamp_energy_recovery_time");
         if(_loc1_)
         {
            energyRecoveryTimeCD = int(_loc1_.ConfigValue);
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("childcamp_double_exp_point");
         if(_loc1_)
         {
            doubleExpPoint = int(_loc1_.ConfigValue);
         }
      }
      
      public function getCampInfoByChildId(param1:int) : ChildCampInfo
      {
         for each(var _loc2_:ChildCampInfo in camp_list)
         {
            if(_loc2_.childId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

