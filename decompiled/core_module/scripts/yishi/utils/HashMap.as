package yishi.utils
{
   import flash.utils.Dictionary;
   
   public class HashMap
   {
      
      private var _key:Array = [];
      
      private var _value:Dictionary = new Dictionary();
      
      private var _length:int = 0;
      
      public function HashMap()
      {
         super();
      }
      
      public function put(param1:Object, param2:Object) : Object
      {
         if(!containsKey(param1))
         {
            _key.push(param1);
            _value[param1] = param2;
            _length = _length + 1;
            return null;
         }
         return _value[param1] = param2;
      }
      
      public function containsKey(param1:Object) : Boolean
      {
         if(_value[param1] == undefined)
         {
            return false;
         }
         return true;
      }
      
      public function containsValue(param1:Object) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _length)
         {
            if(_value[_key[_loc2_]] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function remove(param1:Object) : Object
      {
         var _loc2_:Object = null;
         if(containsKey(param1))
         {
            _loc2_ = _value[param1];
            _key.splice(_key.indexOf(param1),1);
            delete _value[param1];
            _length = _length - 1;
            return _loc2_;
         }
         return null;
      }
      
      public function getValue(param1:Object) : Object
      {
         if(_value[param1] != undefined)
         {
            return _value[param1];
         }
         return null;
      }
      
      public function get size() : int
      {
         return _length;
      }
      
      public function get isEmpty() : Boolean
      {
         return _length > 0 ? false : true;
      }
      
      public function get keySet() : Array
      {
         return [].concat(_key);
      }
      
      public function get valueSet() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:Object in _key)
         {
            _loc1_.push(_value[_loc2_]);
         }
         return _loc1_;
      }
      
      public function getKeyByIndex(param1:int) : Object
      {
         var _loc2_:Object = _key[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         return null;
      }
      
      public function getValueByIndex(param1:int) : Object
      {
         var _loc2_:Object = _key[param1];
         if(_loc2_ != null)
         {
            if(_value[_loc2_] != null)
            {
               return _value[_loc2_];
            }
         }
         return null;
      }
      
      public function clear() : void
      {
         _key = [];
         _value = new Dictionary();
         _length = 0;
      }
   }
}

