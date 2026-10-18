package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.yishi.proto.active.ChargeRewardMsg;
   import mvc.FrameController;
   import mvc.module.crosscost.CrossCostItemData;
   import mvc.module.crosscost.CrossCostModel;
   import yishi.comm.PackageOut;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   
   public class CrossCostController extends FrameController
   {
      
      public static var _leftRefreshHours:int = -1;
      
      private var _model:CrossCostModel;
      
      private var _arr:Array;
      
      private var _newDataArray:Array;
      
      private var _day:int;
      
      private var _list:XMLList;
      
      public var isOpenCrossCostFrame:Boolean;
      
      public function CrossCostController()
      {
         super();
         _model = new CrossCostModel();
      }
      
      override public function get frameClassName() : String
      {
         return "crosscost.CrossCostFrame";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function get model() : CrossCostModel
      {
         return _model;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function loadXML() : void
      {
         var _loc1_:String = "consumrank_unzip.xml";
         if(PlayerManager.instance.currentPlayerModel.sysCurtime.hours != _leftRefreshHours || !_model._loaded[_loc1_])
         {
            loadData(_loc1_);
         }
         else
         {
            _model.crossCostRankList = sortArray(_arr);
         }
      }
      
      public function loadData(param1:String) : void
      {
         param1 = PathManager.orderPath + param1;
         LoaderManagerII.instance.load(param1,8,8,__onXMLDataLoaded);
      }
      
      private function __onXMLDataLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:String = param1.url;
         _loc4_ = _loc4_.replace(PathManager.orderPath,"");
         var _loc3_:int = _loc4_.indexOf("?");
         if(_loc3_ != -1)
         {
            _loc4_ = _loc4_.substring(0,_loc3_);
         }
         _model._loaded[_loc4_] = true;
         resolveXML(new XML(param2));
      }
      
      private function resolveXML(param1:XML) : void
      {
         var _loc3_:String = null;
         var _loc2_:Date = null;
         if(param1 != null)
         {
            _list = param1.ConsumRank;
            if(param1.info[0])
            {
               _loc3_ = param1.info[0].@createDate;
               _loc3_ = _loc3_.substring(0,_loc3_.indexOf("."));
               _loc2_ = DateFormatter.parse(_loc3_,"YYYY-MM-DD hh:mm:ss");
               _leftRefreshHours = _loc2_.hours;
            }
            read();
         }
         else
         {
            _model.crossCostRankList = sortArray(_arr);
         }
      }
      
      public function read() : void
      {
         var _loc3_:CrossCostItemData = null;
         var _loc1_:Array = null;
         if(_list)
         {
            _day = -1;
            _arr = [];
            for each(var _loc2_:XML in _list)
            {
               _loc3_ = new CrossCostItemData();
               _loc3_.rank = int(_loc2_.@rank);
               _loc3_.nickName = String(_loc2_.@nickName);
               _loc3_.grade = int(_loc2_.@level);
               _loc3_.agencyServer = String(_loc2_.@serverName);
               _loc3_.amount = _loc2_.@amount;
               _loc3_.isVip = int(_loc2_.@vip);
               _loc3_.day = int(_loc2_.@day);
               if(_day != _loc2_.@day)
               {
                  _loc1_ = [];
                  _loc1_.push(_loc3_);
                  _arr.push(_loc1_);
                  _day = _loc2_.@day;
               }
               else
               {
                  _loc1_.push(_loc3_);
               }
            }
         }
         _model.crossCostRankList = sortArray(_arr);
      }
      
      private function sortArray(param1:Array) : Array
      {
         var _loc3_:int = 0;
         _newDataArray = new Array(4);
         if(!param1)
         {
            return null;
         }
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_][0].day == 1)
            {
               _newDataArray[0] = param1[_loc3_];
            }
            else if(param1[_loc3_][0].day == 2)
            {
               _newDataArray[1] = param1[_loc3_];
            }
            else if(param1[_loc3_][0].day == 3)
            {
               _newDataArray[2] = param1[_loc3_];
            }
            else if(param1[_loc3_][0].day == 0)
            {
               _newDataArray[3] = param1[_loc3_];
            }
            _loc3_++;
         }
         return _newDataArray;
      }
      
      public function sendInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(9602);
         var _loc1_:ChargeRewardMsg = new ChargeRewardMsg();
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
   }
}

