package bag.events
{
   import flash.events.Event;
   import yishi.datas.goods.GoodsInfo;
   
   public class BagEvent extends Event
   {
      
      public static const BAG_GOODS_CHANGE:String = "BAG_GOODS_CHANGE";
      
      public static const UPDATE_BAG:String = "UPDATE_BAG";
      
      public static const DELETE_BAG:String = "DELETE_BAG";
      
      public static const ADD_GOODS:String = "ADD_GOODS";
      
      public static const NEW_GOODS:String = "NEW_GOODS";
      
      public static const INTENSIFY_GOODS:String = "INTENSIFY_GOODS";
      
      public static const FILTER_GOODS:String = "FILTER_GOODS";
      
      public static const CHECK_BAG_FULL:String = "BAG_FULL";
      
      public static const RETURN_REFRESH:String = "RETURN_REFRESH";
      
      public static const UPDATE_BOTTLE_BAG:String = "UPDATE_BOTTLE_BAG";
      
      public static const DELETE_BOTTLE_BAG:String = "DELETE_BOTTLE_BAG";
      
      public static const DELETE_FISH_BAG:String = "DELETE_FISH_BAG";
      
      public static const SELL_GOODS:String = "SELL_GOODS";
      
      public static const SELLITEM_DELETE:String = "SELLITEM_DELETE";
      
      public static const COUNT_CHANGE:String = "COUNT_CHANGE";
      
      public static const FILTR_BY_SELL:String = "FILTR_BY_SELL";
      
      public static const ATTRIBUTE_CLICK:String = "ATTRIBUTE_CLICK";
      
      public static const DELETE_TREASURE_MAP:String = "DELETE_TREASURE_MAP";
      
      public static const DELETE_MARRY_TASK_MAP:String = "DELETE_MARRY_TASK_MAP";
      
      public static const UPDATE_GOLDROAD_BAG:String = "UPDATE_GOLDROAD_BAG";
      
      public static const DELETE_GOLDROAD_BAG:String = "DELETE_GOLDROAD_BAG";
      
      public static const UPDATE_EQUIP:String = "UPDATE_EQUIP";
      
      public static const DELETE_EQUIP:String = "DELETE_EQUIP";
      
      public static const UPDATE_CHRISTMASTREE_BAG:String = "UPDATE_CHRISTMASTREE_BAG";
      
      public static const DELETE_CHRISTMASTREE_BAG:String = "DELETE_CHRISTMASTREE_BAG";
      
      private var _info:GoodsInfo;
      
      private var _list:Array;
      
      public function BagEvent(param1:String, param2:GoodsInfo, param3:Array = null, param4:Boolean = false)
      {
         super(param1,param4,false);
         _info = param2;
         _list = param3;
      }
      
      public function get info() : GoodsInfo
      {
         return _info;
      }
      
      public function get list() : Array
      {
         return _list;
      }
   }
}

