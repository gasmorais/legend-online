package yishi.manager
{
   import com.road.yishi.proto.archaeology.ArchaeologyItemListMsg;
   import com.road.yishi.proto.archaeology.ArchaeologyItemMsg;
   import com.road.yishi.proto.archaeology.ArchaeologyReqMsg;
   import com.road.yishi.proto.archaeology.ArchaeologyRewardStateMsg;
   import com.road.yishi.proto.archaeology.ArchaeologyRspMsg;
   import mvc.module.archeology.ArchaeologyHandBookInfo;
   import mvc.module.archeology.ArchaeologyItemInfo;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class ArchaeologyManager
   {
      
      private static var _instance:ArchaeologyManager;
      
      private var _model:ArchaeologyModel;
      
      public function ArchaeologyManager()
      {
         super();
         if(!_model)
         {
            _model = new ArchaeologyModel();
         }
      }
      
      public static function get instance() : ArchaeologyManager
      {
         if(!_instance)
         {
            _instance = new ArchaeologyManager();
         }
         return _instance;
      }
      
      public function get model() : ArchaeologyModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 296,__getArchaeologyBookData);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 298,__updateArchaelogyGoodList);
      }
      
      private function __getArchaeologyBookData(param1:SLGSocketEvent) : void
      {
         var _loc3_:ArchaeologyHandBookInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArchaeologyRspMsg = new ArchaeologyRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ArchaeologyRspMsg;
         for each(var _loc4_:ArchaeologyRewardStateMsg in _loc2_.bookRewardState)
         {
            _loc3_ = model.getHandBookInfoById(_loc4_.tempId);
            if(_loc3_ == null)
            {
               _loc3_ = new ArchaeologyHandBookInfo();
               model.handBookStateArr.push(_loc3_);
            }
            _loc3_.tempId = _loc4_.tempId;
            _loc3_.isGet = _loc4_.getAlready;
         }
         MsgMan.notifyObserver("ARCHAEOLOGY_BOOK_DATA");
         InfoTipsManager.instance.updateValue(30,model.getArchaeologyBtnTotalCount());
      }
      
      private function __updateArchaelogyGoodList(param1:SLGSocketEvent) : void
      {
         var _loc4_:ArchaeologyItemInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArchaeologyItemListMsg = new ArchaeologyItemListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ArchaeologyItemListMsg;
         for each(var _loc3_:ArchaeologyItemMsg in _loc2_.updateItem)
         {
            _loc4_ = model.getItemInfoById(_loc3_.tempId);
            if(_loc4_ == null)
            {
               _loc4_ = new ArchaeologyItemInfo();
               model.goodsArr.push(_loc4_);
            }
            _loc4_.tempId = _loc3_.tempId;
            _loc4_.chipCount = _loc3_.chipCount;
            _loc4_.itemCount = _loc3_.itemCount;
         }
         model.getTypeBtnCanComposeCount();
         MsgMan.notifyObserver("GOOD_lIST_UPDATE");
         InfoTipsManager.instance.updateValue(30,model.getArchaeologyBtnTotalCount());
      }
      
      public function sendArchaeologyRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9575);
         var _loc3_:ArchaeologyReqMsg = new ArchaeologyReqMsg();
         _loc3_.op = param1;
         _loc3_.tempId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

