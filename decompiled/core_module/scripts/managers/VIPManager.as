package managers
{
   import com.netease.protobuf.Message;
   import com.pickgliss.ui.LayerManager;
   import com.road.yishi.proto.vip.VipInfoMsg;
   import com.road.yishi.proto.vip.VipOpenInfoMsg;
   import com.road.yishi.proto.vip.VipRouletteMsg;
   import mvc.module.vip.VIPModel;
   import mvc.module.vip.VipInfo;
   import mvc.module.vip.VipRouletteInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.VipPrerogativeInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MaskUtils;
   
   public class VIPManager
   {
      
      private static var _instance:VIPManager;
      
      public static const VIP_MAX_LEVEL:int = 12;
      
      private var _model:VIPModel;
      
      public function VIPManager()
      {
         super();
      }
      
      public static function get Instance() : VIPManager
      {
         if(!_instance)
         {
            _instance = new VIPManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
         _model = new VIPModel();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4410,_vipInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4414,_openVipRouletteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4415,_openVipRouletteResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4416,_vipOpenTipsHandler);
      }
      
      public function get model() : VIPModel
      {
         return _model;
      }
      
      private function _vipOpenTipsHandler(param1:SLGSocketEvent) : void
      {
         model.vipOpenTips();
      }
      
      private function _openVipRouletteResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipRouletteMsg = new VipRouletteMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VipRouletteMsg;
         var _loc3_:VipRouletteInfo = new VipRouletteInfo();
         _loc3_.LeftCount = _loc2_.leftCount;
         _loc3_.NeedVipItem = _loc2_.needVipItem;
         _loc3_.OpenIndex = _loc2_.openIndex;
         _loc3_.TakedTempList = _loc2_.takeItem;
         _loc3_.BoxTempIdList = _loc2_.leftItem;
         _loc3_.IsStart = _loc2_.isStart;
         _loc3_.startType = _loc2_.opType;
         model.rouletteInfo = _loc3_;
      }
      
      private function _openVipRouletteHandler(param1:SLGSocketEvent) : void
      {
         MaskUtils.instance.maskHide();
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipRouletteMsg = new VipRouletteMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VipRouletteMsg;
         var _loc3_:VipRouletteInfo = new VipRouletteInfo();
         if(_loc2_.leftItem.length < 18)
         {
            return;
         }
         LayerManager.Instance.clearnGameDynamic();
         _loc3_.LeftCount = _loc2_.leftCount;
         _loc3_.NeedVipItem = _loc2_.needVipItem;
         _loc3_.OpenIndex = _loc2_.openIndex;
         _loc3_.TakedTempList = _loc2_.takeItem;
         _loc3_.BoxTempIdList = _loc2_.leftItem;
         _loc3_.IsStart = _loc2_.isStart;
         _loc3_.startType = _loc2_.opType;
         model.rouletteInfo = _loc3_;
         model.commitOpenBoxEvent();
      }
      
      private function _vipInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipInfoMsg = new VipInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as VipInfoMsg;
         var _loc3_:VipInfo = new VipInfo();
         _loc3_.VipGp = _loc2_.vipGp;
         _loc3_.VipGrade = _loc2_.vipGrade;
         _loc3_.IsTakeGift = _loc2_.isTakeGift;
         _loc3_.VipType = _loc2_.vipType;
         _loc3_.IsVipAndNoExpirt = _loc2_.isVip;
         _loc3_.ExpirData = DateFormatter.parse(_loc2_.expirtDate,"YYYY-MM-DD hh:mm:ss");
         _loc3_.takeGiftDate = DateFormatter.parse(_loc2_.takeGiftDate,"YYYY-MM-DD hh:mm:ss");
         ArmyManager.instance.thane.vipType = _loc3_.VipType;
         ArmyManager.instance.thane.IsVipAndNoExpirt = _loc3_.IsVipAndNoExpirt;
         model.vipInfo = _loc3_;
      }
      
      public function senVIPRolette(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(8519);
         var _loc2_:VipRouletteMsg = new VipRouletteMsg();
         _loc2_.opType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function openVip(param1:Boolean, param2:int, param3:String, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(8513);
         var _loc5_:VipOpenInfoMsg = new VipOpenInfoMsg();
         _loc5_.isFriend = param1;
         _loc5_.friendId = param2;
         _loc5_.friendNickName = param3;
         _loc5_.days = param4;
         sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function getMinVipPrerogativeGradeByType(param1:int) : int
      {
         var _loc4_:int = 12;
         var _loc2_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getVipPrerogativeTypeTempList(param1);
         for each(var _loc3_:VipPrerogativeInfo in _loc2_)
         {
            if(int(_loc3_.para1) > 0 && _loc4_ > _loc3_.grade)
            {
               _loc4_ = _loc3_.grade;
            }
         }
         return _loc4_;
      }
      
      public function getVipPrerogativeByTypeAndGrade(param1:int, param2:int) : VipPrerogativeInfo
      {
         var _loc3_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getVipPrerogativeTypeTempList(param1);
         for each(var _loc4_:VipPrerogativeInfo in _loc3_)
         {
            if(_loc4_.type == param1 && _loc4_.grade == param2)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function senReceiveGift() : void
      {
         var _loc1_:PackageOut = new PackageOut(8505);
         sendProtoBuffer(_loc1_,null);
      }
      
      public function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

