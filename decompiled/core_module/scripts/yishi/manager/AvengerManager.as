package yishi.manager
{
   import com.road.yishi.proto.avenger.AvengerHoleMsg;
   import com.road.yishi.proto.avenger.AvengerMsg;
   import com.road.yishi.proto.avenger.AvengerSkillMsg;
   import com.road.yishi.proto.avenger.AvengerSpiritDataMsg;
   import com.road.yishi.proto.avenger.AvengerSpiritMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import flash.utils.Dictionary;
   import mvc.module.avenger.AvengerChildNsInfo;
   import mvc.module.avenger.AvengerDevilArmorHoleInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.avenger.AvengerSkillInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class AvengerManager
   {
      
      private static var _instance:AvengerManager;
      
      private var _model:AvengerModel;
      
      private var _resolveList:Dictionary;
      
      public function AvengerManager()
      {
         super();
         if(!_model)
         {
            _model = new AvengerModel();
         }
      }
      
      public static function get instance() : AvengerManager
      {
         if(!_instance)
         {
            _instance = new AvengerManager();
         }
         return _instance;
      }
      
      public function get resolveList() : Dictionary
      {
         return _resolveList;
      }
      
      private function initTemplate() : void
      {
         _resolveList = TempleteManager.instance.resolveitemsortTemplateCate.getTemplates();
      }
      
      public function get model() : AvengerModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4588,__avengerMsgUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4276,__avengerChildNsHandler);
         initTemplate();
      }
      
      private function __avengerMsgUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:AvengerDevilArmorHoleInfo = null;
         var _loc6_:AvengerSkillInfo = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:AvengerMsg = new AvengerMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AvengerMsg;
         if(_loc2_.hasGrade)
         {
            model.bodyInfo.grade = _loc2_.grade;
         }
         if(_loc2_.hasExp)
         {
            model.bodyInfo.exp = _loc2_.exp;
         }
         if(_loc2_.hasArmorGrade)
         {
            model.devilArmorInfo.grade = _loc2_.armorGrade;
         }
         if(_loc2_.hasArmorExp)
         {
            model.devilArmorInfo.exp = _loc2_.armorExp;
         }
         for each(var _loc3_:AvengerHoleMsg in _loc2_.holeDatas)
         {
            _loc5_ = model.devilArmorInfo.holeDic[_loc3_.pos];
            if(!_loc5_)
            {
               _loc5_ = new AvengerDevilArmorHoleInfo();
               model.devilArmorInfo.holeDic.add(_loc3_.pos,_loc5_);
            }
            _loc5_.pos = _loc3_.pos;
            _loc5_.grade = _loc3_.grade;
            _loc5_.exp = _loc3_.exp;
            _loc5_.inlayItem = _loc3_.inlayItem;
         }
         for each(var _loc4_:AvengerSkillMsg in _loc2_.skillDatas)
         {
            _loc6_ = model.skillDic[_loc4_.skillSonType];
            if(!_loc6_)
            {
               _loc6_ = new AvengerSkillInfo();
               model.skillDic.add(_loc4_.skillSonType,_loc6_);
            }
            _loc6_.skillTempId = _loc4_.skillId;
            _loc6_.skillSontype = _loc4_.skillSonType;
            _loc6_.isFight = _loc4_.isUse;
            _loc6_.attack = _loc4_.attack;
            _loc6_.defence = _loc4_.defence;
            _loc6_.magicDefence = _loc4_.magicDefence;
            _loc6_.live = _loc4_.live;
            _loc6_.forceHit = _loc4_.forcehit;
            _loc6_.parry = _loc4_.parry;
            _loc6_.penetrate = _loc4_.penetrate;
            _loc6_.reduceResi = _loc4_.reduceResi;
            _loc6_.fireResi = _loc4_.fireResi;
            _loc6_.waterResi = _loc4_.waterResi;
            _loc6_.electResi = _loc4_.electResi;
            _loc6_.windResi = _loc4_.windResi;
            _loc6_.darkResi = _loc4_.darkResi;
            _loc6_.lightResi = _loc4_.lightResi;
            _loc6_.needItems = _loc4_.itemInfo;
         }
         if(_loc2_.opType == 0)
         {
            MsgMan.notifyObserver("SKILL_INFO_UPDATE");
            MsgMan.notifyObserver("BODY_INFO_UPDATE");
            MsgMan.notifyObserver("DEVIL_ARMOR_INFO_UPDATE");
         }
         else if(_loc2_.opType == 4)
         {
            MsgMan.notifyObserver("BODY_INFO_UPDATE");
         }
         else if(_loc2_.opType == 1 || _loc2_.opType == 2 || _loc2_.opType == 3)
         {
            MsgMan.notifyObserver("SKILL_INFO_UPDATE");
         }
         else if(_loc2_.opType == 5 || 6)
         {
            MsgMan.notifyObserver("DEVIL_ARMOR_INFO_UPDATE");
         }
      }
      
      private function __avengerChildNsHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:AvengerChildNsInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:AvengerSpiritMsg = new AvengerSpiritMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as AvengerSpiritMsg;
         if(!_loc2_.spiritDatas)
         {
            return;
         }
         for each(var _loc3_:AvengerSpiritDataMsg in _loc2_.spiritDatas)
         {
            _loc5_ = model.nsInfoDic[_loc3_.childId];
            if(!_loc5_)
            {
               _loc5_ = new AvengerChildNsInfo();
               model.nsInfoDic.add(_loc3_.childId,_loc5_);
            }
            _loc5_.childId = _loc3_.childId;
            _loc5_.grade = _loc3_.grade;
            _loc5_.exp = _loc3_.exp;
            _loc5_.stageGrade = _loc3_.stageGrade;
            _loc5_.liveGrade = _loc3_.liveGrade;
            _loc5_.attackGrade = _loc3_.attackGrade;
            _loc5_.defenseGrade = _loc3_.defenseGrade;
            _loc5_.point = _loc3_.point;
            _loc5_.skills = _loc3_.skills;
            _loc5_.resolveSkills();
         }
         MsgMan.notifyObserver("AVENGER_CHILDNS_UPDATE");
      }
      
      public function sendAvengerDataRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(8657);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 0;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendAvengerSkillRequest(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8657);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.type = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendAvengerSkillPromote(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8657);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 2;
         _loc3_.type = param1;
         _loc3_.templateId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendAvengerBodyRequest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8657);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 4;
         _loc2_.count = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendDevilArmorRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(8657);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 5;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendDevilArmorCarveRequest(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8657);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 6;
         _loc3_.index = param1;
         _loc3_.count = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendDevilArmorEquip(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8657);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 7;
         _loc3_.index = param1;
         _loc3_.templateId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendAvengerResolve(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8657);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 8;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendChildNsUpgrade(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8657);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 9;
         _loc3_.id = param1;
         _loc3_.count = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendChildNsStage(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8657);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 10;
         _loc2_.id = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendChildNsPropUpgrade(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8657);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 11;
         _loc3_.id = param1;
         _loc3_.index = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendChildNsLearnSkill(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8657);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 12;
         _loc3_.id = param1;
         _loc3_.templateId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendChildNsUpgradeSkill(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8657);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = 13;
         _loc4_.id = param1;
         _loc4_.templateId = param2;
         _loc4_.count = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}

