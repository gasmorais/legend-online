package managers
{
   import com.road.yishi.proto.titan.TitanDataMsg;
   import com.road.yishi.proto.titan.TitanOpMsg;
   import manager.LanguageMgr;
   import mvc.module.dragonTitan.DragonTitanEvent;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTitanManager
   {
      
      private static var _instance:DragonTitanManager;
      
      public static const DRAGON_TITAN_SPIRIT:String = "DRAGON_TITAN_SPIRIT";
      
      public static const DRAGON_TITAN_DEVELOP:String = "DRAGON_TITAN_DEVELOP";
      
      public static const DRAGON_TITAN_ARRANGE:String = "DRAGON_TITAN_ARRANGE";
      
      public static const DRAGON_TITAN_ENERGY:String = "DRAGON_TITAN_ENERGY";
      
      public var currSelectedPage:String = "";
      
      public var currSelectedView:String = "";
      
      public var openFrame:int = 1;
      
      private var firstLoad:Boolean = true;
      
      private var _model:DragonTitanModel;
      
      private var _delay:uint;
      
      public function DragonTitanManager()
      {
         super();
         if(_model == null)
         {
            _model = new DragonTitanModel();
         }
      }
      
      public static function get instance() : DragonTitanManager
      {
         if(!_instance)
         {
            _instance = new DragonTitanManager();
         }
         return _instance;
      }
      
      public function get model() : DragonTitanModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 324,__titanDataHandler);
      }
      
      protected function __titanDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TitanDataMsg = new TitanDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TitanDataMsg;
         model.userId = _loc2_.userId;
         model.templateId = _loc2_.templateId;
         model.starExp = _loc2_.starExp;
         model.starLevel = _loc2_.starLevel;
         model.devourTitan = _loc2_.devourTitan;
         model.skillId0 = _loc2_.skillId0;
         model.skillId1 = _loc2_.skillId1;
         model.skillId2 = _loc2_.skillId2;
         model.curUseSkillIndex = _loc2_.useSkillIndex;
         model.attack = _loc2_.attack;
         model.defence = _loc2_.defence;
         model.magicAttack = _loc2_.magicAttack;
         model.magicDefence = _loc2_.magicDefence;
         model.live = _loc2_.live;
         model.forceHit = _loc2_.forceHit;
         model.parry = _loc2_.parry;
         model.strength = _loc2_.strength;
         model.tenacity = _loc2_.tenacity;
         model.reduceResi = _loc2_.reduceResi;
         model.fireResi = _loc2_.fireResi;
         model.waterResi = _loc2_.waterResi;
         model.electResi = _loc2_.electResi;
         model.windResi = _loc2_.windResi;
         model.darkResi = _loc2_.darkResi;
         model.lightResi = _loc2_.lightResi;
         model.penetrate = _loc2_.penetrate;
         model.stunAttr = _loc2_.stunAttr;
         model.injectData = _loc2_.injectData;
         model.injectGrade = _loc2_.injectGrade;
         model.injectCount = _loc2_.injectCount;
         model.chargeGrade = _loc2_.chargeGrade;
         model.reduceResiGp = _loc2_.reduceResiGp;
         model.fireResiGp = _loc2_.fireResiGp;
         model.waterResiGp = _loc2_.waterResiGp;
         model.electResiGp = _loc2_.electResiGp;
         model.windResiGp = _loc2_.windResiGp;
         model.darkResiGp = _loc2_.darkResiGp;
         model.lightResiGp = _loc2_.lightResiGp;
         model.updateTitanActiveState();
         model.updateViewInfo();
         MsgMan.notifyObserver("DragonTitanEvent.TITAN_DATA",this);
         NotificationManager.instance.dispatchEvent(new DragonTitanEvent("DragonTitanEvent.TITAN_DATA"));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function openDragonTitanFrame() : void
      {
         if(ConfigManager.version_info.TAITAN_LOCK)
         {
            if(thane.isChangeJob)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01"));
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("dragontitan");
            }
         }
      }
      
      public function sendSetTitanIcon(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9581);
         var _loc2_:TitanOpMsg = new TitanOpMsg();
         _loc2_.op = 0;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendSkills(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(9581);
         var _loc3_:TitanOpMsg = new TitanOpMsg();
         _loc3_.op = 1;
         _loc3_.param1 = param1;
         _loc3_.param3 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendDevelop(param1:int = 2, param2:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9581);
         var _loc3_:TitanOpMsg = new TitanOpMsg();
         _loc3_.op = 2;
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendDevour(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9581);
         var _loc2_:TitanOpMsg = new TitanOpMsg();
         _loc2_.op = 3;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendTitanRequest(param1:int, param2:int = -1, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(9581);
         var _loc4_:TitanOpMsg = new TitanOpMsg();
         _loc4_.op = param1;
         if(param1 == 4)
         {
            _loc4_.param1 = param2;
         }
         else if(param1 == 6)
         {
            _loc4_.param1 = param2;
            _loc4_.param2 = param3;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendSelectSkillGroup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9581);
         var _loc2_:TitanOpMsg = new TitanOpMsg();
         _loc2_.op = 7;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendOpenSkillGroup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9581);
         var _loc2_:TitanOpMsg = new TitanOpMsg();
         _loc2_.op = 8;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendOpenSkillItem(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9581);
         var _loc2_:TitanOpMsg = new TitanOpMsg();
         _loc2_.op = 9;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

