package yishi.manager
{
   import flash.utils.Dictionary;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.selectcampaign.CampaignLandInfo;
   import yishi.datas.VersionSwitchInfo;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.utils.SimpleDictionary;
   
   public class CampaignTemplateManager
   {
      
      private static var _instance:CampaignTemplateManager;
      
      public static var cannelClearance:Boolean;
      
      public static var cannelTimeVortexClearance:Boolean;
      
      private var _landDic:SimpleDictionary;
      
      private var _landList:Array;
      
      private var _timeVortexLandDic:SimpleDictionary;
      
      private var _timeVortexLandList:Array;
      
      public function CampaignTemplateManager()
      {
         super();
         _landDic = new SimpleDictionary(true);
         _landList = [];
         _timeVortexLandDic = new SimpleDictionary(true);
         _timeVortexLandList = [];
      }
      
      public static function get instance() : CampaignTemplateManager
      {
         if(!_instance)
         {
            _instance = new CampaignTemplateManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         var _loc6_:CampaignLandInfo = null;
         var _loc3_:CampaignChapterInfo = null;
         var _loc1_:* = null;
         var _loc5_:Dictionary = TempleteManager.instance.campaignTemplateDic;
         var _loc4_:Dictionary = TempleteManager.instance.timeVortexDic;
         for each(var _loc2_:CampaignTemplate in _loc5_)
         {
            _loc6_ = _landDic[_loc2_.LandId] as CampaignLandInfo;
            if(!_loc6_)
            {
               _loc6_ = new CampaignLandInfo();
               _loc6_.landId = _loc2_.LandId;
               _landDic.add(_loc6_.landId,_loc6_);
            }
            _loc3_ = _loc6_.getChapterById(_loc2_.DungeonId);
            addAreaToChapter(_loc2_,_loc3_,_loc6_);
         }
         for each(_loc6_ in _landDic)
         {
            if(_loc6_.landId != 0)
            {
               _landList.push(_loc6_);
            }
         }
         for each(_loc2_ in _loc4_)
         {
            _loc6_ = _timeVortexLandDic[_loc2_.LandId] as CampaignLandInfo;
            if(!_loc6_)
            {
               _loc6_ = new CampaignLandInfo();
               _loc6_.landId = _loc2_.LandId;
               _timeVortexLandDic.add(_loc6_.landId,_loc6_);
            }
            _loc3_ = _loc6_.getChapterById(_loc2_.DungeonId);
            addAreaToChapter(_loc2_,_loc3_,_loc6_);
            _loc3_ = _loc6_.getChapterCrackById(_loc2_.DungeonId);
            addAreaToChapterCrack(_loc2_,_loc3_,_loc6_);
         }
         for each(_loc6_ in _timeVortexLandDic)
         {
            _timeVortexLandList.push(_loc6_);
         }
      }
      
      private function addAreaToChapter(param1:CampaignTemplate, param2:CampaignChapterInfo, param3:CampaignLandInfo) : void
      {
         if(!param2)
         {
            param2 = new CampaignChapterInfo();
            param2.chapterId = param1.DungeonId;
            param3.addChapterInfo(param2);
         }
         var _loc4_:CampaignAreaInfo = param2.getAreaInfoById(param1.AreaId);
         addMapTempToArea(param1,_loc4_,param2);
      }
      
      private function addAreaToChapterCrack(param1:CampaignTemplate, param2:CampaignChapterInfo, param3:CampaignLandInfo) : void
      {
         if(!param2)
         {
            param2 = new CampaignChapterInfo();
            param2.chapterId = param1.DungeonId;
            param3.addChapterCrackInfo(param2);
         }
      }
      
      private function addMapTempToArea(param1:CampaignTemplate, param2:CampaignAreaInfo, param3:CampaignChapterInfo) : void
      {
         if(!param2)
         {
            param2 = new CampaignAreaInfo();
            param2.areaId = param1.AreaId;
            param2.areaName = param1.CampaignName;
            param2.posX = param1.PosX;
            param2.posY = param1.PosY;
            param3.addAreaInfo(param2);
         }
         if(!param2.getMapById(param1.CampaignId))
         {
            param2.addMapTemplate(param1);
         }
      }
      
      public function checkCanChoose() : void
      {
         var _loc2_:Dictionary = TempleteManager.instance.campaignTemplateDic;
         var _loc1_:SimpleDictionary = CampaignRankManager.instance.rankDic;
         for each(var _loc3_:CampaignTemplate in _loc2_)
         {
            if(cannelClearance)
            {
               _loc3_.state = 2;
            }
            else
            {
               if(_loc3_.PreCampaignId == 0)
               {
                  _loc3_.state = 2;
               }
               if(_loc1_[_loc3_.CampaignId])
               {
                  _loc3_.state = 1;
               }
               else if(_loc1_[_loc3_.PreCampaignId])
               {
                  _loc3_.state = 2;
               }
               else if(_loc3_.PreCampaignId != 0)
               {
                  _loc3_.state = 0;
               }
            }
         }
      }
      
      public function get landDic() : SimpleDictionary
      {
         return _landDic;
      }
      
      public function get landList() : Array
      {
         return _landList;
      }
      
      public function get timeVortexLandDic() : SimpleDictionary
      {
         return _timeVortexLandDic;
      }
      
      public function get timeVortexLandList() : Array
      {
         return _timeVortexLandList;
      }
      
      public function getMutiCampaignList() : Array
      {
         var _loc2_:CampaignChapterInfo = null;
         var _loc1_:SimpleDictionary = null;
         var _loc3_:CampaignTemplate = null;
         var _loc4_:CampaignLandInfo = _landDic[0];
         var _loc5_:Array = [];
         for(var _loc6_:String in _loc4_.chapterDic)
         {
            if(!(_loc6_ == "0" || _loc6_ == "3" || _loc6_ == "4"))
            {
               _loc2_ = _loc4_.chapterDic[_loc6_];
               _loc1_ = _loc2_.areaDic;
               for each(var _loc7_:CampaignAreaInfo in _loc1_)
               {
                  _loc3_ = _loc7_.getMapList()[0] as CampaignTemplate;
                  if(!(!VersionSwitchInfo.WEEK_CAMPAIGN && _loc3_ && _loc3_.AreaId == 402))
                  {
                     _loc5_.push(_loc7_.getMapList()[0]);
                  }
               }
            }
         }
         _loc5_.sortOn("MinLevel");
         return _loc5_;
      }
      
      public function getActiveCampaignList() : Array
      {
         var _loc3_:CampaignLandInfo = _landDic[0];
         var _loc4_:Array = [];
         var _loc2_:CampaignChapterInfo = _loc3_.chapterDic["3"];
         var _loc1_:SimpleDictionary = _loc2_.areaDic;
         for each(var _loc5_:CampaignAreaInfo in _loc1_)
         {
            if(_loc5_.areaId == 304)
            {
               for each(var _loc6_:CampaignTemplate in _loc5_.getMapList())
               {
                  _loc4_.push(_loc6_);
               }
            }
            else
            {
               _loc4_.push(_loc5_.getMapList()[0]);
            }
         }
         _loc4_.sortOn("MinLevel");
         return _loc4_;
      }
      
      public function isOpenByActiveCampaign(param1:int) : Boolean
      {
         var _loc4_:CampaignTemplate = null;
         var _loc3_:Array = getActiveCampaignList();
         for each(var _loc5_:CampaignTemplate in _loc3_)
         {
            if(param1 == 301)
            {
               if(_loc5_.isTrailTower)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            else if(param1 == 305)
            {
               if(_loc5_.isFantasyMatrix)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            else if(param1 == 306)
            {
               if(_loc5_.isSpacetimeFault)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            else if(param1 == 307)
            {
               if(_loc5_.isDungeoTurn)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            else if(param1 == 308)
            {
               if(_loc5_.isDarkKing)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            else if(param1 == 309)
            {
               if(_loc5_.isRaceAgainstTime)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            else if(param1 == 310)
            {
               if(_loc5_.isForest)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
         }
         var _loc2_:Boolean = true;
         if(_loc4_)
         {
            if(_loc4_.MinLevel > ArmyManager.instance.thane.grades)
            {
               _loc2_ = false;
            }
            else if(ArmyManager.instance.thane.vocationGrades <= 0)
            {
               if(_loc4_.NeedTransfer)
               {
                  _loc2_ = false;
               }
            }
            else if(!ArmyManager.instance.thane.isChangeJob)
            {
               if(_loc4_.NeedChangeJob)
               {
                  _loc2_ = false;
               }
            }
            else if(!ArmyManager.instance.thane.isAvenger)
            {
               if(_loc4_.NeedThirdTransfer)
               {
                  _loc2_ = false;
               }
            }
            else if(!ArmyManager.instance.thane.isHoly)
            {
               if(_loc4_.NeedFourTransfer)
               {
                  _loc2_ = false;
               }
            }
         }
         return _loc2_;
      }
      
      public function getWeekCampaignList() : Array
      {
         var _loc3_:CampaignTemplate = null;
         var _loc4_:CampaignLandInfo = _landDic[0];
         var _loc5_:Array = [];
         var _loc2_:CampaignChapterInfo = _loc4_.chapterDic["4"];
         var _loc1_:SimpleDictionary = _loc2_.areaDic;
         for each(var _loc6_:CampaignAreaInfo in _loc1_)
         {
            _loc3_ = _loc6_.getMapList()[0] as CampaignTemplate;
            if(!(!VersionSwitchInfo.WEEK_CAMPAIGN && _loc3_ && _loc3_.AreaId == 402))
            {
               _loc5_.push(_loc6_.getMapList()[0]);
            }
         }
         _loc5_.sortOn("MinLevel");
         return _loc5_;
      }
      
      public function checkTimeVortexCanChoose() : void
      {
         var _loc1_:RankInfo = null;
         var _loc3_:Dictionary = TempleteManager.instance.timeVortexDic;
         var _loc2_:SimpleDictionary = CampaignRankManager.instance.timeVortexRankDic;
         for each(var _loc4_:CampaignTemplate in _loc3_)
         {
            if(cannelTimeVortexClearance)
            {
               _loc4_.state = 1;
               _loc1_ = new RankInfo();
               _loc1_.campaignId = _loc4_.CampaignId;
               _loc2_.add(_loc1_.campaignId,_loc1_);
            }
            else
            {
               if(_loc4_.PreCampaignId == 0)
               {
                  _loc4_.state = 2;
               }
               if(_loc2_[_loc4_.CampaignId])
               {
                  _loc4_.state = 1;
               }
               else if(_loc2_[_loc4_.PreCampaignId])
               {
                  _loc4_.state = 2;
               }
               else if(_loc4_.PreCampaignId != 0)
               {
                  _loc4_.state = 0;
               }
            }
         }
      }
   }
}

