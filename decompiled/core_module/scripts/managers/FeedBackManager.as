package managers
{
   import com.road.yishi.proto.rebate.PackageInfoMsg;
   import com.road.yishi.proto.rebate.PackageStateMsg;
   import com.road.yishi.proto.rebate.RebateInfoMsg;
   import com.road.yishi.proto.rebate.UserRebateMsg;
   import feedback.FeedBackEvent;
   import feedback.datas.FeedBackData;
   import feedback.datas.FeedBackItemData;
   import flash.events.EventDispatcher;
   import ui.toptoolbar.TopToolsBar;
   import yishi.comm.PackageIn;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class FeedBackManager extends EventDispatcher
   {
      
      private static var _instance:FeedBackManager;
      
      private var _data:FeedBackData;
      
      private var _itemList:Array = [];
      
      public var switchBtn1:Boolean;
      
      public var allReceived:Boolean;
      
      public var needShine:Boolean = false;
      
      public function FeedBackManager()
      {
         super();
      }
      
      public static function get instance() : FeedBackManager
      {
         if(!_instance)
         {
            _instance = new FeedBackManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _data = new FeedBackData();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4461,__rebateActiveHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4463,__rebateDataHandler);
      }
      
      private function __rebateActiveHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:FeedBackItemData = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RebateInfoMsg = new RebateInfoMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RebateInfoMsg;
         if(_loc2_.id == null || _loc2_.id + "" == "undefined" || _loc2_.id == "")
         {
            switchBtn1 = false;
            TopToolsBar.instance.show();
            dispatchEvent(new FeedBackEvent("FEEDBACK_DELETE_ACTIVE"));
            return;
         }
         _data.id = _loc2_.id;
         _data.startTime = DateFormatter.parse(_loc2_.beginDate,"YYYY-MM-DD hh:mm:ss").getTime() / 1000;
         _data.endTime = DateFormatter.parse(_loc2_.endDate,"YYYY-MM-DD hh:mm:ss").getTime() / 1000;
         _data.type = _loc2_.type;
         _itemList = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.packages.length)
         {
            _loc3_ = readFeedBackItemData(_loc2_.packages[_loc4_]);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         switchBtn1 = true;
         TopToolsBar.instance.show();
         SocketSendManager.instance.sendGetFeedBack(_data.id,null,1);
      }
      
      private function readFeedBackItemData(param1:PackageInfoMsg) : FeedBackItemData
      {
         var _loc2_:Object = null;
         var _loc3_:FeedBackItemData = new FeedBackItemData();
         var _loc4_:int = 0;
         var _loc5_:Array = [];
         _loc4_ = 1;
         while(_loc4_ <= 8)
         {
            _loc2_ = {};
            _loc2_["temId"] = param1["itemid" + _loc4_];
            _loc2_["count"] = param1["count" + _loc4_];
            if(_loc2_["temId"] != 0)
            {
               _loc5_.push(_loc2_);
            }
            _loc4_++;
         }
         _loc5_.sort(sortMasterType);
         _loc3_.id = param1.packageId;
         _loc3_.order = param1.order;
         _loc3_.point = param1.point;
         _loc3_.price = param1.price;
         _loc4_ = 1;
         while(_loc4_ <= 8)
         {
            if(_loc4_ <= _loc5_.length)
            {
               _loc3_["goodsId" + _loc4_] = _loc5_[_loc4_ - 1]["temId"];
               _loc3_["count" + _loc4_] = _loc5_[_loc4_ - 1]["count"];
            }
            else
            {
               _loc3_["goodsId" + _loc4_] = 0;
               _loc3_["count" + _loc4_] = 0;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function sortMasterType(param1:Object, param2:Object) : int
      {
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.temId);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.temId);
         var _loc4_:int = 0;
         if(_loc5_ && !_loc3_)
         {
            _loc4_ = -1;
         }
         else if(!_loc5_ && _loc3_)
         {
            _loc4_ = 1;
         }
         else if(!_loc5_ && !_loc3_)
         {
            _loc4_ = 0;
         }
         else if(_loc5_.Profile > _loc3_.Profile)
         {
            _loc4_ = -1;
         }
         else if(_loc5_.Profile < _loc3_.Profile)
         {
            _loc4_ = 1;
         }
         else if(_loc5_.MasterType > _loc3_.MasterType)
         {
            _loc4_ = 1;
         }
         else if(_loc5_.MasterType < _loc3_.MasterType)
         {
            _loc4_ = -1;
         }
         _loc5_ = null;
         _loc3_ = null;
         return _loc4_;
      }
      
      private function __rebateDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:UserRebateMsg = new UserRebateMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as UserRebateMsg;
         if(_loc2_.id != _data.id || _loc2_.userid != PlayerManager.instance.currentPlayerModel.userInfo.userId || _loc2_.type != _data.type)
         {
            return;
         }
         _data.userPoint = _loc2_.point;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.packagestates.length)
         {
            for each(var _loc3_:FeedBackItemData in _itemList)
            {
               if(_loc3_.id == (_loc2_.packagestates[_loc4_] as PackageStateMsg).id)
               {
                  _loc3_.state = (_loc2_.packagestates[_loc4_] as PackageStateMsg).isget;
                  if(!_loc3_.state && _data.userPoint >= _loc3_.point)
                  {
                     needShine = true;
                  }
               }
            }
            _loc4_++;
         }
         allReceived = true;
         dispatchEvent(new FeedBackEvent("FEEDBACK_RECEIVE_USERINFO"));
         InfoTipsManager.instance.dealData(21);
      }
      
      public function get data() : FeedBackData
      {
         return _data;
      }
      
      public function get list() : Array
      {
         _itemList.sortOn("order",16);
         return _itemList;
      }
   }
}

