package yishi.manager
{
   import com.road.yishi.proto.simple.PropertyMsg;
   import com.road.yishi.proto.sumpassion.SumCampaignTaskListMsg;
   import flash.events.EventDispatcher;
   import map.campaign.data.SumCampaignModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class SumCampaignManager extends EventDispatcher
   {
      
      private static var _instance:SumCampaignManager;
      
      private var _model:SumCampaignModel;
      
      public var openSumCampaign:Boolean = false;
      
      private var _sumListMsg:SumCampaignTaskListMsg;
      
      public function SumCampaignManager()
      {
         super();
         _model = new SumCampaignModel();
      }
      
      public static function get instance() : SumCampaignManager
      {
         if(!_instance)
         {
            _instance = new SumCampaignManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      public function get model() : SumCampaignModel
      {
         if(_model == null)
         {
            _model = new SumCampaignModel();
         }
         return _model;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 425,__sumlistHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 426,__openStateHandler);
      }
      
      private function __sumlistHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SumCampaignTaskListMsg = new SumCampaignTaskListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SumCampaignTaskListMsg;
         if(!_sumListMsg)
         {
            _sumListMsg = _loc2_;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.task.length)
            {
               _loc4_ = 0;
               while(_loc4_ < _sumListMsg.task.length)
               {
                  if(_sumListMsg.task[_loc4_].templateId == _loc2_.task[_loc3_].templateId)
                  {
                     _sumListMsg.task[_loc4_].killCount = _loc2_.task[_loc3_].killCount;
                     _sumListMsg.task[_loc4_].isSendReward = _loc2_.task[_loc3_].isSendReward;
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
            _sumListMsg.keyCount = _loc2_.keyCount;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PUBLIC_SUM_CAMPAIGN"));
      }
      
      private function __openStateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openSumCampaign = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get sumListMsg() : SumCampaignTaskListMsg
      {
         return _sumListMsg;
      }
      
      public function set sumListMsg(param1:SumCampaignTaskListMsg) : void
      {
         _sumListMsg = null;
      }
      
      public function OperateSunEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(9639);
         SocketSendManager.instance.sendProtoBuffer(_loc1_,null);
      }
   }
}

