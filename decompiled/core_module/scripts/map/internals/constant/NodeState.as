package map.internals.constant
{
   public class NodeState
   {
      
      public static const NONE:int = 0;
      
      public static const EXIST:int = 1;
      
      public static const FRIENDLY:int = 2;
      
      public static const FIGHTING:int = 4;
      
      public static const DESTROYED:int = 8;
      
      public static const HIDE:int = 9;
      
      public static const STATE2:int = 16;
      
      public static const STATE3:int = 17;
      
      public static const BONFIRE_OFF:int = 19;
      
      public static const BONFIRE_ON:int = 20;
      
      public function NodeState()
      {
         super();
      }
      
      public static function getStateValue(param1:int) : String
      {
         switch(param1 - 16)
         {
            case 0:
               return "state2";
            case 1:
               return "state3";
            default:
               return "";
         }
      }
      
      public static function isOppositionState(param1:int) : Boolean
      {
         switch(param1)
         {
            case 0:
            case 2:
            case 8:
            case 9:
               return false;
            default:
               return true;
         }
      }
      
      public static function displayState(param1:int) : Boolean
      {
         switch(param1 - 1)
         {
            case 0:
            case 1:
            case 3:
            case 15:
            case 16:
               return true;
            default:
               return false;
         }
      }
   }
}

