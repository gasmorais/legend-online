package managers
{
   import com.road.yishi.proto.gloryroad.GloryRoadDataMsg;
   import com.road.yishi.proto.gloryroad.GloryRoadOpMsg;
   import com.road.yishi.proto.gloryroad.MirrorInfoMsg;
   import com.road.yishi.proto.player.CommonMsg;
   import com.road.yishi.proto.player.CommonMsgList;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import mvc.module.gloryroad.GloryRoadModel;
   import mvc.module.shop.ShopGoodsInfo;
   import utils.LogicUtils;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class GloryroadManager extends EventDispatcher
   {
      
      private static var _instance:GloryroadManager;
      
      private var _model:GloryRoadModel;
      
      private var _intervalId:uint;
      
      public function GloryroadManager(param1:IEventDispatcher = null)
      {
         super(param1);
         _instance = this;
         _model = new GloryRoadModel();
         setup();
         requestData(0);
      }
      
      public static function get instance() : GloryroadManager
      {
         return _instance || new GloryroadManager();
      }
      
      public function get model() : GloryRoadModel
      {
         return _model;
      }
      
      private function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 384,__dataUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 385,__updateMirrorHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 528,shopBuyHandler);
      }
      
      private function shopBuyHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ShopGoodsInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CommonMsgList = new CommonMsgList();
         _loc2_ = _loc5_.readBody(_loc2_) as CommonMsgList;
         for each(var _loc3_:CommonMsg in _loc2_.list)
         {
            _loc4_ = getShopInfo(_loc3_.param1);
            if(_loc4_)
            {
               _loc4_.OneCurrentCount = _loc3_.param2;
            }
         }
      }
      
      private function getShopInfo(param1:int) : ShopGoodsInfo
      {
         var _loc3_:Dictionary = TempleteManager.instance.getGloryShopTempInfoList();
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function __dataUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GloryRoadDataMsg = new GloryRoadDataMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GloryRoadDataMsg;
         LogicUtils.copyMsgValueToInfo(_loc2_,model);
         model.updateView();
         dispatchEvent(new NotificationEvent("GLORY_ROAD_DATA_UPDATE"));
      }
      
      private function __updateMirrorHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MirrorInfoMsg = new MirrorInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MirrorInfoMsg;
         LogicUtils.copyMsgValueToInfo(_loc2_,model.mirrorInfo);
         dispatchEvent(new NotificationEvent("GLORY_ROAD_DATA_UPDATE"));
      }
      
      public function requestData(param1:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(9624);
         var _loc2_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc2_.op = 0;
         _loc2_.type = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function fight(param1:int) : void
      {
         model.updateBeforeLayer();
         var _loc3_:PackageOut = new PackageOut(9624);
         var _loc2_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc2_.op = 1;
         _loc2_.type = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function resurgence(param1:int, param2:int = -1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9624);
         var _loc3_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc3_.op = 2;
         _loc3_.type = param1;
         if(param2 > -1)
         {
            _loc3_.value1 = param2;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function openBox(param1:int, param2:int = -1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9624);
         var _loc3_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc3_.op = 3;
         _loc3_.type = param1;
         if(param2 > -1)
         {
            _loc3_.layer = param2;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function buyBuff(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9624);
         var _loc2_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc2_.op = 5;
         _loc2_.templateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function choosePet(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9624);
         var _loc3_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc3_.op = 4;
         _loc3_.type = param1;
         _loc3_.templateId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function getScoreReward(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9624);
         var _loc2_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc2_.op = 6;
         _loc2_.type = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function skipLayer(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9624);
         var _loc2_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc2_.op = 7;
         _loc2_.type = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function opTag(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9624);
         var _loc2_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc2_.op = 8;
         _loc2_.type = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function refreshBuff() : void
      {
         var _loc2_:PackageOut = new PackageOut(9624);
         var _loc1_:GloryRoadOpMsg = new GloryRoadOpMsg();
         _loc1_.op = 9;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

