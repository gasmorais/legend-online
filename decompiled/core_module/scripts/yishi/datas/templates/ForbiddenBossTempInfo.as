package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   
   public class ForbiddenBossTempInfo
   {
      
      public var Id:int;
      
      public var Category:int;
      
      public var BossType:int;
      
      public var MarkImage:String;
      
      public var CampaignId:int;
      
      public var BAV:int;
      
      public var HpMultiple:int;
      
      public var RefreshType:int;
      
      public var RefreshParm:int;
      
      public var FirstRewards:String;
      
      public var BossSkill:String;
      
      private var _bossInfo:String;
      
      public var bossName:String = "";
      
      public var bossGrades:int = 0;
      
      public var bossTempId:int = 0;
      
      public var bossIcon:String = "";
      
      public var firstRewardsType:int = 2;
      
      public var RewardShow1:String = "";
      
      public var RewardShow2:String = "";
      
      public function ForbiddenBossTempInfo()
      {
         super();
      }
      
      public function set BossInfo(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:GameHeroTempInfo = null;
         _bossInfo = param1;
         var _loc2_:Array = _bossInfo.split(",");
         if(_loc2_.length > 0)
         {
            _loc3_ = int(_loc2_[0]);
            _loc4_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc3_);
            if(_loc4_)
            {
               bossName = _loc4_.TemplateName;
               bossGrades = _loc4_.Grades;
               bossTempId = _loc4_.TemplateId;
               bossIcon = _loc4_.Icon;
            }
         }
      }
      
      public function get campaignName() : String
      {
         var _loc1_:CampaignTemplate = TempleteManager.instance.getCampaignTemplateById(CampaignId);
         if(_loc1_)
         {
            return _loc1_.CampaignName;
         }
         return "";
      }
   }
}

