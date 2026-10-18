package map.campaign.data
{
   public class MouseData
   {
      
      public static const ON_DRAG:String = "ON_DRAG";
      
      public static const BACK_DRAG:String = "BACK_DRAG";
      
      public static const CLICK:String = "CLICK";
      
      public static const NORMAL:String = "Normal";
      
      public static const LOCK:String = "Lock";
      
      private static var _instance:MouseData;
      
      private var _curState:String;
      
      public function MouseData()
      {
         super();
         curState = "Normal";
      }
      
      public static function get instance() : MouseData
      {
         if(!_instance)
         {
            _instance = new MouseData();
         }
         return _instance;
      }
      
      public function get curState() : String
      {
         return _curState;
      }
      
      public function set curState(param1:String) : void
      {
         _curState = param1;
      }
   }
}

