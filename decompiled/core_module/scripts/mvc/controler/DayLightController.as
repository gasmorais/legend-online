package mvc.controler
{
   import com.road.yishi.proto.daylight.DayLightModelInfoMsg;
   import com.road.yishi.proto.daylight.DayLightModelListMsg;
   import com.road.yishi.proto.daylight.DayLightSandBoxInfoMsg;
   import com.road.yishi.proto.daylight.DayLightTeamInfoMsg;
   import com.road.yishi.proto.daylight.DayLightUserInfoMsg;
   import com.road.yishi.proto.daylight.DayLightUserRankMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import sandbox.daylight.DayLightModel;
   import sandbox.daylight.data.DayLightTeamInfo;
   import sandbox.daylight.data.DayLightUnitInfo;
   import sandbox.daylight.data.DayLightUserInfo;
   import yishi.SwitchPageHelp;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DelayActionsUtils;
   
   public class DayLightController extends FrameController
   {
      
      public static const RANK_LIST:int = 1;
      
      public static const GAMEOVER_REPORT:int = 2;
      
      private var _model:DayLightModel;
      
      public function DayLightController()
      {
         super();
         _model = new DayLightModel();
         addEvent();
      }
      
      public function get model() : DayLightModel
      {
         return _model;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "daylight.DayLightRankListFrame";
            case 2:
               return "daylight.DayLightGameOverFrame";
            default:
               return "daylight.DayLightRankListFrame";
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4851,__userInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4852,__userRankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4853,__sandboxInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4854,__modelInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4857,__useSkillHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4855,__resultHandler);
      }
      
      private function __userInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DayLightUserInfoMsg = new DayLightUserInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DayLightUserInfoMsg;
         model.selfInfo = readUserInfo(_loc2_);
         model.updateSelfUserInfo();
      }
      
      private function __userRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:DayLightUserInfo = null;
         var _loc6_:* = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:DayLightUserRankMsg = new DayLightUserRankMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as DayLightUserRankMsg;
         var _loc4_:Vector.<DayLightUserInfo> = new Vector.<DayLightUserInfo>();
         for each(_loc6_ in _loc2_.rankList)
         {
            _loc3_ = readUserInfo(_loc6_);
            _loc4_.push(_loc3_);
         }
         model.userRankList = _loc4_;
         model.updateUserInfoRankList();
      }
      
      private function __sandboxInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DayLightSandBoxInfoMsg = new DayLightSandBoxInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DayLightSandBoxInfoMsg;
         model.fightBeginCd = _loc2_.fightBeginCd;
         model.fightEndCd = _loc2_.fightEndCd;
         model.blueTeamInfo = readTeamInfo(_loc2_.blueTeam);
         model.redTeamInfo = readTeamInfo(_loc2_.redTeam);
         model.commit();
      }
      
      private function __modelInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:DayLightUnitInfo = null;
         var _loc4_:* = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:DayLightModelListMsg = new DayLightModelListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as DayLightModelListMsg;
         var _loc7_:Vector.<DayLightUnitInfo> = new Vector.<DayLightUnitInfo>();
         var _loc3_:Vector.<DayLightUnitInfo> = new Vector.<DayLightUnitInfo>();
         for each(_loc4_ in _loc2_.blueModelList)
         {
            _loc5_ = readUnitInfo(_loc4_);
            _loc7_.push(_loc5_);
         }
         for each(_loc4_ in _loc2_.redModelList)
         {
            _loc5_ = readUnitInfo(_loc4_);
            _loc3_.push(_loc5_);
         }
         model.blueUnitList = _loc7_;
         model.redUnitList = _loc3_;
         model.updateUnitInfoList();
      }
      
      private function __useSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         model.skillUseTeam = _loc2_.param1;
         model.skillUseId = _loc2_.param2;
         model.updateSkillUseResult();
      }
      
      private function __resultHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = SwitchPageHelp.returnScene;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,resultCallBack);
      }
      
      private function resultCallBack(param1:PackageIn) : void
      {
         var _loc3_:DayLightUserInfo = null;
         var _loc5_:* = null;
         var _loc2_:DayLightUserRankMsg = new DayLightUserRankMsg();
         _loc2_ = param1.readBody(_loc2_) as DayLightUserRankMsg;
         var _loc4_:Vector.<DayLightUserInfo> = new Vector.<DayLightUserInfo>();
         for each(_loc5_ in _loc2_.rankList)
         {
            _loc3_ = readUserInfo(_loc5_);
            _loc4_.push(_loc3_);
         }
         model.winTeam = _loc2_.winTeam;
         model.resultRankList = _loc4_;
         DelayActionsUtils.instance.addAction(new AlertTipAction(null,activeOverReport,"SPACE_SCENE"));
      }
      
      private function activeOverReport(param1:Object = null) : void
      {
         FrameControllerManager.instance.openControllerByInfo("daylight",2);
      }
      
      private function readUserInfo(param1:DayLightUserInfoMsg) : DayLightUserInfo
      {
         var _loc2_:DayLightUserInfo = new DayLightUserInfo();
         _loc2_.uuid = param1.uuid;
         _loc2_.userId = param1.userId;
         _loc2_.serverName = param1.serverName;
         _loc2_.nickName = param1.nickName;
         _loc2_.isViceHero = param1.isViceHero;
         _loc2_.isVip = param1.isVip;
         _loc2_.fightPower = param1.fightPower;
         _loc2_.team = param1.team;
         _loc2_.state = param1.state;
         _loc2_.score = param1.score;
         _loc2_.honor = param1.honor;
         _loc2_.reviveCd = param1.reviveCd;
         _loc2_.repelCount = param1.repelCount;
         _loc2_.remainCount = param1.remainCount;
         _loc2_.skills = param1.skills;
         _loc2_.order = param1.order;
         _loc2_.isReward = param1.isReward;
         return _loc2_;
      }
      
      private function readUnitInfo(param1:DayLightModelInfoMsg) : DayLightUnitInfo
      {
         var _loc2_:DayLightUnitInfo = new DayLightUnitInfo();
         _loc2_.id = param1.id;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.type = param1.type;
         _loc2_.count = param1.count;
         _loc2_.speed = param1.speed;
         _loc2_.state = param1.state;
         _loc2_.isFight = param1.isFight;
         return _loc2_;
      }
      
      private function readTeamInfo(param1:DayLightTeamInfoMsg) : DayLightTeamInfo
      {
         var _loc2_:DayLightTeamInfo = new DayLightTeamInfo();
         _loc2_.teamCount = param1.teamCount;
         _loc2_.teamScore = param1.teamScore;
         _loc2_.defendCount = param1.defendCount;
         _loc2_.blessCount = param1.blessCount;
         _loc2_.towerHp = param1.towerHp;
         _loc2_.towerMaxHp = param1.towerMaxHp;
         _loc2_.leftNpcCount = param1.leftNpcCount;
         _loc2_.createNpcCd = param1.createNpcCd;
         _loc2_.assaultCount = param1.assaultCount;
         _loc2_.consortiaName = param1.consortiaName;
         return _loc2_;
      }
   }
}

