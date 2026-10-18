package managers
{
   import com.road.yishi.proto.active.SlotActiveMsg;
   import com.road.yishi.proto.active.SlotActiveRequest;
   import events.SlotEvent;
   import flash.events.EventDispatcher;
   import mvc.module.slot.SlotModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class SlotManager extends EventDispatcher
   {
      
      private static var _instance:SlotManager;
      
      private var _model:SlotModel;
      
      public function SlotManager()
      {
         super();
      }
      
      public static function get Instance() : SlotManager
      {
         if(!_instance)
         {
            _instance = new SlotManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new SlotModel();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4901,__slotInfoHandler);
      }
      
      private function __slotInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SlotActiveMsg = new SlotActiveMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SlotActiveMsg;
         _model.status = _loc2_.status;
         _model.slotResult = _loc2_.slot;
         if(_loc2_.type == 2)
         {
            switch(_model.slotResult.length - 3)
            {
               case 0:
                  _model.slotResult = "####" + _model.slotResult;
                  break;
               case 1:
                  _model.slotResult = "###" + _model.slotResult;
                  break;
               case 2:
                  _model.slotResult = "##" + _model.slotResult;
            }
         }
         _model.type = _loc2_.type;
         _model.rewardTemplateId = _loc2_.rewarditemtemplateid;
         _model.findCost = _loc2_.findcost;
         _model.op = _loc2_.op;
         _model.isOpen = _loc2_.open;
         if(_loc2_.open)
         {
            dispatchEvent(new SlotEvent("SLOTINFO"));
         }
      }
      
      public function sendSlotReq(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9500);
         var _loc2_:SlotActiveRequest = new SlotActiveRequest();
         _loc2_.op = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function get model() : SlotModel
      {
         return _model;
      }
   }
}

