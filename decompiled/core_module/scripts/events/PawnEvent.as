package events
{
   import flash.events.Event;
   
   public class PawnEvent extends Event
   {
      
      public static const PAWN_PROPERTY_CHAGER:String = "pawnProppertyChager";
      
      public static const SPECIAL_ALIBITY:String = "SPECIAL_ALIBITY";
      
      public static const SPECIAL_BLESS:String = "SPECIAL_BLESS";
      
      public static const ENTERWAR_PAWN_SELECT:String = "ENTERWAR_PAWN_SELECT";
      
      public var data:Object;
      
      public function PawnEvent(param1:String, param2:Object)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

