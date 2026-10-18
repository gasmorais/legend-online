package managers
{
   import com.road.yishi.proto.cccactive.PlatinaCanOpMsg;
   import com.road.yishi.proto.cccactive.PlatinaItemGainTipMsg;
   import com.road.yishi.proto.cccactive.PlatinaItemInfoMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import events.PlatinumEvent;
   import flash.events.EventDispatcher;
   import mvc.module.platinum.PlatinumModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class PlatinumManager extends EventDispatcher
   {
      
      private static var _instance:PlatinumManager;
      
      public var openBottle:Boolean;
      
      public var platinum_beginDate:Date;
      
      public var platinum_endDate:Date;
      
      private var _model:PlatinumModel;
      
      public function PlatinumManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : PlatinumManager
      {
         if(!_instance)
         {
            _instance = new PlatinumManager();
         }
         return _instance;
      }
      
      public function get model() : PlatinumModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new PlatinumModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 213,__updateOpenState);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 214,__updateActiveInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 215,__updateActiveItemTip);
      }
      
      private function __updateOpenState(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openBottle = _loc2_.param7;
         platinum_beginDate = DateFormatter.parse(_loc2_.param4,"YYYY-MM-DD hh:mm:ss");
         platinum_endDate = DateFormatter.parse(_loc2_.param5,"YYYY-MM-DD hh:mm:ss");
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      private function __updateActiveInfo(param1:SLGSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlatinaCanOpMsg = new PlatinaCanOpMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlatinaCanOpMsg;
         if(_loc2_.hasHasChance)
         {
            model.hasChance = _loc2_.hasChance;
         }
         if(_loc2_.goldItems && _loc2_.goldItems.length > 0)
         {
            model.goldItemInfo = _loc2_.goldItems;
            model.goldItemNoticeInfo = [];
            for each(var _loc3_:PlatinaItemInfoMsg in _loc2_.goldItems)
            {
               if(_loc3_.isNotice)
               {
                  model.goldItemNoticeInfo.push(_loc3_);
               }
            }
         }
         if(_loc2_.platinaItems && _loc2_.platinaItems.length > 0)
         {
            model.platinumItemInfo = _loc2_.platinaItems;
            model.platinumItemNoticeInfo = [];
            for each(var _loc4_:PlatinaItemInfoMsg in _loc2_.platinaItems)
            {
               if(_loc4_.isNotice)
               {
                  model.platinumItemNoticeInfo.push(_loc4_);
               }
            }
         }
         model.dispatchEvent(new PlatinumEvent("PLATINA_ACTIVE_INFO"));
      }
      
      private function __updateActiveItemTip(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlatinaItemGainTipMsg = new PlatinaItemGainTipMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlatinaItemGainTipMsg;
         if(_loc2_.itemIds && _loc2_.itemIds.length > 0)
         {
            model.itemIds = _loc2_.itemIds;
         }
         if(_loc2_.luckPassTip && _loc2_.luckPassTip.length > 0)
         {
            model.luckPassTip = _loc2_.luckPassTip;
         }
         if(_loc2_.personalTip && _loc2_.personalTip.length > 0)
         {
            if(model.personalTip)
            {
               model.personalTip = model.personalTip.concat(_loc2_.personalTip);
            }
            else
            {
               model.personalTip = _loc2_.personalTip;
            }
         }
      }
      
      public function sendOpenInfo(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9645,0,40);
         var _loc3_:PlatinaCanOpMsg = new PlatinaCanOpMsg();
         _loc3_.drawCount = param1;
         _loc3_.canType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

