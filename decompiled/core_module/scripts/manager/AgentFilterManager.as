package manager
{
   public class AgentFilterManager
   {
      
      private static var _Instance:AgentFilterManager;
      
      private static var _hasSetup:Boolean = false;
      
      private var _agentFilter:Array;
      
      public function AgentFilterManager()
      {
         super();
         _agentFilter = [];
      }
      
      public static function get hasSetup() : Boolean
      {
         return _hasSetup;
      }
      
      public static function get Instance() : AgentFilterManager
      {
         if(!_Instance)
         {
            _Instance = new AgentFilterManager();
         }
         return _Instance;
      }
      
      public function setup(param1:Object) : void
      {
         var _loc2_:Array = (param1 as String).toLocaleLowerCase().split("\n");
         _agentFilter = _loc2_[0].split("|");
         _hasSetup = true;
      }
      
      public function get agentFilter() : Array
      {
         return _agentFilter;
      }
   }
}

