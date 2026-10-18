package yishi.events
{
   import flash.events.Event;
   
   public class FundEvent extends Event
   {
      
      public static const SHOWTOPBTN:String = "SHOWTOPBTN";
      
      public static const SHOWGET:String = "SHOWGET";
      
      public static const OPEN:String = "OPEN";
      
      public function FundEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

