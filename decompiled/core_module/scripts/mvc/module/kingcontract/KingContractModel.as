package mvc.module.kingcontract
{
   import yishi.datas.templates.KingContractTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class KingContractModel
   {
      
      public static const REWARD_BUFF:int = 2;
      
      public static const TIME_BUFF:int = 4;
      
      public static const MOPUP_BUFF:int = 5;
      
      public static const SPECIAL_BUFF:int = 6;
      
      public static const AUTO_FARM:int = 8;
      
      public static const SKILL_MASTER:int = 9;
      
      public static const MONSTER_RADAR:int = 10;
      
      public static const WORLD_BOSS_AUTO_FIGHT:int = 11;
      
      public static const REPEAT_REWARD_MASTER:int = 12;
      
      public static const FORBIDDENBOSS_AUTO:int = 15;
      
      public static const SHOUWEIXUNLUO:int = 16;
      
      public static var SORT_ARR:Array = [2,4,6,9,10,11,12,15,16];
      
      private var _kingContractInfos:SimpleDictionary;
      
      public function KingContractModel()
      {
         super();
         _kingContractInfos = new SimpleDictionary();
         for each(var _loc1_:int in SORT_ARR)
         {
            getInfoById(_loc1_);
         }
      }
      
      public function getInfoById(param1:int = 0) : KingContractInfo
      {
         var _loc3_:KingContractInfo = null;
         var _loc2_:KingContractTemplateInfo = null;
         if(!_kingContractInfos[param1])
         {
            _loc3_ = new KingContractInfo();
            _loc2_ = TempleteManager.instance.kingContraceCate.getTemplateByID(param1);
            if(_loc2_)
            {
               _loc3_.templateId = _loc2_.Id;
               _loc3_.template = _loc2_;
               _kingContractInfos.add(_loc3_.templateId,_loc3_);
            }
         }
         return _kingContractInfos[param1] as KingContractInfo;
      }
      
      public function get kingContractInfos() : SimpleDictionary
      {
         return _kingContractInfos;
      }
   }
}

