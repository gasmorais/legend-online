package managers
{
   import com.road.yishi.proto.campaign.WarFightFlagEndTimeMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.team.InviteTeamMsg;
   import com.road.yishi.proto.team.MemberFightPosListMsg;
   import com.road.yishi.proto.team.TeamInfoMsg;
   import com.road.yishi.proto.team.TeamPlayerInfoMsg;
   import events.FreedomTeamEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.SvsUserInfo;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.team.FreedomTeamModel;
   import yishi.actions.team.FreedomTeamApplyAction;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.PopFrameCheck;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   
   public class FreedomTeamManager
   {
      
      private static var _instance:FreedomTeamManager;
      
      private var _model:FreedomTeamModel;
      
      public function FreedomTeamManager()
      {
         super();
      }
      
      public static function get instance() : FreedomTeamManager
      {
         if(!_instance)
         {
            _instance = new FreedomTeamManager();
         }
         return _instance;
      }
      
      public function get model() : FreedomTeamModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.listener(4622,__teamCreateHandler);
         SocketManager.instance.listener(4625,__teamDismissHandler);
         SocketManager.instance.listener(4626,__teamAddMemberHandler);
         SocketManager.instance.listener(4624,__teamPlayerInfoHandler);
         SocketManager.instance.listener(4620,__teamInviteHandler);
         SocketManager.instance.listener(4621,__teamAFKHandler);
         SocketManager.instance.listener(4627,__teamCaptainChangeHandler);
         SocketManager.instance.listener(4629,__teamMemberLeftHandler);
         SocketManager.instance.listener(4630,__teamKickMemberHandler);
         SocketManager.instance.listener(4628,__teamFightPosChangeHandler);
         SocketManager.instance.listener(4220,__timeendtimeCreateHandler);
      }
      
      private function __timeendtimeCreateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:WarFightFlagEndTimeMsg = new WarFightFlagEndTimeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as WarFightFlagEndTimeMsg;
         CampaignManager.instance.pvpWarFightModel.time = _loc2_.endTime;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_TIMEENDFLAG",_loc2_.endTime));
      }
      
      private function __teamCreateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TeamInfoMsg = new TeamInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TeamInfoMsg;
         if(_model)
         {
            _model.dispose();
         }
         _model = new FreedomTeamModel();
         if(_loc2_.hasCaptainId)
         {
            _model.captainId = _loc2_.captainId;
         }
         if(_loc2_.hasCaptainServerName)
         {
            _model.captainServerName = _loc2_.captainServerName;
         }
         _model.memberId = _loc2_.memberId;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.memberDetail.length)
         {
            readMember(_loc2_.memberDetail[_loc3_] as TeamPlayerInfoMsg);
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",null));
      }
      
      private function __teamDismissHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         if(_model)
         {
            _model.dispose();
            _model = null;
            NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",null));
      }
      
      private function __teamAddMemberHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TeamInfoMsg = new TeamInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TeamInfoMsg;
         if(!_model)
         {
            _model = new FreedomTeamModel();
         }
         if(_loc2_.hasCaptainId)
         {
            _model.captainId = _loc2_.captainId;
         }
         if(_loc2_.hasCaptainServerName)
         {
            _model.captainServerName = _loc2_.captainServerName;
         }
         _model.memberId = _loc2_.memberId;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.memberDetail.length)
         {
            readMember(_loc2_.memberDetail[_loc3_] as TeamPlayerInfoMsg);
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",null));
      }
      
      private function __teamPlayerInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         if(!_model)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:TeamInfoMsg = new TeamInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as TeamInfoMsg;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.memberDetail.length)
         {
            readMember(_loc2_.memberDetail[_loc3_] as TeamPlayerInfoMsg);
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_SYNC",null));
      }
      
      private function __teamInviteHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:InviteTeamMsg = new InviteTeamMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as InviteTeamMsg;
         var _loc3_:ThaneInfo = FriendManager.getInstance().friendList[_loc2_.inviterId];
         if(_loc3_ && _loc3_.relation == 2)
         {
            return;
         }
         if(checkScene())
         {
            _loc5_ = LanguageMgr.GetTranslation("managers.FreedomTeamManager.teamInviteTxt",_loc2_.inviterName);
            PopFrameCheck.instance.addAction(new FreedomTeamApplyAction(_loc2_.inviterId,_loc2_.inviterServerName,_loc5_));
         }
      }
      
      private function get isCrossAllowTeam() : Boolean
      {
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc1_)
         {
            if(WorldBossHelper.checkSvs(_loc1_.mapId))
            {
               return true;
            }
         }
         return false;
      }
      
      public function inviteMember(param1:int, param2:String = "") : void
      {
         if(checkScene(true))
         {
            if(isCrossAllowTeam)
            {
               if(StringHelper.isNullOrEmpty(param2))
               {
                  param2 = searchServerNameByUserId(param1);
               }
               FreedomTeamSocketOutManager.sendInviteCross(param1,param2);
            }
            else
            {
               FreedomTeamSocketOutManager.sendInvite(param1);
            }
         }
      }
      
      private function searchServerNameByUserId(param1:int) : String
      {
         var _loc2_:SvsUserInfo = null;
         var _loc3_:String = "";
         if(FrameControllerManager.instance.svsController && FrameControllerManager.instance.svsController.userDic)
         {
            _loc2_ = FrameControllerManager.instance.svsController.userDic[param1] as SvsUserInfo;
            if(_loc2_)
            {
               _loc3_ = _loc2_.serverName;
            }
         }
         return _loc3_;
      }
      
      public function changeCaptain(param1:int, param2:String = "") : void
      {
         if(isCrossAllowTeam)
         {
            FreedomTeamSocketOutManager.sendChangeCaptainCross(param1,param2);
         }
         else
         {
            FreedomTeamSocketOutManager.sendChangeCaptain(param1);
         }
      }
      
      public function kickMember(param1:int, param2:String = "") : void
      {
         if(isCrossAllowTeam)
         {
            FreedomTeamSocketOutManager.sendKickMemberCross(param1,param2);
         }
         else
         {
            FreedomTeamSocketOutManager.sendKickMember(param1);
         }
      }
      
      public function quit() : void
      {
         if(isCrossAllowTeam)
         {
            FreedomTeamSocketOutManager.sendQuikCross();
         }
         else
         {
            FreedomTeamSocketOutManager.sendQuik();
         }
      }
      
      public function editTeamFightPos(param1:Boolean = true, param2:Array = null) : void
      {
         if(isCrossAllowTeam)
         {
            FreedomTeamSocketOutManager.sendEditTeamFightPosCross(param1,param2);
         }
         else
         {
            FreedomTeamSocketOutManager.sendEditTeamFightPos(param1,param2);
         }
      }
      
      public function applyInvite(param1:int, param2:Boolean, param3:String = "") : void
      {
         if(isCrossAllowTeam)
         {
            FreedomTeamSocketOutManager.sendApplyInviteCross(param1,param2,param3);
         }
         else
         {
            FreedomTeamSocketOutManager.sendApplyInvite(param1,param2);
         }
      }
      
      public function joinTeam(param1:int) : void
      {
         if(checkScene(true))
         {
            FreedomTeamSocketOutManager.sendJoinTeam(param1);
         }
      }
      
      public function joinTeamOp(param1:int, param2:int = 0) : void
      {
         if(checkScene(true))
         {
            FreedomTeamSocketOutManager.sendJoinTeamReply(param1,param2);
         }
      }
      
      private function checkScene(param1:Boolean = false) : Boolean
      {
         var _loc2_:String = SceneManager.instance.currentType;
         switch(_loc2_)
         {
            case "SECRET_ADVENTURE_SCENE":
            case "THESE_PVP_SCENE":
            case "SECRET_WAR_SCENE":
            case "CHILD_NS_WAR_SCENE":
               break;
            default:
               if(BraveLegManager.instance.hasTeam())
               {
                  return false;
               }
               if(EclipticPalaceManager.instance.model.openEclipticPalaceFrame)
               {
                  return false;
               }
               if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
               {
                  return false;
               }
               return true;
         }
         return false;
      }
      
      private function __teamAFKHandler(param1:SLGSocketEvent) : void
      {
         if(!_model)
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
      }
      
      private function __teamCaptainChangeHandler(param1:SLGSocketEvent) : void
      {
         if(!_model)
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         _model.captainId = _loc2_.param1;
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
      }
      
      private function __teamMemberLeftHandler(param1:SLGSocketEvent) : void
      {
         if(!_model)
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         removeMemberByUserId(_loc2_.param1);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",null));
      }
      
      private function __teamKickMemberHandler(param1:SLGSocketEvent) : void
      {
         if(!_model)
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         removeMemberByUserId(_loc2_.param1);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_OTHERS",null));
      }
      
      private function removeMemberByUserId(param1:int) : void
      {
         if(param1 == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            if(_model)
            {
               _model.dispose();
               _model = null;
            }
         }
         else
         {
            _model.removeMemberByUserId(param1);
         }
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
      }
      
      private function __teamFightPosChangeHandler(param1:SLGSocketEvent) : void
      {
         if(!_model)
         {
            return;
         }
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MemberFightPosListMsg = new MemberFightPosListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MemberFightPosListMsg;
         _model.memberFightPos = _loc2_.memberPos;
         NotificationManager.instance.dispatchEvent(new FreedomTeamEvent("TEAM_INFO_UPDATE",null));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function readMember(param1:TeamPlayerInfoMsg) : void
      {
         var _loc3_:ThaneInfo = null;
         var _loc2_:BaseArmy = _model.getMemberByUserId(param1.playerId);
         if(!_loc2_)
         {
            _loc2_ = new BaseArmy();
         }
         var _loc4_:Boolean = false;
         if(param1.playerId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            _loc4_ = true;
            _loc3_ = thane;
            _loc2_.baseHero = _loc3_;
         }
         else
         {
            _loc3_ = _loc2_.baseHero;
         }
         if(param1.hasHeroId)
         {
            _loc3_.id = param1.heroId;
         }
         if(param1.hasPlayerId)
         {
            _loc3_.userId = param1.playerId;
         }
         if(param1.hasIsVip)
         {
            _loc3_.IsVipAndNoExpirt = param1.isVip;
         }
         if(param1.hasVipType)
         {
            _loc3_.vipType = param1.vipType;
         }
         if(param1.hasGrades)
         {
            _loc3_.grades = param1.grades;
         }
         if(param1.hasNickName)
         {
            _loc3_.nickName = param1.nickName;
         }
         if(param1.hasServerName)
         {
            _loc3_.serviceName = param1.serverName;
         }
         if(param1.hasTemplateId && !_loc4_)
         {
            _loc3_.templateId = param1.templateId;
         }
         if(param1.hasHeadId)
         {
            _loc3_.headId = param1.headId;
         }
         if(param1.hasArm)
         {
            _loc3_.armsEquipAvata = param1.arm;
         }
         if(param1.hasCloth)
         {
            _loc3_.bodyEquipAvata = param1.cloth;
         }
         if(param1.hasWing)
         {
            _loc3_.wingAvata = param1.wing;
         }
         if(param1.hasHat)
         {
            _loc3_.hairFashionAvata = param1.hat;
         }
         if(param1.hasFashionArm)
         {
            _loc3_.armsFashionAvata = param1.fashionArm;
         }
         if(param1.hasFashionCloth)
         {
            _loc3_.bodyFashionAvata = param1.fashionCloth;
         }
         if(param1.hasHide)
         {
            _loc3_.hideFashion = param1.hide;
         }
         if(param1.hasChangeShapeId)
         {
            _loc3_.changeShapeId = param1.changeShapeId;
         }
         if(param1.hasOnlineState)
         {
            _loc3_.state = param1.onlineState ? 7 : 0;
         }
         if(param1.hasGeste)
         {
            _loc3_.honer = param1.geste;
         }
         if(param1.hasAppellid)
         {
            _loc3_.appellId = param1.appellid;
         }
         if(param1.hasAvengerGrade)
         {
            _loc3_.avengerGrade = param1.avengerGrade;
         }
         if(param1.hasVehicleTemplateId)
         {
            _loc3_.vehicleTempId = param1.vehicleTemplateId;
         }
         if(param1.hasPetName)
         {
            _loc2_.petInfo.petName = param1.petName;
            _loc3_.petName = param1.petName;
         }
         if(param1.hasPetQuqlity)
         {
            if(param1.petQuqlity < 26)
            {
               _loc2_.petInfo.petQuaity = (param1.petQuqlity - 1) / 5 + 1;
               _loc3_.petQuaity = (param1.petQuqlity - 1) / 5 + 1;
            }
            else
            {
               _loc2_.petInfo.petQuaity = (param1.petQuqlity - 1) / 5;
               _loc3_.petQuaity = (param1.petQuqlity - 1) / 5;
            }
            _loc2_.petInfo.petTemQuality = param1.petQuqlity;
            _loc3_.temQuality = param1.petQuqlity;
         }
         if(param1.hasPetTemplateId)
         {
            _loc2_.petInfo.petTemplateId = param1.petTemplateId;
            _loc3_.petTemplateId = param1.petTemplateId;
         }
         if(param1.hasChildName)
         {
            _loc2_.childrenInfo.childrenName = param1.childName;
            _loc3_.childrenName = param1.childName;
         }
         if(param1.hasChildJob)
         {
            _loc2_.childrenInfo.childrenJob = param1.childJob;
            _loc3_.childrenJob = param1.childJob;
         }
         if(param1.hasChildSex)
         {
            _loc2_.childrenInfo.childrenSex = param1.childSex;
            _loc3_.childrenSex = param1.childSex;
         }
         if(param1.hasGrowthGrade)
         {
            _loc2_.childrenInfo.childrenGrade = param1.growthGrade;
            _loc3_.childrenGrade = param1.growthGrade;
         }
         if(param1.hasConsortiaId)
         {
            _loc3_.consortiaID = param1.consortiaId;
         }
         if(param1.hasConsortiaName)
         {
            _loc3_.consortiaName = param1.consortiaName;
         }
         if(param1.hasFightingCapacity)
         {
            _loc3_.fightingCapacity = param1.fightingCapacity;
         }
         if(param1.hasIsBackPlayer)
         {
            _loc3_.isBackPlayer = param1.isBackPlayer;
         }
         if(param1.hasPlayerId)
         {
            _loc2_.userId = param1.playerId;
         }
         if(param1.hasArmyId)
         {
            _loc2_.id = param1.armyId;
         }
         if(param1.hasCurPosX)
         {
            _loc2_.curPosX = param1.curPosX;
         }
         if(param1.hasCurPosY)
         {
            _loc2_.curPosY = param1.curPosY;
         }
         if(param1.hasCampaignId)
         {
            _loc2_.mapId = param1.campaignId;
         }
         if(param1.hasNickName)
         {
            _loc2_.nickName = param1.nickName;
         }
         if(param1.hasMountTempId)
         {
            _loc2_.mountTemplateId = param1.mountTempId;
         }
         if(param1.hasMountGrade)
         {
            _loc2_.mountGrade = param1.mountGrade;
         }
         if(param1.hasFightingCapacity)
         {
            _model.memberFightCapacity[param1.playerId] = param1.fightingCapacity;
         }
         if(param1.hasOnlineState)
         {
            _model.memberState[param1.playerId] = param1.onlineState;
         }
         _model.addMember(_loc2_);
         _loc2_.petInfo.commit();
      }
      
      public function memeberGradesValid(param1:int) : Boolean
      {
         if(hasTeam)
         {
            for each(var _loc2_:BaseArmy in _model.allMembers)
            {
               if(_loc2_.baseHero.grades < param1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function get hasBackPlayer() : Boolean
      {
         if(hasTeam)
         {
            for each(var _loc1_:BaseArmy in _model.allMembers)
            {
               if(_loc1_.baseHero.isBackPlayer)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get isCaptain() : Boolean
      {
         if(hasTeam && _model.captainId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            return true;
         }
         return false;
      }
      
      public function get hasTeam() : Boolean
      {
         if(_model)
         {
            return true;
         }
         return false;
      }
      
      public function get isMarryTeam() : Boolean
      {
         if(hasTeam && _model.memberId.length == 2 && _model.memberId.indexOf(MarryManager.instance.model.selfMarryInfo.userId) != -1)
         {
            return true;
         }
         return false;
      }
      
      public function get showTeam() : Boolean
      {
         var _loc1_:int = 0;
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            if(CampaignManager.instance.mapModel)
            {
               _loc1_ = CampaignManager.instance.mapModel.mapId;
               if(WorldBossHelper.checkPetLand(_loc1_) || WorldBossHelper.checkMineral(_loc1_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function memberIsOnline(param1:int) : Boolean
      {
         if(hasTeam && _model.memberState[param1])
         {
            return _model.memberState[param1];
         }
         return false;
      }
      
      public function getTeamNum() : int
      {
         if(hasTeam)
         {
            return _model.memberId.length;
         }
         if(WorldBossHelper.checkRapidMap(CampaignManager.instance.mapId))
         {
            return 1;
         }
         return 0;
      }
      
      public function memberFightCapacity(param1:int) : int
      {
         if(hasTeam && _model.memberFightCapacity[param1])
         {
            return _model.memberFightCapacity[param1];
         }
         return 0;
      }
      
      public function canInviteMember(param1:int, param2:int) : Boolean
      {
         if(isCrossAllowTeam)
         {
            if(hasTeam && inMyTeam(param1))
            {
               return false;
            }
         }
         else
         {
            if(param2 < 36)
            {
               return false;
            }
            if(ArmyManager.instance.thane.grades < 36)
            {
               return false;
            }
            if(hasTeam && inMyTeam(param1))
            {
               return false;
            }
            if(WorldBossHelper.checkMarket(CampaignManager.instance.mapId))
            {
               return false;
            }
         }
         return true;
      }
      
      public function inMyTeam(param1:int) : Boolean
      {
         if(hasTeam)
         {
            if(_model.memberId.indexOf(param1) < 0)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function get teamIsFull() : Boolean
      {
         if(hasTeam)
         {
            if(_model.memberId.length < 4)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function getTransferMapping(param1:String) : int
      {
         if(hasTeam)
         {
            if(_model.transferMapping[param1])
            {
               return _model.transferMapping[param1];
            }
         }
         return 0;
      }
   }
}

