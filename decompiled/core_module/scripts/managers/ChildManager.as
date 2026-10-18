package managers
{
   import battle.utils.Int64Utils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.road.yishi.proto.children.ChildCollectInfoMsg;
   import com.road.yishi.proto.children.ChildrenApplyMsg;
   import com.road.yishi.proto.children.ChildrenMsg;
   import com.road.yishi.proto.children.ConfirmMsg;
   import com.road.yishi.proto.children.EmblemMsg;
   import com.road.yishi.proto.children.PlayerChildMsg;
   import com.road.yishi.proto.children.PlayerSpiritInfoMsg;
   import com.road.yishi.proto.children.SpiritInfoMsg;
   import com.road.yishi.proto.guardpve.GuardPVERspMsg;
   import com.road.yishi.proto.guardpvp.GuardPvpInfoMsg;
   import com.road.yishi.proto.guardpvp.GuardPvpListMsg;
   import com.road.yishi.proto.guardpvp.GuardPvpPosMsg;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildArenaPlayerInfo;
   import mvc.module.children.ChildCollectInfo;
   import mvc.module.children.ChildCommonFormationInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildPveModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.EmblemInfo;
   import mvc.module.children.NursingSpiritInfo;
   import mvc.module.marry.MarrySender;
   import ui.maintoolbar.MainToolBar;
   import ui.tasktracebar.view.ChildRemoveAlert;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.cate.ChildPveBossTemplateCate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.ChildSexFrame;
   import yishi.view.frame.InviteFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildManager
   {
      
      private static var _instance:ChildManager;
      
      public static const CHILD_ATTRIBUTE_PAGE:String = "CHILD_ATTRIBUTE_PAGE";
      
      public static const CHILD_EQUIP_PAGE:String = "CHILD_EQUIP_PAGE";
      
      public static const CHILD_SKILL_PAGE:String = "CHILD_SKILL_PAGE";
      
      public static const CHILD_BADGE_PAGE:String = "CHILD_BADGE_PAGE";
      
      public static const CHILD_HANDBOOK_PAGE:String = "CHILD_HANDBOOK_PAGE";
      
      public static const CHILD_MOST_PAGE:String = "CHILD_MOST_PAGE";
      
      public static const CHILDEQUIPUPGRADEVIEW:String = "CHILDEQUIPUPGRADEVIEW";
      
      public static const CHILDEQUIPREFRESHVIEW:String = "CHILDEQUIPREFRESHVIEW";
      
      public static const CHILDEQUIPINSERTVIEW:String = "CHILDEQUIPINSERTVIEW";
      
      public var currSelectedPage:String = "";
      
      public var currSelectedView:String = "";
      
      public var openFrame:int = 1;
      
      private var firstLoad:Boolean = true;
      
      private var _model:ChildModel;
      
      private var _nsModel:ChildNursingSpiritModel;
      
      private var _arenaModel:ChildArenaModel;
      
      private var _delay:uint;
      
      public var frameShowType:int;
      
      public function ChildManager()
      {
         super();
         if(_model == null)
         {
            _model = new ChildModel();
         }
         if(_nsModel == null)
         {
            _nsModel = new ChildNursingSpiritModel();
         }
         if(_arenaModel == null)
         {
            _arenaModel = new ChildArenaModel();
         }
      }
      
      public static function get instance() : ChildManager
      {
         if(!_instance)
         {
            _instance = new ChildManager();
         }
         return _instance;
      }
      
      public function get model() : ChildModel
      {
         return _model;
      }
      
      public function get nsModel() : ChildNursingSpiritModel
      {
         return _nsModel;
      }
      
      public function get arenaModel() : ChildArenaModel
      {
         return _arenaModel;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4747,__childrenInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4748,__childrenEquipHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4746,__childrenApplyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4749,__childrenRemoveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4979,__refreshBossInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 424,__NursingSpiritInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 453,__childArenaBackHandler);
      }
      
      private function __refreshBossInfo(param1:SLGSocketEvent) : void
      {
         var _loc5_:ChildPveBossTemplateCate = null;
         var _loc11_:Array = null;
         var _loc6_:Array = null;
         var _loc2_:Array = null;
         var _loc8_:int = 0;
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc4_:Array = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc10_:GuardPVERspMsg = new GuardPVERspMsg();
         _loc10_ = _loc9_.readBody(_loc10_) as GuardPVERspMsg;
         pveModel.rank = _loc10_.wantedOrder;
         pveModel.process = _loc10_.maxBossId;
         if(_loc10_.skills)
         {
            _loc11_ = _loc10_.skills.split(",");
            _loc5_ = TempleteManager.instance.childPveBossTemplateCate;
            _loc6_ = _loc5_.getAllSkillId();
            _loc2_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               if(_loc11_.indexOf(_loc6_[_loc8_] + "") > -1)
               {
                  _loc2_.push(_loc6_[_loc8_] + "");
               }
               _loc8_++;
            }
            pveModel.skillInfo = _loc2_;
         }
         else
         {
            pveModel.skillInfo = [];
         }
         if(_loc10_.guardPos)
         {
            _loc3_ = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
            _loc7_ = 0;
            while(_loc7_ < _loc10_.guardPos.length)
            {
               _loc3_[_loc10_.guardPos[_loc7_].param2] = _loc10_.guardPos[_loc7_].param1;
               _loc7_++;
            }
            _loc4_ = [_loc3_[1],_loc3_[4],_loc3_[7],_loc3_[10],_loc3_[3],_loc3_[6],_loc3_[9],_loc3_[12]];
            model.formationString = _loc4_.join(",");
         }
         if(_loc10_.opType == 1)
         {
            FrameControllerManager.instance.childPveController.start();
         }
      }
      
      private function __childrenRemoveHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:ChildData = null;
         var _loc5_:ChildRemoveAlert = null;
         var _loc8_:CampaignTemplate = null;
         var _loc10_:String = null;
         var _loc7_:String = null;
         var _loc12_:InviteFrame = null;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConfirmMsg = new ConfirmMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as ConfirmMsg;
         var _loc3_:String = "";
         var _loc4_:Array = _loc2_.property2.split(",");
         var _loc9_:int = 0;
         if(_loc2_.opType == 1)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc4_.length)
            {
               _loc6_ = model.getChildById(int(_loc4_[_loc9_]));
               if(_loc6_)
               {
                  if(_loc9_ == 0)
                  {
                     _loc3_ += _loc6_.name;
                  }
                  else
                  {
                     _loc3_ = _loc3_ + "," + _loc6_.name;
                  }
               }
               _loc9_++;
            }
            MsgMan.notifyObserver("ChildEvent.HAND_IN");
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("core.childRemoveAlert");
            _loc5_.backFun = removeChildHandler;
            _loc5_.cancleFun = cancleFun;
            _loc5_.showStr = _loc3_;
            LayerManager.Instance.addToLayer(_loc5_,3,true,true,1);
         }
         else if(_loc2_.opType == 3)
         {
            _loc8_ = TempleteManager.instance.pvpWarFightDic[_loc2_.property1];
            if(!_loc8_)
            {
               _loc8_ = TempleteManager.instance.worldBossTemplateDict[_loc2_.property1];
            }
            if(!_loc8_)
            {
               return;
            }
            _loc10_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.frame06");
            _loc7_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.content06",_loc2_.property2,_loc8_.CampaignName);
            _loc12_ = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrame");
            _loc12_.titleText = _loc10_;
            _loc12_.roomType = 6;
            _loc12_.content = _loc7_;
            _loc12_.time = 10;
            _loc12_.setPos(6);
            _loc12_.show();
         }
      }
      
      private function __cancleHandler(param1:Event) : void
      {
         SimpleAlertHelper.instance.removeEventListener("dispose",__cancleHandler);
         MarrySender.confirmDivorce(false);
      }
      
      private function divideCall(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc3_ = GoodsManager.instance.getGeneralBagChildEquipList();
            _loc4_ = false;
            for each(var _loc6_:GoodsInfo in _loc3_)
            {
               if(_loc4_)
               {
                  break;
               }
               _loc5_ = 1;
               while(_loc5_ <= 4)
               {
                  if(_loc6_["join" + _loc5_] > 0)
                  {
                     _loc4_ = true;
                     break;
                  }
                  _loc5_++;
               }
            }
            if(_loc4_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.handin.ChildDivideFrame.hasJewel"));
               MarrySender.confirmDivorce(false);
               return;
            }
            MarrySender.confirmDivorce(true);
         }
         else
         {
            MarrySender.confirmDivorce(false);
         }
      }
      
      private function cancleFun() : void
      {
         ChildSender.confirmRemoveChild(false);
      }
      
      private function removeChildHandler() : void
      {
         ChildSender.confirmRemoveChild(true);
      }
      
      private function __childrenApplyHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChildrenApplyMsg = new ChildrenApplyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChildrenApplyMsg;
         model.applyInfo.state = _loc2_.state;
         model.applyInfo.userIdA = _loc2_.userIdA;
         model.applyInfo.userIdB = _loc2_.userIdB;
         model.applyInfo.isApply = _loc2_.isApply;
         model.applyInfo.time = _loc2_.applyTime;
         if(model.applyInfo.state == 1)
         {
            MainToolBar.instance.armyButtonShine = true;
         }
      }
      
      private function __childrenEquipHandler(param1:SLGSocketEvent) : void
      {
      }
      
      private function __childArenaBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ChildArenaPlayerInfo = null;
         var _loc4_:ChildCommonFormationInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:GuardPvpListMsg = new GuardPvpListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as GuardPvpListMsg;
         if(_loc2_.hasHasReward)
         {
            arenaModel.hasReward = _loc2_.hasReward;
         }
         if(_loc2_.hasIsSign)
         {
            arenaModel.isSign = _loc2_.isSign;
         }
         if(_loc2_.hasStatus)
         {
            arenaModel.curstate = _loc2_.status;
         }
         if(_loc2_.hasTeamType)
         {
            arenaModel.arenaType = _loc2_.teamType;
         }
         if(_loc2_.hasAutoTeamType)
         {
            arenaModel.autoSignState = _loc2_.autoTeamType;
         }
         if(_loc2_.hasBetWinCount)
         {
            arenaModel.guessIndex = _loc2_.betWinCount;
         }
         if(_loc2_.hasCurrentTurn)
         {
            arenaModel.currentTurn = _loc2_.currentTurn;
         }
         if(_loc2_.hasNextFightTime)
         {
            arenaModel.nextWarLeftTime = DateFormatter.parse(_loc2_.nextFightTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
         }
         if(arenaModel.curstate == 1)
         {
            MsgMan.notifyObserver("ChildEvent.CHILD_ARENA_ISGROUPING");
         }
         if(_loc2_.guardPvpOp == 6 && arenaModel.curstate == 4 && arenaModel.isInChildArena)
         {
            ChildSender.requestChildArenaOp(1);
         }
         if(_loc2_.guardPvpOp == 1)
         {
            arenaModel.arenaVsPlayerList = [];
            for each(var _loc6_:GuardPvpInfoMsg in _loc2_.info)
            {
               _loc5_ = new ChildArenaPlayerInfo();
               _loc5_.uuid = _loc6_.uuid;
               _loc5_.userId = _loc6_.userId;
               _loc5_.serverName = _loc6_.serverName;
               _loc5_.nickName = _loc6_.nickName;
               _loc5_.fightPower = _loc6_.fightPower;
               _loc5_.winCount = _loc6_.winCount;
               _loc5_.teamPos = _loc6_.teamPos;
               arenaModel.arenaVsPlayerList.push(_loc5_);
            }
            arenaModel.arenaVsPlayerList.sortOn("teamPos",16);
         }
         else
         {
            arenaModel.childAreanFromationList = [];
            for each(var _loc3_:GuardPvpPosMsg in _loc2_.guardPos)
            {
               _loc4_ = new ChildCommonFormationInfo();
               _loc4_.childId = _loc3_.param1;
               _loc4_.attackPos = _loc3_.param2;
               _loc4_.standPos = _loc3_.param3;
               arenaModel.childAreanFromationList.push(_loc4_);
            }
            arenaModel.childAreanFromationList.sortOn("standPos",16);
         }
         arenaModel.commitListData();
         MsgMan.notifyObserver("ChildEvent.CHILD_ARENA_UPDATE_MAIN");
      }
      
      private function __NursingSpiritInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:ChildData = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerSpiritInfoMsg = new PlayerSpiritInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlayerSpiritInfoMsg;
         for each(var _loc5_:SpiritInfoMsg in _loc2_.spirits)
         {
            _loc3_ = model.getChildById(_loc5_.childId);
            if(_loc3_ != null)
            {
               if(_loc3_.nursingSpiritInfo == null)
               {
                  _loc3_.nursingSpiritInfo = new NursingSpiritInfo();
               }
               _loc3_.nursingSpiritInfo.resiGp = _loc5_.resiGp;
               _loc3_.nursingSpiritInfo.resiGrade = _loc5_.resiGrade;
               _loc3_.nursingSpiritInfo.reduceResiGp = _loc5_.reduceResiGp;
               _loc3_.nursingSpiritInfo.reduceResiGrade = _loc5_.reduceResiGrade;
               _loc3_.nursingSpiritInfo.jobTypeA = _loc5_.jobTypeA;
               _loc3_.nursingSpiritInfo.skillA = _loc5_.skillA;
               _loc3_.nursingSpiritInfo.skillBookA = _loc5_.skillBookA;
               _loc3_.nursingSpiritInfo.jobTypeB = _loc5_.jobTypeB;
               _loc3_.nursingSpiritInfo.skillB = _loc5_.skillB;
               _loc3_.nursingSpiritInfo.skillBookB = _loc5_.skillBookB;
               _loc3_.nursingSpiritInfo.awakeGp = _loc5_.awakeGp;
               _loc3_.nursingSpiritInfo.awakeGrade = _loc5_.awakeGrade;
               _loc3_.nursingSpiritInfo.talentPoint = _loc5_.talentPoint;
               _loc3_.nursingSpiritInfo.talentGrade = _loc5_.talentGrade;
               _loc3_.nursingSpiritInfo.talentGp = _loc5_.talentGp;
               _loc3_.nursingSpiritInfo.talentSkill = _loc5_.talentSkill;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.grade = _loc5_.lifeWheel.grade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.reduceResiGrade = _loc5_.lifeWheel.reduceResiGrade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.reduceResiGp = _loc5_.lifeWheel.reduceResiGp;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.fireResiGrade = _loc5_.lifeWheel.fireResiGrade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.fireResiGp = _loc5_.lifeWheel.fireResiGp;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.waterResiGrade = _loc5_.lifeWheel.waterResiGrade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.waterResiGp = _loc5_.lifeWheel.waterResiGp;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.elcResiGrade = _loc5_.lifeWheel.elcResiGrade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.elcResiGp = _loc5_.lifeWheel.elcResiGp;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.windResiGrade = _loc5_.lifeWheel.windResiGrade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.windResiGp = _loc5_.lifeWheel.windResiGp;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.darkResiGrade = _loc5_.lifeWheel.darkResiGrade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.darkResiGp = _loc5_.lifeWheel.darkResiGp;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.lightResiGrade = _loc5_.lifeWheel.lightResiGrade;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.lightResiGp = _loc5_.lifeWheel.lightResiGp;
               _loc3_.nursingSpiritInfo.lifeWheelInfo.activeSkillId = _loc5_.lifeWheel.skillId;
               _loc3_.nursingSpiritInfo.spiritArtifactInfo.progress = _loc5_.artifact.progress;
               _loc3_.nursingSpiritInfo.spiritArtifactInfo.isEquip = _loc5_.artifact.isEquip;
               _loc3_.nursingSpiritInfo.spiritArtifactInfo.resis = _loc5_.artifact.resis;
               _loc3_.nursingSpiritInfo.spiritArtifactInfo.resiTypes = _loc5_.artifact.resiTypes;
               _loc3_.nursingSpiritInfo.spiritArtifactInfo.enchants = _loc5_.artifact.enchants;
               _loc3_.nursingSpiritInfo.trainInfo.childId = _loc5_.childId;
               if(_loc5_.trainInfo)
               {
                  _loc3_.nursingSpiritInfo.trainInfo.grade = _loc5_.trainInfo.trainGrade;
                  _loc3_.nursingSpiritInfo.trainInfo.stageGrade = _loc5_.trainInfo.stageGrade;
                  _loc3_.nursingSpiritInfo.trainInfo.liveGrade = _loc5_.trainInfo.liveGrade;
                  _loc3_.nursingSpiritInfo.trainInfo.attackGrade = _loc5_.trainInfo.attackGrade;
                  _loc3_.nursingSpiritInfo.trainInfo.defenseGrade = _loc5_.trainInfo.phyDefenceGrade;
                  _loc3_.nursingSpiritInfo.trainInfo.magicDefenseGrade = _loc5_.trainInfo.magDefenceGrade;
                  _loc3_.nursingSpiritInfo.trainInfo.point = _loc5_.trainInfo.trainPoint;
                  _loc3_.nursingSpiritInfo.trainInfo.skills = _loc5_.trainInfo.skillEnchants;
                  _loc3_.nursingSpiritInfo.trainInfo.clientFlg = 1;
               }
            }
         }
         MsgMan.notifyObserver("ChildEvent.CHILD_NSINFO_UPDATE");
         if(_loc2_.hasOp)
         {
            if(_loc2_.op == 35)
            {
               if(_loc2_.hasIsSuccess)
               {
                  nsModel.isSuccess = _loc2_.isSuccess;
               }
               if(_loc2_.hasGpIndex)
               {
                  nsModel.gpIndex = _loc2_.gpIndex;
               }
               if(_loc2_.hasResiIndex)
               {
                  nsModel.resiIndex = _loc2_.resiIndex;
               }
               if(_loc2_.hasResults)
               {
                  nsModel.results = _loc2_.results;
               }
            }
            if(_loc2_.op == 43)
            {
               if(_loc2_.hasIsSuccess)
               {
                  nsModel.enchantRefreshSuccess = _loc2_.isSuccess;
               }
               if(_loc2_.hasResiIndex)
               {
                  nsModel.enchantIndex = _loc2_.resiIndex;
               }
            }
            MsgMan.notifyObserver("ChildEvent.CHILD_NS_OP_BACK",_loc2_.op);
         }
      }
      
      private function __childrenInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc15_:ChildData = null;
         var _loc10_:ChildrenMsg = null;
         var _loc6_:EmblemMsg = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:EmblemInfo = null;
         var _loc8_:ChildCollectInfo = null;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerChildMsg = new PlayerChildMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as PlayerChildMsg;
         var _loc3_:Boolean = false;
         var _loc13_:int = int(_loc2_.child.length);
         _loc7_ = 0;
         while(_loc7_ < _loc13_)
         {
            _loc10_ = _loc2_.child[_loc7_] as ChildrenMsg;
            if(_loc10_)
            {
               if(_loc10_.state == -1)
               {
                  _model.removeChild(_loc10_.childId);
               }
               else
               {
                  _loc15_ = _model.getChildById(_loc10_.childId);
                  if(_loc15_ == null)
                  {
                     _loc15_ = new ChildData();
                     _loc15_.childId = _loc10_.childId;
                     _model.childList.push(_loc15_);
                     if(firstLoad == false)
                     {
                        _loc3_ = true;
                     }
                  }
                  _loc15_.bornTime = _loc10_.birthTime;
                  _loc15_.name = _loc10_.name;
                  _loc15_.job = _loc10_.job;
                  _loc15_.sex = _loc10_.sex;
                  _loc15_.userIdA = _loc10_.userIdA;
                  _loc15_.growthGrade = _loc10_.growthGrade;
                  _loc15_.growthGp = _loc10_.growthGp;
                  _loc15_.growthCount = _loc10_.growthCount;
                  _loc15_.childAssistAwakeLevel = _loc10_.childAssistAwakeLevel;
                  _loc15_.fightUserId = _loc10_.fightUserId;
                  _loc15_.fightSlaveUserId = _loc10_.fightSlaveUserId;
                  _loc15_.skill = _loc10_.skill;
                  _loc15_.fightSkill = _loc10_.fightSkill;
                  _loc15_.skillBooks = _loc10_.skillBooks;
                  _loc15_.fightValue = _loc10_.fightCapacity;
                  _loc15_.state = _loc10_.state;
                  _loc15_.emblemLv = _loc10_.emblem;
                  _loc15_.emblemGp = _loc10_.emblemGp;
                  if(_loc10_.fightPet)
                  {
                     _loc15_.enterPet.Attack = _loc10_.fightPet.petPhyAttack;
                     _loc15_.enterPet.Defence = _loc10_.fightPet.petPhyDefence;
                     _loc15_.enterPet.MagicAttack = _loc10_.fightPet.petMagAttack;
                     _loc15_.enterPet.MagicDefence = _loc10_.fightPet.petMagDefence;
                     _loc15_.enterPet.resFire = _loc10_.fightPet.petFireResi;
                     _loc15_.enterPet.resWater = _loc10_.fightPet.petWaterResi;
                     _loc15_.enterPet.resElect = _loc10_.fightPet.petElectResi;
                     _loc15_.enterPet.resWind = _loc10_.fightPet.petWindResi;
                     _loc15_.enterPet.resDark = _loc10_.fightPet.petDarkResi;
                     _loc15_.enterPet.resLight = _loc10_.fightPet.petLightResi;
                     if(_loc10_.fightPet.hasPetHp)
                     {
                        _loc15_.enterPet.Live = Int64Utils.int64ToNumber(_loc10_.fightPet.petHp);
                     }
                     else
                     {
                        _loc15_.enterPet.Live = 0;
                     }
                  }
                  if(_loc10_.joinInfo)
                  {
                     _loc15_.childAttInfo.attack = _loc10_.joinInfo.attack;
                     _loc15_.childAttInfo.defence = _loc10_.joinInfo.defence;
                     _loc15_.childAttInfo.magicAttack = _loc10_.joinInfo.magicAttack;
                     _loc15_.childAttInfo.magicDefence = _loc10_.joinInfo.magicDefence;
                     if(_loc10_.joinInfo.hasHp)
                     {
                        _loc15_.childAttInfo.hp = Int64Utils.int64ToNumber(_loc10_.joinInfo.hp);
                     }
                     else
                     {
                        _loc15_.childAttInfo.hp = 0;
                     }
                     _loc15_.childAttInfo.forceHit = _loc10_.joinInfo.forceHit;
                     _loc15_.childAttInfo.parry = _loc10_.joinInfo.parry;
                     _loc15_.childAttInfo.stunAttr = _loc10_.joinInfo.stunAttr;
                     _loc15_.childAttInfo.penetrate = _loc10_.joinInfo.penetrate;
                     _loc15_.childAttInfo.reduceResi = _loc10_.joinInfo.reduceResi;
                     _loc15_.childAttInfo.fireResi = _loc10_.joinInfo.fireResi;
                     _loc15_.childAttInfo.waterResi = _loc10_.joinInfo.waterResi;
                     _loc15_.childAttInfo.electResi = _loc10_.joinInfo.electResi;
                     _loc15_.childAttInfo.windResi = _loc10_.joinInfo.windResi;
                     _loc15_.childAttInfo.darkResi = _loc10_.joinInfo.darkResi;
                     _loc15_.childAttInfo.lightResi = _loc10_.joinInfo.lightResi;
                     _loc15_.childAttInfo.strikeResi = _loc10_.joinInfo.resiPenetrate;
                     _loc15_.childAttInfo.resResistResi = _loc10_.joinInfo.reduceResiAgainst;
                  }
                  _loc15_.emblemList = [];
                  _loc9_ = 0;
                  while(_loc9_ < _loc10_.emblemPos.length)
                  {
                     _loc6_ = _loc10_.emblemPos[_loc9_] as EmblemMsg;
                     if(_loc6_)
                     {
                        _loc5_ = _loc15_.emblemList[_loc6_.pos] as EmblemInfo;
                        if(_loc5_ == null)
                        {
                           _loc5_ = new EmblemInfo();
                           _loc15_.emblemList[_loc6_.pos] = _loc5_;
                        }
                        _loc5_.pos = _loc6_.pos;
                        _loc5_.resi1 = _loc6_.resi1;
                        _loc5_.grade1 = _loc6_.resi1Grade;
                        _loc5_.gp1 = _loc6_.resi1Gp;
                        _loc5_.resi2 = _loc6_.resi2;
                        _loc5_.grade2 = _loc6_.resi2Grade;
                        _loc5_.gp2 = _loc6_.resi2Gp;
                        _loc5_.resi3 = _loc6_.resi3;
                        _loc5_.grade3 = _loc6_.resi3Grade;
                        _loc5_.gp3 = _loc6_.resi3Gp;
                     }
                     _loc9_++;
                  }
               }
            }
            _loc7_++;
         }
         _model.firstChildId = _loc2_.firstChildId;
         _model.totalGrowth = _loc2_.totalGrowth;
         for each(var _loc4_:ChildCollectInfoMsg in _loc2_.info)
         {
            _loc8_ = model.getChildCollecInfoByType(_loc4_.childType);
            if(!_loc8_)
            {
               _loc8_ = new ChildCollectInfo();
               _model.collectionInfoList.push(_loc8_);
            }
            _loc8_.childType = _loc4_.childType;
            _loc8_.soulWakes = _loc4_.soulWakes;
            _loc8_.growth = _loc4_.growth;
         }
         _model.collectionInfoList.sortOn("childType",16);
         var _loc12_:ThaneInfo = thane;
         _loc12_.beginChanges();
         var _loc14_:ChildData = _model.getEnterWar();
         if(_loc14_)
         {
            _loc12_.childrenName = _loc14_.name;
            _loc12_.childrenJob = _loc14_.job;
            _loc12_.childrenSex = _loc14_.sex;
            _loc12_.childrenGrade = _loc14_.growthGrade;
            if(_loc14_.nursingSpiritInfo && _loc14_.nursingSpiritInfo.trainInfo.clientFlg == 1)
            {
               _loc12_.growthGrade2 = _loc14_.nursingSpiritInfo.trainInfo.grade;
            }
         }
         else
         {
            _loc12_.childrenName = "";
            _loc12_.childrenJob = 0;
            _loc12_.childrenSex = 0;
            _loc12_.childrenGrade = 0;
            _loc12_.growthGrade2 = -1;
         }
         _loc12_.commit();
         if(_loc3_)
         {
            MainToolBar.instance.armyButtonShine = true;
         }
         MsgMan.notifyObserver("ChildEvent.CHILD_INFO");
         _delay = setTimeout(isOnline,5000);
      }
      
      private function isOnline() : void
      {
         if(_delay > 0)
         {
            clearTimeout(_delay);
         }
         firstLoad = false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function openChildFram() : void
      {
         if(ArmyManager.instance.thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",70));
         }
         else if(model.childList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("child","main");
         }
      }
      
      public function openSexFram(param1:int) : void
      {
         var _loc2_:ChildSexFrame = null;
         if(ArmyManager.instance.thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",70));
         }
         else if(model.applyInfo.state != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.noFetation"));
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("yishi.view.frame.ChildSexFrame");
            _loc2_.show(param1);
         }
      }
      
      public function checkForExchangeChild() : void
      {
         if(ArmyManager.instance.thane.grades < 70)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",70));
         }
         else
         {
            if(GoodsManager.instance.getGoodsNumByTempId(2131140) < ChildSender.getChildApplyItemCount())
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.module.children.ChildSender.pickChildCall.goldNotEnough5"));
               return;
            }
            ChildSender.pickChild(2);
         }
      }
      
      public function openGrowthFram(param1:ChildData) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","growth",param1);
      }
      
      public function openCareFram(param1:ChildData) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","care",param1);
      }
      
      public function openSelectJob(param1:ChildData) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","select_job",param1);
      }
      
      public function openHandInFrame() : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","handin");
      }
      
      public function openDivideFrame(param1:Object) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","divide",param1);
      }
      
      public function lookChildInformationFrame(param1:ChildData) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","look_information",param1);
      }
      
      public function openEmblemChangeView(param1:Object) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","emblem_change",param1);
      }
      
      public function openEmblemUpView(param1:Object) : void
      {
         FrameControllerManager.instance.openControllerByInfo("child","emblem_up",param1);
      }
      
      public function get pveModel() : ChildPveModel
      {
         return FrameControllerManager.instance.childPveController.pveModel;
      }
      
      public function getJobName(param1:int) : String
      {
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1,1);
         return _loc2_.JobName;
      }
      
      public function get curSelectChild() : ChildData
      {
         if(frameShowType == 1)
         {
            return model.selectedChild;
         }
         if(frameShowType == 2)
         {
            return nsModel.selectedNsChild;
         }
         return null;
      }
      
      public function openChildNsFram(param1:int) : void
      {
         if(!thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MainToolBar.needChangeJob"));
         }
         else if(param1 != 0 && nsModel.nsList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.noChildNsTips"));
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("childnursingspirit","MAIN",param1);
         }
      }
   }
}

