package managers
{
   import com.road.yishi.proto.cccactive.MoneyReturnMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.wholerebate.WholeRebateModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class WholeRebateManager
   {
      
      private static var _instance:WholeRebateManager;
      
      private var _model:WholeRebateModel;
      
      public function WholeRebateManager()
      {
         super();
      }
      
      public static function get instance() : WholeRebateManager
      {
         if(!_instance)
         {
            _instance = new WholeRebateManager();
         }
         return _instance;
      }
      
      public function get model() : WholeRebateModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new WholeRebateModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4866,__moneyReturnStateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4865,__moneyReturnReturnInfoHandler);
      }
      
      private function __moneyReturnStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PropertyMsg;
         _model.startTime = _loc2_.param4;
         _model.endTime = _loc2_.param5;
         _model.isOpen = _loc2_.param7;
         _model.percent = _loc2_.param1;
         _model.leftDiamond = _loc2_.param2;
         _model.total = _loc2_.param3;
         var _loc3_:Date = DateFormatter.parse(_model.startTime,"YYYY-MM-DD hh:mm:ss");
         var _loc4_:Date = DateFormatter.parse(_model.endTime,"YYYY-MM-DD hh:mm:ss");
         _model.startTimeShort = DateFormatter.format(_loc3_,"YYYY-MM-DD");
         _model.endTimeShort = DateFormatter.format(_loc4_,"YYYY-MM-DD");
         if(_model.percent != 0)
         {
            _model.needCharge = Math.ceil(1 * _model.leftDiamond / (_model.percent / 100));
            _model.progress = 100 * (_model.total - _model.leftDiamond) / _model.total;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("WHOLE_REBATE_SHOW"));
      }
      
      private function __moneyReturnReturnInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MoneyReturnMsg = new MoneyReturnMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MoneyReturnMsg;
      }
      
      public function sendWholeRebateOperate() : void
      {
         var _loc1_:PackageOut = new PackageOut(9645,0,28);
         SocketSendManager.instance.sendProtoBuffer(_loc1_,null);
      }
   }
}

