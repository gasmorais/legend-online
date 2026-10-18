package mvc.module.selectcampaign
{
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignRankManager;
   import yishi.utils.SimpleDictionary;
   
   public class CampaignChapterInfo
   {
      
      public var chapterId:int;
      
      private var _areaDic:SimpleDictionary;
      
      public function CampaignChapterInfo()
      {
         super();
         _areaDic = new SimpleDictionary(true);
      }
      
      public function addAreaInfo(param1:CampaignAreaInfo) : void
      {
         _areaDic.add(param1.areaId,param1);
      }
      
      public function getAreaInfoById(param1:int) : CampaignAreaInfo
      {
         return _areaDic[param1] as CampaignAreaInfo;
      }
      
      public function getMaxOpenArea() : CampaignAreaInfo
      {
         var _loc1_:CampaignAreaInfo = null;
         for each(var _loc2_:CampaignAreaInfo in _areaDic)
         {
            if(_loc2_.getMapByDifficult(1).state != 0)
            {
               if(!_loc1_)
               {
                  _loc1_ = _loc2_;
               }
               if(_loc1_.areaId <= _loc2_.areaId)
               {
                  _loc1_ = _loc2_;
               }
            }
         }
         return _loc1_;
      }
      
      public function isAllOpenArea() : Boolean
      {
         var _loc1_:Boolean = true;
         for each(var _loc2_:CampaignAreaInfo in _areaDic)
         {
            if(_loc2_.getMapByDifficult(1).state != 1)
            {
               return false;
            }
            if(_loc2_.areaId > 10200)
            {
               if(!CampaignRankManager.instance.singleRankDic[_loc2_.areaId])
               {
                  return false;
               }
               if(!CampaignRankManager.instance.singleRankDic[_loc2_.areaId].rank)
               {
                  return false;
               }
               if(CampaignRankManager.instance.singleRankDic[_loc2_.areaId].rank < 7)
               {
                  return false;
               }
            }
         }
         return _loc1_;
      }
      
      public function isAllLoaded() : Boolean
      {
         var _loc1_:Boolean = true;
         for each(var _loc2_:CampaignAreaInfo in _areaDic)
         {
            if(!_loc2_.viewContentLoaded)
            {
               _loc1_ = false;
            }
         }
         return _loc1_;
      }
      
      public function getAreaByCampaignTem(param1:CampaignTemplate) : CampaignAreaInfo
      {
         if(!param1)
         {
            return null;
         }
         if(param1.state == 0)
         {
            return getMaxSelectAewa();
         }
         for each(var _loc2_:CampaignAreaInfo in _areaDic)
         {
            if(_loc2_.areaId == param1.AreaId)
            {
               if(_loc2_.getMapByDifficult(1).MinLevel <= thane.grades)
               {
                  return _loc2_;
               }
               return getMaxSelectAewa();
            }
         }
         return null;
      }
      
      public function getMaxSelectAewa() : CampaignAreaInfo
      {
         var _loc1_:CampaignAreaInfo = null;
         for each(var _loc2_:CampaignAreaInfo in _areaDic)
         {
            if(_loc2_.getMapByDifficult(1).state != 0 && _loc2_.getMapByDifficult(1).MinLevel <= thane.grades)
            {
               if(!_loc1_)
               {
                  _loc1_ = _loc2_;
               }
               if(_loc1_.areaId <= _loc2_.areaId)
               {
                  _loc1_ = _loc2_;
               }
            }
         }
         return _loc1_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get areaDic() : SimpleDictionary
      {
         return _areaDic;
      }
      
      public function getChapterName() : String
      {
         switch(chapterId - 101)
         {
            case 0:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignChapterInfo.chapterId01");
            case 1:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignChapterInfo.chapterId02");
            case 2:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignChapterInfo.chapterId03");
            case 3:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignChapterInfo.chapterId04");
            case 4:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignChapterInfo.chapterId05");
            case 5:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignChapterInfo.chapterId06");
            case 6:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignChapterInfo.chapterId07");
            default:
               return "";
         }
      }
      
      public function getChapterRevengeCost() : int
      {
         switch(chapterId - 101)
         {
            case 0:
               return 100;
            case 1:
               return 200;
            case 2:
               return 300;
            case 3:
               return 400;
            case 4:
               return 500;
            case 5:
               return 600;
            case 6:
               return 700;
            default:
               return 100;
         }
      }
   }
}

