package managers
{
   import battle.BattleManager;
   import com.road.yishi.proto.dragontalker.DragonTalkerInfoMsg;
   import com.road.yishi.proto.dragontalker.DragonTalkerOpMsg;
   import com.road.yishi.proto.dragontalker.SkillInfoMsg;
   import com.road.yishi.proto.dragontalker.SymbiontGp;
   import com.road.yishi.proto.dragontalker.TalismanInfoListMsg;
   import com.road.yishi.proto.dragontalker.TalismanMsg;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerProficiencyInfo;
   import mvc.module.dragontalker.DragonTalkerSkillInfo;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerManager
   {
      
      private static var _instance:DragonTalkerManager;
      
      private var _model:DragonTalkerModel;
      
      private var _talismanInfoList:Array = [];
      
      private var _pkgCount:int = 0;
      
      private var _sendTime:Number = 0;
      
      public function DragonTalkerManager()
      {
         super();
         _model = new DragonTalkerModel();
      }
      
      public static function get instance() : DragonTalkerManager
      {
         if(!_instance)
         {
            _instance = new DragonTalkerManager();
         }
         return _instance;
      }
      
      public function get model() : DragonTalkerModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4845,__dragonTalkerInfoMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4844,__dragonTalkerTalismanMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4846,__dragonTalkerOpBackHandler);
      }
      
      private function __dragonTalkerInfoMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc9_:UpgradeTemplateInfo = null;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc6_:DragonTalkerSymbioteInfo = null;
         var _loc5_:DragonTalkerSkillInfo = null;
         var _loc8_:int = 0;
         var _loc10_:DragonTalkerProficiencyInfo = null;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:DragonTalkerInfoMsg = new DragonTalkerInfoMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as DragonTalkerInfoMsg;
         if(_loc2_.hasIsOpen)
         {
            model.isOpen = _loc2_.isOpen;
         }
         if(_loc2_.hasIsNowDragonTalker)
         {
            model.isDragonTalker = _loc2_.isNowDragonTalker;
         }
         if(_loc2_.hasCurrentSkillIndex)
         {
            model.skillActiveIndex = _loc2_.currentSkillIndex;
            model.skillTabIndex = _loc2_.currentSkillIndex;
         }
         if(_loc2_.hasCurrentFightMount)
         {
            model.selectBattleBeastId = _loc2_.currentFightMount;
         }
         if(_loc2_.hasFightMountGp)
         {
            _loc7_ = TempleteManager.instance.getUpgradeGradeBy(140,_loc2_.fightMountGp);
            _loc9_ = TempleteManager.instance.getTemplateByLevelAndType(_loc7_,140);
            _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_loc7_ + 1,140);
            model.battleBeastGrade = _loc7_;
            model.battleBeastExp = _loc2_.fightMountGp - _loc9_.Data;
            if(_loc4_)
            {
               model.battleBesatCurMaxExp = _loc4_.Data - _loc9_.Data;
            }
         }
         if(_loc2_.symbiontGpList && _loc2_.symbiontGpList.length > 0)
         {
            model.symbioteList = [];
            for each(var _loc12_:SymbiontGp in _loc2_.symbiontGpList)
            {
               _loc6_ = new DragonTalkerSymbioteInfo();
               _loc6_.index = _loc12_.index;
               _loc7_ = TempleteManager.instance.getUpgradeGradeBy(142,_loc12_.totalGp);
               _loc9_ = TempleteManager.instance.getTemplateByLevelAndType(_loc7_,142);
               _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_loc7_ + 1,142);
               _loc6_.grade = _loc7_;
               _loc6_.exp = _loc12_.totalGp - _loc9_.Data;
               if(_loc4_)
               {
                  _loc6_.curMaxExp = _loc4_.Data - _loc9_.Data;
               }
               model.symbioteList.push(_loc6_);
            }
            model.symbioteList.sortOn("index",16);
         }
         if(_loc2_.skillInfoList && _loc2_.skillInfoList.length > 0)
         {
            model.dragonSkillList = [];
            model.clearLearnDic();
            model.clearPointDic();
            model.clearSkillPool(false);
            for each(var _loc3_:SkillInfoMsg in _loc2_.skillInfoList)
            {
               _loc5_ = new DragonTalkerSkillInfo();
               _loc5_.index = _loc3_.skillIndex;
               _loc5_.skillPoint = _loc3_.skillPoint;
               _loc5_.hasLearnSkill = _loc3_.skillScript;
               _loc5_.fastKey = _loc3_.fastKey;
               model.dragonSkillList.push(_loc5_);
               model.addDragonSkillLearn(_loc5_.index,_loc3_.skillScript);
               model.addLearnPoint(_loc5_.index,_loc5_.skillPoint);
            }
            model.dragonSkillList.sortOn("index",16);
            model.initSuitSkill(_loc2_.currentSkillIndex);
         }
         model.proficiencyList = [];
         _loc8_ = 1;
         while(_loc8_ <= 4)
         {
            _loc10_ = new DragonTalkerProficiencyInfo();
            _loc10_.index = _loc8_;
            _loc10_.activeSkillId = _loc2_["potentialId" + _loc8_];
            model.proficiencyList.push(_loc10_);
            _loc8_++;
         }
         if(_loc2_.hasSkillCount)
         {
            model.skillCount = _loc2_.skillCount;
         }
         MsgMan.notifyObserver("DRAGON_TALKER_INFO_UPDATE",true);
      }
      
      private function __dragonTalkerTalismanMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:DragonTalkerTalismanInfo = null;
         var _loc3_:DragonTalkerTalismanInfo = null;
         var _loc4_:DragonTalkerTalismanInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:TalismanInfoListMsg = new TalismanInfoListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as TalismanInfoListMsg;
         if(_loc2_.pkgCount >= 1)
         {
            _pkgCount = _pkgCount + 1;
            _talismanInfoList = _talismanInfoList.concat(_loc2_.talismanInfoList);
            if(_pkgCount < _loc2_.pkgCount)
            {
               return;
            }
         }
         for each(var _loc6_:TalismanMsg in _talismanInfoList)
         {
            _loc5_ = model.getTalismanInfoById(_loc6_.id);
            if(_loc5_ == null)
            {
               _loc5_ = new DragonTalkerTalismanInfo();
               model.talismanList.push(_loc5_);
            }
            _loc5_.id = _loc6_.id;
            _loc5_.tempId = _loc6_.templateId;
            _loc5_.pos = _loc6_.pos;
            _loc5_.equipPos = _loc6_.equipslot;
            _loc5_.isExist = _loc6_.isExist;
            _loc5_.grade = _loc6_.grade;
            _loc5_.exp = _loc6_.gp;
            _loc5_.randomSkillList = _loc6_.randomSkillList;
            _loc5_.newSkillId = _loc6_.newSkillId;
            _loc5_.oldSkillIndex = _loc6_.oldSkillIndex;
            _loc5_.count = _loc6_.count;
            _loc5_.isNew = _loc6_.isNew;
            if(!_loc5_.isExist)
            {
               model.removeNoExistTalismanInfo(_loc5_);
            }
         }
         for(var _loc8_:String in model.hideCellDic)
         {
            _loc3_ = model.hideCellDic[_loc8_];
            _loc4_ = model.getTalismanInfoById(_loc3_.id);
            if(_loc4_ == null || !_loc4_.isExist)
            {
               model.hideCellDic.del(_loc8_);
            }
            else
            {
               model.hideCellDic[_loc8_] = _loc4_;
            }
         }
         MsgMan.notifyObserver("DRAGON_TALKER_TALISMAN_UPDATE");
         _talismanInfoList = [];
         _pkgCount = 0;
      }
      
      private function __dragonTalkerOpBackHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as DragonTalkerOpMsg;
         if(_loc2_.op == 6)
         {
            MsgMan.notifyObserver("TALISMAN_SWALLOW_BACK",{
               "result":_loc2_.result,
               "index":_loc2_.newSkillIndex
            });
         }
         if(_loc2_.op == 14 || _loc2_.op == 15)
         {
            MsgMan.notifyObserver("TALISMAN_SWALLOW_SKILL_BACK",_loc2_.result);
         }
      }
      
      public function sendDragonTalkerSwicthRequest() : void
      {
         if(getTimer() - _sendTime < 3000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.ArmyControler.command03"));
            return;
         }
         _sendTime = getTimer();
         if(!model.isOpen || ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerIntensifyView.open.alert"));
            return;
         }
         if(BattleManager.getInstance().started)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.ArmyControler.command05"));
            return;
         }
         var _loc2_:PackageOut = new PackageOut(9667);
         var _loc1_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc1_.op = 2;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendDragonTalkerRequest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9667);
         var _loc2_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendDragonTalkerTalismanReq(param1:int, param2:int, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(9667);
         var _loc5_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc5_.op = param1;
         _loc5_.talismanId = param2;
         if(param3 != 0)
         {
            _loc5_.materialId = param3;
         }
         if(param4 != 0)
         {
            _loc5_.count = param4;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function sendSymbiontStrengthReq(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9667);
         var _loc3_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc3_.op = 7;
         _loc3_.symbiontIndex = param1;
         _loc3_.count = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendFightMountStrengthReq(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9667);
         var _loc2_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc2_.op = 8;
         _loc2_.count = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendSelectFightMountReq(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9667);
         var _loc2_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc2_.op = 9;
         _loc2_.mountTempId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendSkillRequest(param1:int, param2:int, param3:Array = null, param4:String = null, param5:int = -1) : void
      {
         var _loc7_:PackageOut = new PackageOut(9667);
         var _loc6_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc6_.op = param1;
         _loc6_.skillIndex = param2;
         if(param3 != null)
         {
            _loc6_.skillTempIds = param3;
         }
         if(param4 != null)
         {
            _loc6_.fastKey = param4;
         }
         if(param5 != -1)
         {
            _loc6_.payType = param5;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public function sendMutiIntensifyTalisman(param1:int, param2:Array) : void
      {
         var _loc4_:PackageOut = new PackageOut(9667);
         var _loc3_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc3_.op = 17;
         _loc3_.talismanId = param1;
         _loc3_.materialList = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendProficiencyReplace(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9667);
         var _loc2_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc2_.op = 18;
         _loc2_.potentialIndex = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendSellItems(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(9667);
         var _loc2_:DragonTalkerOpMsg = new DragonTalkerOpMsg();
         _loc2_.op = 20;
         _loc2_.sellTaliInfos = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

