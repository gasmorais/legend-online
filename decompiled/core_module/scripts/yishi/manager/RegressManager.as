package yishi.manager
{
   import com.road.yishi.proto.regress.RegressRecordListMsg;
   import com.road.yishi.proto.regress.RegressRecordMsg;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.RegressTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class RegressManager
   {
      
      private static var _instance:RegressManager;
      
      public static var REGRESS_CHARGE:int = 1;
      
      public static var REGRESS_GRADES:int = 2;
      
      public static var REGRESS_LOGIN:int = 3;
      
      private var _regressListMsg:RegressRecordListMsg;
      
      public function RegressManager()
      {
         super();
      }
      
      public static function get instance() : RegressManager
      {
         if(!_instance)
         {
            _instance = new RegressManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 340,__regressInfoHandler);
      }
      
      private function __regressInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RegressRecordListMsg = new RegressRecordListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RegressRecordListMsg;
         _regressListMsg = _loc2_;
         checkEffectShine();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REGRESS_INFO_UPDATE"));
      }
      
      public function checkEffectShine() : void
      {
         var _loc2_:RegressRecordMsg = null;
         var _loc1_:int = 0;
         if(FrameControllerManager.instance.regressControler.frame)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _regressListMsg.info.length)
         {
            _loc2_ = _regressListMsg.info[_loc1_];
            if(_loc2_.isFinish && !_loc2_.isTakeReward)
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("REGRESS_SHINE"));
               return;
            }
            _loc1_++;
         }
      }
      
      public function get regressListMsg() : RegressRecordListMsg
      {
         return _regressListMsg;
      }
      
      public function get canTakeTotalCount() : int
      {
         var _loc2_:RegressTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc1_:Array = TempleteManager.instance.regressTemplateCate.getTemplates();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_] as RegressTemplateInfo;
            if(_loc2_.Types == 1)
            {
               return int(_loc2_.TakePercent * _regressListMsg.canTakeTotalCount / 100);
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function OperatePoker(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(9593);
         var _loc2_:RegressRecordMsg = new RegressRecordMsg();
         _loc2_.takeTemplateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

