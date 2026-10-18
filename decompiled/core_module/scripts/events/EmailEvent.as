package events
{
   import flash.events.Event;
   import mvc.module.emailII.EmailInfo;
   
   public class EmailEvent extends Event
   {
      
      public static const NEW_BATTLEREPORT_CHANGE:String = "NEW_BATTLEREPORT_CHANGE";
      
      public static const EMAIL_CLOSE:String = "EMAIL_CLOSE";
      
      public static const EMAIL_STARTREAD:String = "EMAIL_STARTREAD";
      
      public static const EMAIL_OPEN:String = "EMAIL_OPEN";
      
      public static const ANNEX_CALLBACK:String = "ANNEX_CALLBACK";
      
      public static const VIEW_READSTATE_CHANGE:String = "VIEW_READSTATE_CHANGE";
      
      public static const VIEW_EMAILTYPE_CHANGE:String = "VIEW_EMAILTYPE_CHANGE";
      
      public static const VIEW_PAGE_CHANGE:String = "VIEW_PAGE_CHANGE";
      
      public static const VIEW_ALL_SELECTED:String = "VIEW_ALL_SELECTED";
      
      public static const EMAIL_SELECTED:String = "EMAIL_SELECTED";
      
      public static const VIEW_CURRENTREAD_CHANGE:String = "VIEW_CURRENTREAD_CHANGE";
      
      public static const DATA_EMAIL_DELETE:String = "DATA_EMAIL_DELETE";
      
      public static const DATA_EMAIL_UPDATE:String = "DATA_EMAIL_UPDATE";
      
      public static const DATA_EMAIL_NEW:String = "DATA_EMAIL_NEW";
      
      private var _data:EmailInfo;
      
      private var _list:Array;
      
      public function EmailEvent(param1:String, param2:EmailInfo = null, param3:Array = null)
      {
         super(param1,false,false);
         _data = param2;
         _list = param3;
      }
      
      public function get data() : EmailInfo
      {
         return _data;
      }
      
      public function get list() : Array
      {
         return _list;
      }
   }
}

