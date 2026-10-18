package mvc.module.timevortex
{
   import events.TimeVortexEvent;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.selectcampaign.CampaignLandInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.CampaignTemplateManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class TimeVortexModel extends EventDispatcher
   {
      
      public static const REWARD_CHALLENGE_FIRST:int = 1;
      
      public static const REWARD_CHALLENGE:int = 2;
      
      public static const REWARD_HOUR:int = 3;
      
      public static const REWARD_FINAL:int = 4;
      
      public static const REWARD_CRACK:int = 5;
      
      public static const REWARD_CRACK_DEFEND:int = 6;
      
      private var _selectedLand:CampaignLandInfo;
      
      private var _selectedChapter:CampaignChapterInfo;
      
      private var _selectedArea:CampaignAreaInfo;
      
      private var _selectedCampaign:CampaignTemplate;
      
      private var _selectedCrack:CampaignAreaInfo;
      
      private var _teamInfo:SimpleDictionary = new SimpleDictionary(true);
      
      private var _crackDefendRewardMax:int;
      
      private var _crackChallengeRewardMax:int;
      
      private var nameposX:int;
      
      private var nameposY:int;
      
      private var _dropInfos:Dictionary;
      
      public var recentChapter:CampaignChapterInfo;
      
      public var taskCampaignTem:CampaignTemplate;
      
      public var challengeCampaignTem:CampaignTemplate;
      
      public var maxChapter:CampaignChapterInfo;
      
      public var dragonOpenInfo:DragonOpenInfo = new DragonOpenInfo();
      
      public function TimeVortexModel()
      {
         if(ConfigInfoManager.instance.checkIsConfigExist("time_crack_defens_count"))
         {
            _crackDefendRewardMax = ConfigInfoManager.instance.getKeyToInt("time_crack_defens_count");
         }
         else
         {
            _crackDefendRewardMax = 10;
         }
         if(ConfigInfoManager.instance.checkIsConfigExist("time_crack_get_count"))
         {
            _crackChallengeRewardMax = ConfigInfoManager.instance.getKeyToInt("time_crack_get_count");
         }
         else
         {
            _crackChallengeRewardMax = 10;
         }
         super();
      }
      
      public function get challengeMax() : int
      {
         var _loc1_:int = OldPlayerReturnManager.instance.model.timeVortexCount;
         return _loc1_ + 10;
      }
      
      public function get crackDefendRewardMax() : int
      {
         return _crackDefendRewardMax;
      }
      
      public function get crackChallengeRewardMax() : int
      {
         return _crackChallengeRewardMax;
      }
      
      public function set selectedLand(param1:CampaignLandInfo) : void
      {
         if(_selectedLand == param1)
         {
            return;
         }
         _selectedLand = param1;
         dispatchEvent(new TimeVortexEvent("SELECTED_LAND_CHANGE"));
      }
      
      public function set selectedChapter(param1:CampaignChapterInfo) : void
      {
         _selectedChapter = param1;
         if(_selectedChapter)
         {
            dispatchEvent(new TimeVortexEvent("SELECTED_CHAPTER_CHANGE"));
         }
      }
      
      private function get nameposPoint() : Point
      {
         return new Point(nameposX,nameposY);
      }
      
      public function set point(param1:Point) : void
      {
         nameposX = param1.x;
         nameposY = param1.y;
      }
      
      public function set selectedArea(param1:CampaignAreaInfo) : void
      {
         _selectedArea = param1;
         dispatchEvent(new TimeVortexEvent("SELECTED_AREA_CHANGE",nameposPoint));
      }
      
      public function set selectCampaign(param1:CampaignTemplate) : void
      {
         _selectedCampaign = param1;
         if(_selectedCampaign)
         {
            dispatchEvent(new TimeVortexEvent("SELECTED_CAMPAIGN_CHANGE"));
         }
      }
      
      public function set selectedCrack(param1:CampaignAreaInfo) : void
      {
         _selectedCrack = param1;
      }
      
      public function getDropInfos(param1:int) : Dictionary
      {
         var _loc5_:Dictionary = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_dropInfos == null)
         {
            _dropInfos = new Dictionary();
            _loc5_ = TempleteManager.instance.timeVortexDropTemplateCate.getTemplates();
            _loc3_ = 0;
            _loc4_ = 0;
            for each(var _loc2_:TimeVortexDropTemplateInfo in _loc5_)
            {
               _loc3_ = _loc2_.CampaignId;
               _loc4_ = _loc2_.RewardType;
               if(_dropInfos[_loc3_] == null)
               {
                  _dropInfos[_loc3_] = new Dictionary();
                  _dropInfos[_loc3_][1] = new Vector.<TimeVortexDropTemplateInfo>();
                  _dropInfos[_loc3_][2] = new Vector.<TimeVortexDropTemplateInfo>();
                  _dropInfos[_loc3_][3] = new Vector.<TimeVortexDropTemplateInfo>();
                  _dropInfos[_loc3_][4] = new Vector.<TimeVortexDropTemplateInfo>();
                  _dropInfos[_loc3_][5] = new Vector.<TimeVortexDropTemplateInfo>();
                  _dropInfos[_loc3_][6] = new Vector.<TimeVortexDropTemplateInfo>();
               }
               _dropInfos[_loc3_][_loc4_].push(_loc2_);
            }
         }
         return _dropInfos[param1];
      }
      
      public function getRecentCanSelectChapter() : void
      {
         var _loc2_:CampaignChapterInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = selectedLand.chapterDic.getList();
         _loc1_.sort(sortFun);
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            _loc2_ = _loc1_[_loc4_];
            if(_loc2_.getMaxOpenArea())
            {
               maxChapter = _loc2_;
            }
            _loc4_--;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc1_[_loc5_];
            if(taskCampaignTem && taskCampaignTem.DungeonId == _loc2_.chapterId && taskCampaignTem.DungeonId <= maxChapter.chapterId)
            {
               recentChapter = _loc2_;
               return;
            }
            if(!taskCampaignTem && challengeCampaignTem && challengeCampaignTem.DungeonId == _loc2_.chapterId && challengeCampaignTem.DungeonId <= maxChapter.chapterId)
            {
               recentChapter = _loc2_;
               return;
            }
            if(!taskCampaignTem && !challengeCampaignTem && _loc2_.getMaxOpenArea())
            {
               recentChapter = _loc2_;
               return;
            }
            _loc5_++;
         }
         recentChapter = _loc1_[_loc1_.length - 1] as CampaignChapterInfo;
      }
      
      private function sortFun(param1:CampaignChapterInfo, param2:CampaignChapterInfo) : int
      {
         if(param1.chapterId > param2.chapterId)
         {
            return -1;
         }
         if(param1.chapterId < param2.chapterId)
         {
            return 1;
         }
         return 0;
      }
      
      public function get openDragon() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = dragonOpenInfo["dragontalker" + (_loc2_ + 1)] == 0 ? false : true;
            if(!_loc1_)
            {
               return false;
            }
            _loc2_ += 1;
         }
         return true;
      }
      
      public function get selectedLand() : CampaignLandInfo
      {
         return CampaignTemplateManager.instance.timeVortexLandDic[1];
      }
      
      public function get selectedChapter() : CampaignChapterInfo
      {
         return _selectedChapter;
      }
      
      public function get selectedArea() : CampaignAreaInfo
      {
         return _selectedArea;
      }
      
      public function get selectCampaign() : CampaignTemplate
      {
         return _selectedCampaign;
      }
      
      public function get selectedCrack() : CampaignAreaInfo
      {
         return _selectedCrack;
      }
      
      public function get teamInfo() : SimpleDictionary
      {
         return _teamInfo;
      }
      
      public function get normalMap() : CampaignTemplate
      {
         if(!_selectedArea)
         {
            return null;
         }
         return _selectedArea.getMapByDifficult(1);
      }
      
      public function get heroMap() : CampaignTemplate
      {
         if(!_selectedArea)
         {
            return null;
         }
         return _selectedArea.getMapByDifficult(2);
      }
      
      public function isNormalOpen() : Boolean
      {
         if(normalMap && normalMap.state != 0)
         {
            return true;
         }
         return false;
      }
      
      public function isHeroOpen() : Boolean
      {
         if(heroMap && heroMap.state != 0)
         {
            return true;
         }
         return false;
      }
      
      public function commitSingle(param1:CampaignAreaInfo) : void
      {
         dispatchEvent(new TimeVortexEvent("SINGLE_LAIRD_INFO_CHANGE",param1));
      }
      
      public function commitCrack() : void
      {
         dispatchEvent(new TimeVortexEvent("CRACK_INFO_CHANGE"));
      }
      
      public function commitCrackTeamInfo() : void
      {
         dispatchEvent(new TimeVortexEvent("CRACK_TEAM_INFO_CHANGE"));
      }
      
      public function commitDragonOpenInfo() : void
      {
         dispatchEvent(new TimeVortexEvent("DRAGON_OPEN_INFO"));
      }
      
      public function commit() : void
      {
         dispatchEvent(new TimeVortexEvent("LAIRD_INFO_CHANGE"));
      }
      
      public function commitWaitInfo() : void
      {
         dispatchEvent(new TimeVortexEvent("RECEIVE_WAIT_INFO"));
      }
   }
}

