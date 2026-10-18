package mvc.module.selectcampaign
{
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.utils.SimpleDictionary;
   
   public class CampaignAreaInfo
   {
      
      public var areaId:int;
      
      public var areaName:String;
      
      public var posX:int;
      
      public var posY:int;
      
      public var viewContentLoaded:Boolean;
      
      public var campaignId:int;
      
      public var userId:int;
      
      public var uuid:String;
      
      public var nickName:String;
      
      public var occupyTime:String;
      
      public var param1:String;
      
      public var param2:String;
      
      public var param3:String;
      
      public var fashionArm:String;
      
      public var fashionWing:String;
      
      public var fashionCloth:String;
      
      public var fashionHair:String;
      
      public var fashionHat:String;
      
      public var arm:String;
      
      public var templateId:int;
      
      public var job:int;
      
      public var sexJob:int;
      
      public var thane:ThaneInfo;
      
      private var _mapDic:SimpleDictionary;
      
      public function CampaignAreaInfo()
      {
         super();
         _mapDic = new SimpleDictionary(true);
      }
      
      public function addMapTemplate(param1:CampaignTemplate) : void
      {
         _mapDic.add(param1.CampaignId,param1);
      }
      
      public function getMapById(param1:int) : CampaignTemplate
      {
         return _mapDic[param1] as CampaignTemplate;
      }
      
      public function getMapByDifficult(param1:int) : CampaignTemplate
      {
         for each(var _loc2_:CampaignTemplate in _mapDic)
         {
            if(_loc2_.DifficultyGrade == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMapList() : Array
      {
         return _mapDic.getList().sortOn("CampaignId");
      }
   }
}

