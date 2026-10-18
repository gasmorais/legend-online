package yishi.events
{
   import flash.events.Event;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class RequestInfoEvent extends Event
   {
      
      public static const REQUEST_SIMPLEINFO:String = "REQUEST_SIMPLEINFO";
      
      public static const REQUEST_SIMPLEANDSNS_INFO:String = "REQUEST_SIMPLEANDSNS_INFO";
      
      public static const QUERY_PETDATA_RESULT:String = "QUERY_PETDATA_RESULT";
      
      public static const QUERY_CHILDDATA_RESULT:String = "QUERY_CHILDDATA_RESULT";
      
      private var _orientation:int;
      
      private var _data:ThaneInfo;
      
      public var info:Object;
      
      public function RequestInfoEvent(param1:String, param2:int, param3:ThaneInfo, param4:Object = null)
      {
         _orientation = param2;
         _data = param3;
         this.info = param4;
         super(param1,false,false);
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function get orientation() : int
      {
         return _orientation;
      }
   }
}

