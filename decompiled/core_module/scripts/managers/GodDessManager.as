package managers
{
   import com.road.yishi.proto.goddess.GoddessEquipInfoMsg;
   import com.road.yishi.proto.goddess.GoddessFormationIdInfoMsg;
   import com.road.yishi.proto.goddess.GoddessInfoMsg;
   import com.road.yishi.proto.goddess.GoddessMsg;
   import com.road.yishi.proto.goddess.GoddessRequestMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessEquipInfo;
   import mvc.module.goddess.GoddessFormationInfo;
   import mvc.module.goddess.GoddessInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.VersionSwitch;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class GodDessManager
   {
      
      private static var _instance:GodDessManager;
      
      private var _model:GodDessModel;
      
      public function GodDessManager()
      {
         super();
         _model = new GodDessModel();
      }
      
      public static function get instance() : GodDessManager
      {
         if(!_instance)
         {
            _instance = new GodDessManager();
         }
         return _instance;
      }
      
      public static function calculationAddValue(param1:int, param2:int) : int
      {
         return param1 * (100 + param2) / 100;
      }
      
      public function get model() : GodDessModel
      {
         return _model;
      }
      
      public function get isOpen() : Boolean
      {
         var _loc1_:Boolean = true;
         _loc1_ &&= VersionSwitch.GODDESS_OPEN;
         return _loc1_ && ArmyManager.instance.thane.vocationGrades > 0;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 177,__godInfosHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4954,__godDoubleOpenInfoHandler);
      }
      
      private function __godInfosHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:GoddessInfo = null;
         var _loc7_:GoddessEquipInfo = null;
         var _loc5_:Boolean = false;
         var _loc6_:GoddessFormationInfo = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:GoddessMsg = new GoddessMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as GoddessMsg;
         for each(var _loc3_:GoddessInfoMsg in _loc2_.infos)
         {
            _loc10_ = _model.infoDic[_loc3_.templateId];
            if(_loc10_ != null)
            {
               _loc10_.userId = _loc3_.userId;
               _loc10_.templateId = _loc3_.templateId;
               _loc10_.grade = _loc3_.grade;
               _loc10_.gradeGp = _loc3_.gradeGp;
               _loc10_.step = _loc3_.step;
               _loc10_.stepGp = _loc3_.stepGp;
               _loc10_.devote = _loc3_.devote;
               _loc10_.devoteGp = _loc3_.devoteGp;
               _loc10_.attack = _loc3_.attack;
               _loc10_.defance = _loc3_.defance;
               _loc10_.magicAttack = _loc3_.magicAttack;
               _loc10_.magicDefance = _loc3_.magicDefance;
               _loc10_.live = _loc3_.live;
               _loc10_.initBelief = _loc3_.initBelief;
               _loc10_.actionBelief = _loc3_.actionBelief;
               _loc10_.activeSkill = _loc3_.activeSkill;
               _loc10_.defanceSkill = _loc3_.defanceSkill;
               _loc10_.isFight = _loc3_.isFight;
               _loc10_.isActive = true;
               for each(var _loc8_:GoddessEquipInfoMsg in _loc3_.equipInfos)
               {
                  _loc7_ = _loc10_.equips[_loc8_.equipType];
                  if(_loc7_)
                  {
                     _loc7_.equipAdvanceLevel = _loc8_.equipAdvanceLevel;
                     _loc7_.equipCurBlessing = _loc8_.equipCurBlessing;
                     _loc7_.equipStrengthenLevel = _loc8_.equipStrengthenLevel;
                     _loc7_.ownerId = _loc3_.templateId;
                  }
                  _loc5_ = true;
               }
               if(_loc10_.isFight)
               {
                  model.fightGoddess = _loc10_;
               }
               if(_loc5_)
               {
                  MsgMan.notifyObserver("EVENT_EQUIP_UPDATA");
               }
            }
         }
         for each(var _loc4_:GoddessFormationIdInfoMsg in _loc2_.formations)
         {
            _loc6_ = _model.formationMap.containsKey(_loc4_.formationId) as GoddessFormationInfo;
            if(!_loc6_)
            {
               _loc6_ = new GoddessFormationInfo();
            }
            _loc6_.formationId = _loc4_.formationId;
            _loc6_.userId = _loc4_.userId;
            _loc6_.grade = _loc4_.grade;
            _loc6_.gradeGp = _loc4_.gradeGp;
            _loc6_.templateId = _loc4_.templateId;
            _model.formationMap.put(_loc4_.formationId,_loc6_);
            MsgMan.notifyObserver("EVENT_ARRAY_GODDESS_CHANGE");
         }
      }
      
      private function __godDoubleOpenInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_)
         {
            _model.doubleOpen = _loc2_.param7;
            _model.doubleOpenString = _loc2_.param4;
            _model.doubleEndString = _loc2_.param5;
            NotificationManager.instance.sendNotification("GODDESS_EQUIMENT_DOUBLE");
         }
      }
      
      public function getGoddessInfoByFormationIndex(param1:int) : GoddessInfo
      {
         var _loc2_:GoddessInfo = model.infoDic[param1] as GoddessInfo;
         if(!_loc2_)
         {
            _loc2_ = new GoddessInfo();
         }
         return _loc2_;
      }
      
      public function requestOp(param1:int, param2:int = 0, param3:int = 0, param4:Boolean = false) : void
      {
         var _loc6_:PackageOut = new PackageOut(5191);
         var _loc5_:GoddessRequestMsg = new GoddessRequestMsg();
         _loc5_.op = param1;
         _loc5_.templateId = param2;
         _loc5_.count = param3;
         _loc5_.isFight = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public function requestFormationSet(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5191);
         var _loc3_:GoddessRequestMsg = new GoddessRequestMsg();
         _loc3_.op = 6;
         _loc3_.formationId = param1;
         _loc3_.templateId = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function requestFormationUpgrade(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5191);
         var _loc3_:GoddessRequestMsg = new GoddessRequestMsg();
         _loc3_.op = 7;
         _loc3_.count = param2;
         _loc3_.formationId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

