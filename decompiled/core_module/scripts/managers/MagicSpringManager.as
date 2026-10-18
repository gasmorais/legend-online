package managers
{
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.MagicSpringMsg;
   import com.road.yishi.proto.player.MagicSpringSlotMsg;
   import mvc.module.magicspring.MagicSpringModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class MagicSpringManager
   {
      
      private static var _instance:MagicSpringManager;
      
      public static const OPEN_SLOT:int = 1;
      
      public static const MAKE_FORMULA:int = 2;
      
      public static const CANCEL_FORMULA:int = 3;
      
      public static const REQUEST_INFO:int = 4;
      
      private var _model:MagicSpringModel;
      
      public function MagicSpringManager()
      {
         super();
      }
      
      public static function get instance() : MagicSpringManager
      {
         if(_instance == null)
         {
            _instance = new MagicSpringManager();
         }
         return _instance;
      }
      
      public function get model() : MagicSpringModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new MagicSpringModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 172,__updateMagicSpringMsg);
      }
      
      private function __updateMagicSpringMsg(param1:SLGSocketEvent) : void
      {
         var _loc5_:MagicSpringSlotInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MagicSpringMsg = new MagicSpringMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MagicSpringMsg;
         if(_loc2_.hasOpenSlotCount)
         {
            model.openSlotCount = _loc2_.openSlotCount;
         }
         if(_loc2_.hasPotionCount_1)
         {
            model.potionCount1 = _loc2_.potionCount_1;
         }
         if(_loc2_.hasPotionCount_2)
         {
            model.potionCount2 = _loc2_.potionCount_2;
         }
         if(_loc2_.hasPotionCount_3)
         {
            model.potionCount3 = _loc2_.potionCount_3;
         }
         model.slotList = [];
         for each(var _loc3_:MagicSpringSlotMsg in _loc2_.slotList)
         {
            _loc5_ = new MagicSpringSlotInfo();
            _loc5_.tempId = _loc3_.tempId;
            _loc5_.validCountDown = _loc3_.validCountDown;
            model.slotList.push(_loc5_);
         }
         if(_loc2_.hasNewTempId && _loc2_.newTempId != 0)
         {
            MsgMan.notifyObserver("MAKE_SUCCESS_BACK",_loc2_.newTempId);
         }
         else
         {
            MsgMan.notifyObserver("INFO_CHANGE_BACK");
         }
      }
      
      public function sendMagicSpringRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(5189);
         var _loc3_:CommonMsg = new CommonMsg();
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

