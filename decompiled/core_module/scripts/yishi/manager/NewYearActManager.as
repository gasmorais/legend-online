package yishi.manager
{
   import com.road.yishi.proto.active.ChargeLotteryMsg;
   import com.road.yishi.proto.active.ItemMsg;
   import com.road.yishi.proto.active.LoginActiveMsg;
   import com.road.yishi.proto.active.LoginRewardInfoMsg;
   import com.road.yishi.proto.active.RebateAllInfosMsg;
   import com.road.yishi.proto.active.RewardItemMsg;
   import events.NewYearLotteryEvent;
   import flash.events.EventDispatcher;
   import newyearact.ContinousLoginModel;
   import newyearact.ContinousLoginRewardInfo;
   import newyearact.NewYearActPayModel;
   import newyearact.NewYearLotteryModel;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   
   public class NewYearActManager extends EventDispatcher
   {
      
      private static var _instance:NewYearActManager;
      
      private var _continousLoginRewardList:Array;
      
      private var _continaouLoginModel:ContinousLoginModel;
      
      private var _newyearActPayModel:NewYearActPayModel;
      
      private var _newYearLotteryModel:NewYearLotteryModel;
      
      private var _isGetOver:Boolean = true;
      
      public function NewYearActManager()
      {
         var _loc2_:int = 0;
         var _loc1_:ContinousLoginRewardInfo = null;
         super();
         _continousLoginRewardList = [];
         if(!_continaouLoginModel)
         {
            _continaouLoginModel = new ContinousLoginModel();
            _continaouLoginModel.rewardInfos = [];
            _loc2_ = 1;
            while(_loc2_ < 8)
            {
               _loc1_ = new ContinousLoginRewardInfo();
               _loc1_.index = _loc2_;
               _loc1_.status = 0;
               _continaouLoginModel.rewardInfos.push(_loc1_);
               _continousLoginRewardList.push([]);
               _loc2_++;
            }
         }
         if(!newyearPayModel)
         {
            _newyearActPayModel = new NewYearActPayModel();
         }
         if(!_newYearLotteryModel)
         {
            _newYearLotteryModel = new NewYearLotteryModel();
            _newYearLotteryModel.lotteryGoodsList = [];
         }
      }
      
      public static function get instance() : NewYearActManager
      {
         if(!_instance)
         {
            _instance = new NewYearActManager();
         }
         return _instance;
      }
      
      public function get isGetOver() : Boolean
      {
         return _isGetOver;
      }
      
      public function set isGetOver(param1:Boolean) : void
      {
         this._isGetOver = param1;
      }
      
      public function get loginModel() : ContinousLoginModel
      {
         return _continaouLoginModel;
      }
      
      public function get newyearPayModel() : NewYearActPayModel
      {
         return _newyearActPayModel;
      }
      
      public function get loginRewardList() : Array
      {
         return _continousLoginRewardList;
      }
      
      public function get lotteryModel() : NewYearLotteryModel
      {
         return _newYearLotteryModel;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4704,__newYearLoginHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4705,__loginItemHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4706,__lotteryItemHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4707,__newyearRebateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4708,__lotteryHandler);
      }
      
      private function __newYearLoginHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ContinousLoginRewardInfo = null;
         isGetOver = true;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:LoginActiveMsg = new LoginActiveMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as LoginActiveMsg;
         loginModel.loginNum = _loc2_.loginCount;
         if(_loc2_.rewardInfos && _loc2_.rewardInfos.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.rewardInfos.length)
            {
               _loc4_ = new ContinousLoginRewardInfo();
               _loc4_.index = (_loc2_.rewardInfos[_loc3_] as LoginRewardInfoMsg).index;
               _loc4_.status = (_loc2_.rewardInfos[_loc3_] as LoginRewardInfoMsg).statu;
               if((_loc2_.rewardInfos[_loc3_] as LoginRewardInfoMsg).statu != 1)
               {
                  isGetOver = false;
               }
               loginModel.rewardInfos[(_loc2_.rewardInfos[_loc3_] as LoginRewardInfoMsg).index - 1] = _loc4_;
               _loc3_++;
            }
            if(_isGetOver && _loc2_.rewardInfos.length >= 7)
            {
               isGetOver = true;
            }
            else
            {
               isGetOver = false;
            }
         }
         else
         {
            isGetOver = false;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("NEWYEARLOGINREFRESH"));
      }
      
      private function __loginItemHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:ItemMsg = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardItemMsg = new RewardItemMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RewardItemMsg;
         var _loc4_:int = int(_loc2_.itemInfos.length);
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            (_continousLoginRewardList[_loc5_] as Array).splice(0);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc2_.itemInfos[_loc5_] as ItemMsg;
            (_continousLoginRewardList[_loc3_.param - 1] as Array).push(_loc3_);
            _loc5_++;
         }
      }
      
      protected function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = param1.templateInfo.SonType;
         var _loc4_:int = param2.templateInfo.SonType;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         return 0;
      }
      
      private function __lotteryItemHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc3_:* = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RewardItemMsg = new RewardItemMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RewardItemMsg;
         lotteryModel.lotteryGoodsList = [];
         for each(_loc3_ in _loc2_.itemInfos)
         {
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.itemTempId);
            if(_loc4_)
            {
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc3_.itemTempId;
               _loc6_.count = _loc3_.count;
               lotteryModel.lotteryGoodsList.push(_loc6_);
            }
         }
         lotteryModel.lotteryGoodsList.sort(sortFun);
      }
      
      private function __newyearRebateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RebateAllInfosMsg = new RebateAllInfosMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RebateAllInfosMsg;
         _newyearActPayModel.cur_PayPoint = _loc2_.cur_PayPoint;
         _newyearActPayModel.curLevel = _loc2_.curLevel;
         _newyearActPayModel.payCount = _loc2_.payCount;
         _newyearActPayModel.getCount = _loc2_.getCount;
         _newyearActPayModel.payInfos = _loc2_.payInfos;
         dispatchEvent(new NotificationEvent("REFRESH_PAYACT"));
      }
      
      private function __lotteryHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChargeLotteryMsg = new ChargeLotteryMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChargeLotteryMsg;
         lotteryModel.beginTime = DateFormatter.parse(_loc2_.beginTm,"YYYY-MM-DD hh:mm:ss").getTime();
         lotteryModel.endTime = DateFormatter.parse(_loc2_.endTm,"YYYY-MM-DD hh:mm:ss").getTime();
         lotteryModel.lotteryCount = _loc2_.lotteryCount;
         lotteryModel.onceNeedPoint = _loc2_.onceNeedPoint;
         lotteryModel.defectPoint = _loc2_.defectPoint;
         lotteryModel.rewardItem = _loc2_.rewardItem;
         lotteryModel.count = _loc2_.count;
         lotteryModel.statu = _loc2_.statu;
         lotteryModel.isMail = _loc2_.isMail;
         dispatchEvent(new NewYearLotteryEvent("LOTTERY_INFO",null));
      }
   }
}

