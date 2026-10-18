package funny
{
   import flash.events.Event;
   
   public class FunnyEvent extends Event
   {
      
      public static const REFRESH_TEMP:String = "REFRESH_TEMP";
      
      public static const REFRESH_ITEM:String = "REFRESH_ITEM";
      
      public static const REFRESH_KARNEVAL:String = "REFRESH_KARNEVAL";
      
      public static const ITEM_CANGET:String = "ITEM_CANGET";
      
      public static const TIROITEM_CHANGE:String = "TIROITEM_CHANGE";
      
      public static const SHOWTIROEFFECT:String = "SHOWTIROEFFECT";
      
      public static const EXCHARGE_RANK:String = "EXCHARGE_RANK";
      
      public static const REFRESH_REGRESS_REWARD:String = "REFRESH_REGRESS_REWARD";
      
      public static const REFRESH_CROSSCOST_REWARD:String = "REFRESH_CROSSCOST_REWARD";
      
      public static const REFRESH_NOTCROSSCOST_REWARD:String = "REFRESH_NOTCROSSCOST_REWARD";
      
      public static const REFRESH_CURRENT_COST:String = "REFRESH_CURRENT_COST";
      
      public static const REFRESH_CROSS_DATA:String = "REFRESH_CROSS_DATA";
      
      public static const REFRESH_CROSS_RANKDATA:String = "REFRESH_CROSS_RANKDATA";
      
      public static const CROSS_COSTITEM_CANGET:String = "CROSS_COSTITEM_CANGET";
      
      public static const CROSS_PAY_CANGET:String = "CROSS_PAY_CANGET";
      
      public static const REFRESH_ITEM2:String = "REFRESH_ITEM";
      
      public static const CROSS_COST_TEMP:String = "CROSS_COST_TEMP";
      
      public static const LOGIN_ACTIVE_CHANGE:String = "LOGIN_ACTIVE_CHANGE";
      
      public var data:Object;
      
      public function FunnyEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

