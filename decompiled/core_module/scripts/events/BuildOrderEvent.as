package events
{
   import flash.events.Event;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   
   public class BuildOrderEvent extends Event
   {
      
      public static const ADD_ONE_ORDER:String = "ADD_ONE_ORDER";
      
      public static const USE_ONE_ORDER:String = "USE_ONE_ORDER";
      
      public static const COLL_ONE_ORDER:String = "COLL_ONE_ORDER";
      
      public static const UPDATE_ORDER:String = "UPDATE_ORDER";
      
      private var _order:BuildingOrderInfo;
      
      public function BuildOrderEvent(param1:String, param2:BuildingOrderInfo)
      {
         _order = param2;
         super(param1,false,false);
      }
      
      public function get order() : BuildingOrderInfo
      {
         return _order;
      }
   }
}

