package mvc.module.crossguild
{
   import flash.events.EventDispatcher;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class CrossGuildModel extends EventDispatcher
   {
      
      public static const RANK_REWARD_TEMPID:int = -3600;
      
      public static const NEW_CROSS_GUILD_COIN_TEMPID:int = -2900;
      
      public static const SIZE_NUM_1:int = 12;
      
      public static const GUILD_SKILL_MASTERTYPE:int = 308;
      
      public static const MEMBER_SKILL_MASTERTYPE:int = 309;
      
      public static const TROUBLE_TYPE_NUM:int = 6;
      
      public static const RANK_TEMP4_DAYS:Array = [7,5,3];
      
      public var state:int;
      
      public var openTime:Date;
      
      public var endTime:Date;
      
      public var signStartTime:Date;
      
      public var signEndTime:Date;
      
      public var signType:int;
      
      public var season:int;
      
      public var isBye:Boolean;
      
      public var fightIndex:int;
      
      public var isValid:Boolean;
      
      public var isInCrossGuildWar:Boolean;
      
      public var firstGuild:CrossGuildData;
      
      public var selfGuild:CrossGuildData;
      
      public var vsGuild:CrossGuildData;
      
      public var selfGuildBufferId:int;
      
      public var guildRankList:Array;
      
      public var selfBufferList:Array;
      
      public var attackContributionList:Array;
      
      public var defendMemberList:Array;
      
      public var guildSkillTempAry:Array;
      
      public var memberSkillTempAry:Array;
      
      public var guildRankUUID:String = "";
      
      public var crossGuildBufferEndDate:Date;
      
      public var myTeamId:int;
      
      public var curSpirit:int;
      
      private var _maxSpirit:int;
      
      public var buySpiritCount:int;
      
      public var maxBuySpiritCount:int;
      
      public var buySpiritCost:int;
      
      public var myTeam:CrossGuildWarTeamInfo;
      
      public var vsTeam:CrossGuildWarTeamInfo;
      
      public var myFightRecordList:Array;
      
      public var vsFightRecordList:Array;
      
      public var bufferCount:int;
      
      public var attackConfigAry:Array;
      
      public var consortiaWarFightStartHours:int;
      
      public var consortiaWarFightEndHours:int;
      
      public var consortiaWarFightStartMin:int;
      
      public var consortiaWarFightEndMin:int;
      
      public var consortiaWarFightOpenStr:String;
      
      public var consortiaWarFightEndStr:String;
      
      public function CrossGuildModel()
      {
         super();
         guildRankList = [];
         attackContributionList = [];
         defendMemberList = [];
         myFightRecordList = [];
         vsFightRecordList = [];
         selfGuild = new CrossGuildData();
         guildSkillTempAry = TempleteManager.instance.getSkillsByMasterType(308);
         memberSkillTempAry = TempleteManager.instance.getSkillsByMasterType(309);
         guildSkillTempAry.sortOn("TemplateId",16);
         memberSkillTempAry.sortOn("TemplateId",16);
         var _loc1_:Array = ConfigInfoManager.instance.getCrossGuildSpiritConfig();
         maxBuySpiritCount = _loc1_[1];
         buySpiritCost = _loc1_[2];
         attackConfigAry = ConfigInfoManager.instance.getCrossGuildAttackConfig();
         consortiaWarFightStartHours = int(ConfigInfoManager.instance.getConsortiaWarightTime().split(",")[0].split(":")[0]);
         consortiaWarFightStartMin = int(ConfigInfoManager.instance.getConsortiaWarightTime().split(",")[0].split(":")[1]);
         consortiaWarFightEndHours = int(ConfigInfoManager.instance.getConsortiaWarightTime().split(",")[1].split(":")[0]);
         consortiaWarFightEndMin = int(ConfigInfoManager.instance.getConsortiaWarightTime().split(",")[1].split(":")[1]);
         consortiaWarFightOpenStr = ConfigInfoManager.instance.getConsortiaWarightTime().split(",")[0];
         consortiaWarFightEndStr = ConfigInfoManager.instance.getConsortiaWarightTime().split(",")[1];
      }
      
      public function get maxSpirit() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.getCrossGuildSpiritConfig();
         if(playerModel.playerInfo.isChangeJob)
         {
            return _loc1_[0];
         }
         if(playerModel.playerInfo.vocationGrades > 0)
         {
            return _loc1_[3];
         }
         return _loc1_[4];
      }
      
      public function getMemberDataByBufferId(param1:int) : CrossGuildMemberInfo
      {
         for each(var _loc2_:CrossGuildMemberInfo in defendMemberList)
         {
            if(_loc2_.bufferId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getIsInDefend(param1:int) : Boolean
      {
         for each(var _loc2_:CrossGuildMemberInfo in defendMemberList)
         {
            if(_loc2_.userId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get defendNum() : int
      {
         if(signType == 1)
         {
            return 12;
         }
         return 0;
      }
      
      public function get guildShowBufferId() : int
      {
         if(selfGuildBufferId != 0)
         {
            return selfGuildBufferId;
         }
         if(guildSkillTempAry.length > 0)
         {
            return guildSkillTempAry[0].TemplateId;
         }
         return 0;
      }
      
      public function get greenTeamInfo() : CrossGuildWarTeamInfo
      {
         return myTeamId == 0 ? vsTeam : myTeam;
      }
      
      public function get redTeamInfo() : CrossGuildWarTeamInfo
      {
         return myTeamId == 0 ? myTeam : vsTeam;
      }
      
      public function getGuildBufferId(param1:CrossGuildTowerInfo) : int
      {
         if(param1.teamId == myTeamId && myTeam)
         {
            return myTeam.guildBufferId;
         }
         return vsTeam.guildBufferId;
      }
      
      public function get crossGuildBufferLeftTime() : Number
      {
         if(crossGuildBufferEndDate)
         {
            return crossGuildBufferEndDate.time / 1000 - playerModel.sysSecond;
         }
         return 0;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get memerShowBuffer() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:SkillTempInfo = null;
         var _loc1_:Array = [];
         if(selfBufferList && selfBufferList.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < selfBufferList.length)
            {
               _loc3_ = TempleteManager.instance.skillTemplateDic[selfBufferList[_loc2_]];
               _loc1_.push(_loc3_);
               _loc2_++;
            }
            _loc1_.sortOn("TemplateId",16);
            return _loc1_;
         }
         return memberSkillTempAry;
      }
      
      public function checkClearData() : void
      {
         signType = 0;
         isBye = false;
         selfGuild = null;
         vsGuild = null;
         selfGuildBufferId = 0;
         guildRankList = [];
         selfBufferList = [];
         attackContributionList = [];
         defendMemberList = [];
         guildRankUUID = "";
         myTeam = null;
         vsTeam = null;
         myFightRecordList = [];
         vsFightRecordList = [];
      }
   }
}

