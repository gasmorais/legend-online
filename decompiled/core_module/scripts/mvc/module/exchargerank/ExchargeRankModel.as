package mvc.module.exchargerank
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class ExchargeRankModel extends EventDispatcher
   {
      
      private static var _instance:ExchargeRankModel;
      
      public var topBagList:Vector.<FunnyBagData>;
      
      public var canShine:Boolean = true;
      
      private var _data:Vector.<ExchargeData>;
      
      private var _otherDataDic:Dictionary;
      
      public var _loaded:Dictionary = new Dictionary(true);
      
      public var _createDate:Date;
      
      private var _exchargeRankList:Array;
      
      public function ExchargeRankModel()
      {
         super();
         if(_data == null)
         {
            _data = new Vector.<ExchargeData>();
         }
         if(_otherDataDic == null)
         {
            _otherDataDic = new Dictionary();
         }
         _otherDataDic[196] = [];
         _exchargeRankList = [];
      }
      
      public static function get instance() : ExchargeRankModel
      {
         if(!_instance)
         {
            _instance = new ExchargeRankModel();
         }
         return _instance;
      }
      
      public function get data() : Vector.<ExchargeData>
      {
         return _data;
      }
      
      public function set data(param1:Vector.<ExchargeData>) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function findExchargeDataByTypeAndId(param1:int, param2:String) : ExchargeData
      {
         var _loc3_:ExchargeData = null;
         var _loc4_:int = 0;
         if(_otherDataDic[param1])
         {
            _loc4_ = 0;
            while(_loc4_ < _otherDataDic[param1].length)
            {
               if(_otherDataDic[param1][_loc4_].id == param2)
               {
                  _loc3_ = _otherDataDic[param1][_loc4_] as ExchargeData;
               }
               _loc4_++;
            }
         }
         if(_loc3_ == null)
         {
            _loc4_ = 0;
            while(_loc4_ < data.length)
            {
               if(data[_loc4_] && data[_loc4_].id == param2)
               {
                  _loc3_ = data[_loc4_];
               }
               _loc4_++;
            }
         }
         if(_loc3_ && _loc3_.showStart < playerModel.nowDate && _loc3_.showEnd > playerModel.nowDate)
         {
            return _loc3_;
         }
         return null;
      }
      
      public function get exchargeRankList() : Array
      {
         return _exchargeRankList;
      }
      
      public function set exchargeRankList(param1:Array) : void
      {
         _exchargeRankList = param1;
         dispatchEvent(new FunnyEvent("EXCHARGE_RANK"));
      }
   }
}

