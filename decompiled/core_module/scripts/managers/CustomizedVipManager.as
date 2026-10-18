package managers
{
   import com.road.yishi.proto.cccactive.CustomizedVipBoxMsg;
   import com.road.yishi.proto.cccactive.CustomizedVipItemMsg;
   import com.road.yishi.proto.cccactive.CustomizedVipMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.customizedvip.CustomizedVipBoxInfo;
   import mvc.module.customizedvip.CustomizedVipItemInfo;
   import mvc.module.customizedvip.CustomizedVipModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class CustomizedVipManager
   {
      
      private static var _instance:CustomizedVipManager;
      
      private var _model:CustomizedVipModel;
      
      public function CustomizedVipManager()
      {
         super();
      }
      
      public static function get instance() : CustomizedVipManager
      {
         if(!_instance)
         {
            _instance = new CustomizedVipManager();
         }
         return _instance;
      }
      
      public function get model() : CustomizedVipModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new CustomizedVipModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4277,__customizedVipInfoBack);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__customizedVipTopBtnHandler);
      }
      
      private function __customizedVipInfoBack(param1:SLGSocketEvent) : void
      {
         var _loc3_:CustomizedVipBoxInfo = null;
         var _loc6_:CustomizedVipItemInfo = null;
         var _loc4_:Array = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:CustomizedVipMsg = new CustomizedVipMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as CustomizedVipMsg;
         if(_loc2_.hasFreeCount)
         {
            model.vipFreeCount = _loc2_.freeCount;
         }
         if(_loc2_.hasBuyCounts)
         {
            model.resloveBuyCount(_loc2_.buyCounts);
         }
         if(_loc2_.hasBoxVersion)
         {
            if(model.boxVersion != _loc2_.boxVersion)
            {
               model.clientBoxDic.clear();
               model.frameSelectDic.clear();
            }
            model.boxVersion = _loc2_.boxVersion;
         }
         for each(var _loc5_:CustomizedVipBoxMsg in _loc2_.boxs)
         {
            if(_loc5_.type == 0)
            {
               _loc3_ = new CustomizedVipBoxInfo();
               model.vipBoxRewardInfo = _loc3_;
            }
            else
            {
               _loc3_ = model.customizedBoxDic[_loc5_.type];
               if(!_loc3_)
               {
                  _loc3_ = new CustomizedVipBoxInfo();
                  model.customizedBoxDic.add(_loc5_.type,_loc3_);
               }
            }
            _loc3_.type = _loc5_.type;
            _loc3_.price = _loc5_.price;
            _loc3_.maxCount = _loc5_.maxCount;
            _loc3_.customizedItemDic.clear();
            for each(var _loc7_:CustomizedVipItemMsg in _loc5_.items)
            {
               _loc6_ = new CustomizedVipItemInfo();
               _loc6_.tempId = _loc7_.templateId;
               _loc6_.count = _loc7_.count;
               _loc6_.area = _loc7_.area;
               if(!_loc3_.customizedItemDic[_loc7_.area])
               {
                  _loc4_ = [];
               }
               else
               {
                  _loc4_ = _loc3_.customizedItemDic[_loc7_.area];
               }
               _loc4_.push(_loc6_);
               _loc3_.customizedItemDic.add(_loc7_.area,_loc4_);
            }
         }
         MsgMan.notifyObserver("CUSTOMIZED_INFO_CHANGE",_loc2_.op);
      }
      
      private function __customizedVipTopBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 2064)
         {
            model.isOpen = _loc2_.param7;
            model.isFlicker = _loc2_.param8;
            model.startDate = DateFormatter.parse(_loc2_.param4,"YYYY-MM-DD hh:mm:ss");
            model.endDate = DateFormatter.parse(_loc2_.param5,"YYYY-MM-DD hh:mm:ss");
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      public function sendCustomizedVipReq(param1:int, param2:int = 0, param3:int = 1, param4:String = "") : void
      {
         var _loc6_:PackageOut = new PackageOut(9645,0,41);
         var _loc5_:PlayerOpMsg = new PlayerOpMsg();
         _loc5_.op = param1;
         _loc5_.type = param2;
         _loc5_.param1 = param4;
         _loc5_.count = param3;
         _loc5_.id = model.boxVersion;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

