package stelesys.view
{
   public class StelaSwitchObj
   {
      
      public var stars:Array = [];
      
      public var colors:Array = [];
      
      public function StelaSwitchObj()
      {
         super();
      }
      
      public function reset() : void
      {
         stars.length = 0;
         colors.length = 0;
      }
   }
}

