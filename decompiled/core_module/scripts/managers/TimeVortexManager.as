package managers
{
   import com.netease.protobuf.Message;
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.battle.TimeVortexInfoMsg;
   import com.road.yishi.proto.battle.TimeVortexListMsg;
   import com.road.yishi.proto.dragontalker.DragonTalkerNodeMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.timevortex.TeammatesInfoMsg;
   import com.road.yishi.proto.timevortex.TimeVortexTeamMsg;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.controler.TimeVortexController;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import mvc.module.timevortex.TimeVortexTeamItemInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.frame.TimeOutInviteFrame;
   
   public class TimeVortexManager
   {
      
      private static var _instance:TimeVortexManager;
      
      private var _preLairdDic:Dictionary = new Dictionary(true);
      
      private var _model:TimeVortexModel;
      
      private var vortexsCache:Array = [];
      
      private const LOOK_UP:int = 1;
      
      private const LOOK_UP_SINGLE:int = 2;
      
      private const CHALLENGE_BOSS:int = 3;
      
      private const CHALLENGE_LAIRD:int = 4;
      
      private const CHALLENGE_CRACK:int = 5;
      
      private const LOOK_UP_CRACK_SINGLE:int = 6;
      
      private const LOOK_UP_CRACK:int = 7;
      
      private const TEAM_READY:int = 8;
      
      private const REVENGE_LAIRD:int = 9;
      
      private const DRAGON_CHANGE:int = 10;
      
      public function TimeVortexManager()
      {
         super();
      }
      
      public static function get instance() : TimeVortexManager
      {
         if(!_instance)
         {
            _instance = new TimeVortexManager();
         }
         return _instance;
      }
      
      public function get model() : TimeVortexModel
      {
         if(!_model)
         {
            _model = new TimeVortexModel();
         }
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4837,__timeVortexInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4838,__timeVortexBatchInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4839,__timeVortexCrackInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4840,__timeVortexCrackTeamInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4841,__timeVortexCrackTeamReadyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4842,__dragonOpenInfoHandler);
      }
      
      private function __dragonOpenInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DragonTalkerNodeMsg = new DragonTalkerNodeMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DragonTalkerNodeMsg;
         _model.dragonOpenInfo.dragontalker1 = _loc2_.dragontalker1;
         _model.dragonOpenInfo.dragontalker2 = _loc2_.dragontalker2;
         _model.dragonOpenInfo.dragontalker3 = _loc2_.dragontalker3;
         _model.dragonOpenInfo.dragontalker4 = _loc2_.dragontalker4;
         _model.dragonOpenInfo.dragontalker5 = _loc2_.dragontalker5;
         _model.commitDragonOpenInfo();
      }
      
      private function __timeVortexCrackTeamReadyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:TimeOutInviteFrame = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if((SceneManager.instance.currentType == "SPACE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE") && !MopupManager.instance.model.isMopup)
         {
            if(FreedomTeamManager.instance.hasTeam && FreedomTeamManager.instance.isCaptain)
            {
               _model.commitWaitInfo();
            }
            else
            {
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeOutInviteFrame");
               _loc4_.titleText = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.TeamInviteTitle");
               _loc4_.content = LanguageMgr.GetTranslation("timevortex.TimeVortexCrackFrame.TeamInviteContent");
               _loc4_.confirmCallBack = teamReadyCallBack;
               _loc4_.time = 10;
               _loc4_.show();
            }
         }
      }
      
      private function teamReadyCallBack(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            TimeVortexManager.instance.teamReady();
         }
      }
      
      private function __timeVortexCrackTeamInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:TeammatesInfoMsg = null;
         var _loc5_:TimeVortexTeamItemInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:TimeVortexTeamMsg = new TimeVortexTeamMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as TimeVortexTeamMsg;
         var _loc4_:int = 0;
         var _loc3_:int = int(_loc2_.teamList.length);
         if(_loc2_.teamList && _loc2_.teamList.length > 0)
         {
            model.teamInfo.clear();
            _loc3_ = int(_loc2_.teamList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc7_ = _loc2_.teamList[_loc4_];
               _loc5_ = new TimeVortexTeamItemInfo();
               _loc5_.userId = _loc7_.userId;
               _loc5_.nickName = _loc7_.nickName;
               _loc5_.fightPower = _loc7_.fightPower;
               _loc5_.leftCount = _loc7_.leftCount;
               _loc5_.param1 = _loc7_.param1;
               _loc5_.param2 = _loc7_.param2;
               _loc5_.param3 = _loc7_.param3;
               model.teamInfo.add(_loc5_.userId,_loc5_);
               _loc4_++;
            }
            model.commitCrackTeamInfo();
            if(controller.isOpenCrackFrame)
            {
               return;
            }
            controller.openCrackFrame();
         }
      }
      
      private function get controller() : TimeVortexController
      {
         return FrameControllerManager.instance.timeVortexController;
      }
      
      private function __timeVortexCrackInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:TimeVortexInfoMsg = null;
         var _loc10_:CampaignTemplate = null;
         var _loc5_:CampaignChapterInfo = null;
         var _loc3_:CampaignAreaInfo = null;
         var _loc6_:* = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:TimeVortexListMsg = new TimeVortexListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as TimeVortexListMsg;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         _model.selectedLand.clearChapterCrackDic();
         playerInfo.timeVortexCrack = 0;
         _loc4_ = int(_loc2_.crackList.length);
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc9_ = _loc2_.crackList[_loc7_];
            _loc10_ = TempleteManager.instance.getTimeVortexTemplateById(_loc9_.campaignId);
            _loc5_ = _model.selectedLand.getChapterCrackById(_loc10_.DungeonId);
            _loc3_ = new CampaignAreaInfo();
            _loc3_.areaId = _loc10_.AreaId;
            _loc3_.areaName = _loc10_.CampaignName;
            _loc3_.posX = _loc10_.PosX;
            _loc3_.posY = _loc10_.PosY;
            _loc3_.addMapTemplate(_loc10_);
            _loc3_.campaignId = _loc9_.campaignId;
            _loc3_.userId = _loc9_.userId;
            _loc3_.uuid = _loc9_.uuid;
            _loc3_.nickName = _loc9_.nickName;
            _loc3_.occupyTime = _loc9_.occupyTime;
            _loc3_.param1 = _loc9_.param1;
            _loc3_.param2 = _loc9_.param2;
            _loc3_.param3 = _loc9_.param3;
            if(_loc9_.sexJob > 0)
            {
               _loc3_.thane = readThaneInfo(_loc9_.job,_loc9_.sexJob,_loc9_.fashionArm,_loc9_.fashionWing,_loc9_.fashionCloth,_loc9_.fashionHair,_loc9_.fashionHat,_loc9_.arm);
            }
            if(playerInfo.userId == _loc3_.userId)
            {
               playerInfo.timeVortexCrack = _loc3_.campaignId;
            }
            _loc5_.addAreaInfo(_loc3_);
            _loc7_++;
         }
         _model.commitCrack();
      }
      
      private function __timeVortexBatchInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:TimeVortexListMsg = null;
         var _loc4_:TimeVortexListMsg = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:TimeVortexListMsg = new TimeVortexListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as TimeVortexListMsg;
         if(!_loc2_.hasUuid)
         {
            return;
         }
         var _loc6_:String = _loc2_.uuid;
         if(_loc6_ in vortexsCache)
         {
            _loc3_ = vortexsCache[_loc6_] as TimeVortexListMsg;
            _loc3_.vortexList = _loc2_.vortexList.concat(_loc3_.vortexList);
         }
         else
         {
            vortexsCache[_loc6_] = _loc2_;
            vortexsCache.push(_loc2_);
         }
         while(vortexsCache.length > 0)
         {
            _loc4_ = vortexsCache[0] as TimeVortexListMsg;
            if(_loc4_.vortexList.length != _loc4_.param1)
            {
               break;
            }
            timeVortexInfoHandler(_loc4_);
            vortexsCache.shift();
            delete vortexsCache[_loc4_.uuid];
         }
      }
      
      private function __timeVortexInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TimeVortexListMsg = new TimeVortexListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TimeVortexListMsg;
         timeVortexInfoHandler(_loc2_);
      }
      
      private function timeVortexInfoHandler(param1:TimeVortexListMsg) : void
      {
         var _loc7_:TimeVortexInfoMsg = null;
         var _loc8_:CampaignTemplate = null;
         var _loc4_:CampaignChapterInfo = null;
         var _loc2_:CampaignAreaInfo = null;
         var _loc5_:CampaignAreaInfo = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         playerInfo.timeVortexRevenge = param1.revengeNodeId;
         playerInfo.timeVortexRevengeTime = param1.revengeTime;
         if(param1.vortexList && param1.vortexList.length > 0)
         {
            _loc3_ = int(param1.vortexList.length);
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc7_ = param1.vortexList[_loc6_];
               if(_loc7_.campaignId != 0)
               {
                  _loc8_ = TempleteManager.instance.getTimeVortexTemplateById(_loc7_.campaignId);
                  _loc4_ = _model.selectedLand.getChapterById(_loc8_.DungeonId);
                  _loc2_ = _loc4_.getAreaInfoById(_loc8_.AreaId);
                  _loc2_.campaignId = _loc7_.campaignId;
                  _loc2_.userId = _loc7_.userId;
                  _loc2_.uuid = _loc7_.uuid;
                  _loc2_.nickName = _loc7_.nickName;
                  _loc2_.occupyTime = _loc7_.occupyTime;
                  _loc2_.param1 = _loc7_.param1;
                  _loc2_.param2 = _loc7_.param2;
                  _loc2_.param3 = _loc7_.param3;
                  if(_loc7_.sexJob > 0)
                  {
                     _loc2_.thane = readThaneInfo(_loc7_.job,_loc7_.sexJob,_loc7_.fashionArm,_loc7_.fashionWing,_loc7_.fashionCloth,_loc7_.fashionHair,_loc7_.fashionHat,_loc7_.arm);
                  }
                  if(_loc2_.userId != 0)
                  {
                     _loc5_ = _preLairdDic[_loc2_.uuid];
                     _preLairdDic[_loc2_.uuid] = _loc2_;
                     if(_loc5_ && _loc5_.uuid == _loc2_.uuid)
                     {
                        if(_loc2_.campaignId != _loc5_.campaignId)
                        {
                           _loc5_.userId = 0;
                           _loc5_.uuid = "";
                           _loc5_.nickName = "";
                           _loc5_.occupyTime = "";
                           _loc5_.param1 = "";
                           _loc5_.param2 = "";
                           _loc5_.param3 = "";
                           _loc5_.thane = null;
                           _model.commitSingle(_loc5_);
                        }
                     }
                  }
                  if(playerInfo.timeVortexCapture == _loc2_.campaignId)
                  {
                     if(_loc2_.userId == 0 || playerInfo.userId != _loc2_.userId)
                     {
                        playerInfo.timeVortexCapture = 0;
                     }
                  }
                  else if(playerInfo.userId == _loc2_.userId)
                  {
                     playerInfo.timeVortexCapture = _loc2_.campaignId;
                  }
               }
               _loc6_++;
            }
            if(_loc3_ == 1)
            {
               _model.commitSingle(_loc2_);
            }
            else
            {
               _model.commit();
            }
         }
      }
      
      private function readThaneInfo(param1:int, param2:int, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String) : ThaneInfo
      {
         var _loc9_:ThaneInfo = new ThaneInfo();
         if(param1 != 0)
         {
            _loc9_.job = param1;
         }
         if(param2 != 0)
         {
            _loc9_.templateId = param2;
         }
         if(param6)
         {
            _loc9_.hairFashionAvata = param6;
         }
         if(param7)
         {
            _loc9_.cloakAvata = param7;
         }
         if(param4)
         {
            _loc9_.wingAvata = param4;
         }
         if(param3)
         {
            if(param3.indexOf("fashion") > -1)
            {
               _loc9_.armsFashionAvata = param3;
            }
            else if(param8)
            {
               _loc9_.armsEquipAvata = param8;
            }
         }
         if(param5)
         {
            if(param5.indexOf("fashion") > -1)
            {
               _loc9_.bodyFashionAvata = param5;
            }
            else
            {
               _loc9_.bodyEquipAvata = param5;
            }
         }
         return _loc9_;
      }
      
      private function getTemplateId(param1:Array) : int
      {
         var _loc2_:int = 0;
         if(param1 && param1[0])
         {
            _loc2_ = int(param1[0]);
         }
         return _loc2_;
      }
      
      private function getAvatar(param1:Array, param2:int = 1) : String
      {
         var _loc3_:String = null;
         if(param1 && param1[param2])
         {
            _loc3_ = String(param1[param2]);
         }
         return _loc3_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function lookUp() : void
      {
         var _loc2_:PackageOut = new PackageOut(9664);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 1;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function lookUpSingle(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9664);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 2;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function challengeBoss(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9664);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 3;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function challengeLaird(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9664);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 4;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function revengeLaird(param1:int, param2:Boolean = false, param3:Boolean = true) : void
      {
         var _loc6_:PackageOut = new PackageOut(9664);
         var _loc4_:PropertyMsg = new PropertyMsg();
         _loc4_.param1 = 9;
         _loc4_.param2 = param1;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         if(param2)
         {
            _loc5_ = 1;
         }
         if(param3)
         {
            _loc7_ = 1;
         }
         _loc4_.param3 = _loc5_;
         _loc4_.param10 = _loc7_;
         sendProtoBuffer(_loc6_,_loc4_);
      }
      
      public function challengeCrack(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9664);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 5;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function lookUpCrackSingle(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9664);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 6;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function lookUpCrack() : void
      {
         var _loc2_:PackageOut = new PackageOut(9664);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 7;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function teamReady() : void
      {
         var _loc2_:PackageOut = new PackageOut(9664);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param1 = 8;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function changeDragonIndex(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9664);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = 10;
         _loc2_.param2 = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketSendManager.instance.sendProtoBuffer(param1,param2);
      }
   }
}

