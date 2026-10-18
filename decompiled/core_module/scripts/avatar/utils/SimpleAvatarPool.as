package avatar.utils
{
   import avatar.data.SimpleAvatarInfo;
   import flash.utils.Dictionary;
   
   public class SimpleAvatarPool
   {
      
      private static var _instance:SimpleAvatarPool;
      
      private var _dataPool:Dictionary;
      
      private var _tagPool:Dictionary;
      
      public function SimpleAvatarPool(param1:Boolean = false)
      {
         _dataPool = new Dictionary(param1);
         _tagPool = new Dictionary(param1);
         super();
      }
      
      public static function get instance() : SimpleAvatarPool
      {
         if(!_instance)
         {
            _instance = new SimpleAvatarPool();
         }
         return _instance;
      }
      
      private function urlCount(param1:String) : String
      {
         return param1 + "_count";
      }
      
      private function urlLoad(param1:String) : String
      {
         return param1 + "_load";
      }
      
      public function registerSimpleAvatarLoader(param1:String) : void
      {
         _tagPool[urlLoad(param1)] = true;
      }
      
      public function unregisterSimpleAvatarLoader(param1:String) : void
      {
         delete _tagPool[urlLoad(param1)];
      }
      
      public function existSimpleAvatarLoader(param1:String) : Boolean
      {
         if(_tagPool[urlLoad(param1)])
         {
            return true;
         }
         return false;
      }
      
      public function addSimpleAvatar(param1:String, param2:SimpleAvatarInfo) : void
      {
         if(!_dataPool[param1])
         {
            param2.key = param1;
            _dataPool[param1] = param2;
            _tagPool[urlCount(param1)] = 1;
         }
         else
         {
            _tagPool[urlCount(param1)]++;
         }
      }
      
      public function getSimapleAvatar(param1:String) : SimpleAvatarInfo
      {
         if(_dataPool[param1])
         {
            _tagPool[urlCount(param1)]++;
            return _dataPool[param1];
         }
         return null;
      }
      
      public function releaseSimpleAvatar(param1:String) : void
      {
         _tagPool[urlCount(param1)]--;
         if(_tagPool[urlCount(param1)] <= 0)
         {
            (_dataPool[param1] as SimpleAvatarInfo).dispose();
            delete _dataPool[param1];
            delete _tagPool[urlCount(param1)];
         }
      }
      
      public function hasSimpleAvatar(param1:String) : Boolean
      {
         if(_dataPool[param1] && _tagPool[urlCount(param1)] > 0)
         {
            return true;
         }
         return false;
      }
   }
}

