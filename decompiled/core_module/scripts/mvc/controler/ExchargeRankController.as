package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.utils.Timer;
   import mvc.FrameController;
   import mvc.module.exchargerank.ExchargeRankData;
   import mvc.module.exchargerank.ExchargeRankModel;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class ExchargeRankController extends FrameController
   {
      
      public static var _leftRefreshHours:int = -1;
      
      private var _instance:ExchargeRankController;
      
      private var _model:ExchargeRankModel;
      
      private var _arr:Array;
      
      private var _isSort:Boolean;
      
      private var _list:XMLList;
      
      private var _day:int;
      
      private var _timer:Timer;
      
      private var _newDataArray:Array;
      
      public var isOpenCrossPayFrame:Boolean;
      
      public function ExchargeRankController()
      {
         super();
         _model = new ExchargeRankModel();
      }
      
      override public function get frameClassName() : String
      {
         return "excharerank.main";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function get model() : ExchargeRankModel
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
         var _loc1_:String = "chargerank.xml";
         if(PlayerManager.instance.currentPlayerModel.sysCurtime.hours != _leftRefreshHours || !_model._loaded[_loc1_])
         {
            loadData(_loc1_);
         }
         else
         {
            _model.exchargeRankList = sortArray(_arr);
         }
      }
      
      public function loadData(param1:String) : void
      {
         param1 = PathManager.orderPath + param1;
         LoaderManagerII.instance.load(param1,5,8,__onXMLDataLoaded);
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
         resolveExchargeRankXML(param1);
      }
      
      private function resolveExchargeRankXML(param1:XML) : void
      {
         var _loc3_:String = null;
         var _loc2_:Date = null;
         if(param1 != null)
         {
            _list = param1.ChargeRank;
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
            _model.exchargeRankList = sortArray(_arr);
         }
      }
      
      public function read() : void
      {
         var _loc3_:ExchargeRankData = null;
         var _loc1_:Array = null;
         if(_list)
         {
            _day = -1;
            _arr = [];
            for each(var _loc2_:XML in _list)
            {
               _loc3_ = new ExchargeRankData();
               _loc3_.rank = int(_loc2_.@rank);
               _loc3_.nickName = String(_loc2_.@nickName);
               _loc3_.fightPower = int(_loc2_.@fightPower);
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
         _model.exchargeRankList = sortArray(_arr);
      }
      
      private function sortArray(param1:Array) : Array
      {
         var _loc2_:int = 0;
         _newDataArray = new Array(6);
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_][0].day == 0)
               {
                  _newDataArray[0] = param1[_loc2_];
               }
               if(param1[_loc2_][0].day == 1)
               {
                  _newDataArray[1] = param1[_loc2_];
               }
               if(param1[_loc2_][0].day == 2)
               {
                  _newDataArray[2] = param1[_loc2_];
               }
               if(param1[_loc2_][0].day == 3)
               {
                  _newDataArray[3] = param1[_loc2_];
               }
               if(param1[_loc2_][0].day == 4)
               {
                  _newDataArray[4] = param1[_loc2_];
               }
               if(param1[_loc2_][0].day == 5)
               {
                  _newDataArray[5] = param1[_loc2_];
               }
               _loc2_++;
            }
         }
         return _newDataArray;
      }
   }
}

