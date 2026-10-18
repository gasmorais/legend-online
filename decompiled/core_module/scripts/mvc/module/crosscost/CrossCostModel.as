package mvc.module.crosscost
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class CrossCostModel extends EventDispatcher
   {
      
      private static var _instance:CrossCostModel;
      
      public var topBagList:Vector.<FunnyBagData>;
      
      private var _crossCostRankList:Array = [];
      
      public var _loaded:Dictionary = new Dictionary(true);
      
      public var len:int;
      
      public function CrossCostModel()
      {
         super();
      }
      
      public static function get instance() : CrossCostModel
      {
         if(!_instance)
         {
            _instance = new CrossCostModel();
         }
         return _instance;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get crossCostRankList() : Array
      {
         return _crossCostRankList;
      }
      
      public function set crossCostRankList(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         if(_crossCostRankList == param1)
         {
            return;
         }
         _crossCostRankList = param1;
         dispatchEvent(new FunnyEvent("REFRESH_CROSS_RANKDATA"));
      }
   }
}

