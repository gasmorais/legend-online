package yishi.manager
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import yishi.interfaces.IEnterFrame;
   
   public class EnterFrameManager
   {
      
      private static var _instance:EnterFrameManager;
      
      public static const LOW_FRAME:int = 16;
      
      private var tfDelay:int = 0;
      
      private var tfTimer:int;
      
      private var preFrame:int;
      
      private var _currentFrame:int = 25;
      
      private var _items:Dictionary;
      
      public var enterFrameCount:int;
      
      public function EnterFrameManager()
      {
         super();
      }
      
      public static function get instance() : EnterFrameManager
      {
         if(!_instance)
         {
            _instance = new EnterFrameManager();
         }
         return _instance;
      }
      
      public function setup(param1:Stage) : void
      {
         if(_items)
         {
            return;
         }
         _items = new Dictionary(true);
         param1.addEventListener("enterFrame",__enterFrameHandler);
         tfTimer = getTimer();
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         enterFrameCount = enterFrameCount + 1;
         for each(var _loc2_:IEnterFrame in _items)
         {
            _loc2_.enterFrame();
         }
         tfDelay = tfDelay + 1;
         if(getTimer() - tfTimer > 1000)
         {
            _currentFrame = 1000 * tfDelay / (getTimer() - tfTimer);
            tfTimer = getTimer();
            tfDelay = 0;
         }
         if(enterFrameCount % 25 == 0)
         {
         }
      }
      
      public function get currentFrame() : int
      {
         return _currentFrame;
      }
      
      public function registeEnterFrame(param1:IEnterFrame) : void
      {
         for(var _loc2_:Object in _items)
         {
            if(!_items[_loc2_])
            {
               delete _items[_loc2_];
            }
         }
         _items[param1] = param1;
      }
      
      public function getMessage() : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         for each(var _loc1_:IEnterFrame in _items)
         {
            _loc3_++;
            _loc2_ += _loc3_ + " : " + getQualifiedClassName(_loc1_) + "\n";
         }
         return _loc2_;
      }
      
      public function unRegisteEnterFrame(param1:IEnterFrame) : void
      {
         _items[param1] = null;
         delete _items[param1];
      }
   }
}

