package dragonBones.utils
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class XMLParserEventUtil extends EventDispatcher
   {
      
      private static var _instance:XMLParserEventUtil;
      
      public var isDispatcher:Boolean = false;
      
      public function XMLParserEventUtil(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : XMLParserEventUtil
      {
         if(_instance == null)
         {
            _instance = new XMLParserEventUtil();
         }
         return _instance;
      }
   }
}

