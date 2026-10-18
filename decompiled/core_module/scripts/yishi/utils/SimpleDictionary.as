package yishi.utils
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.events.DictionaryEvent;
   
   public dynamic class SimpleDictionary extends Dictionary
   {
      
      private var dispatcher:EventDispatcher = new EventDispatcher(null);
      
      private var _list:Array = [];
      
      public function SimpleDictionary(param1:Boolean = false)
      {
         super(param1);
      }
      
      public function get keys() : Array
      {
         var _loc1_:Array = [];
         for(var _loc2_:String in this)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      private function setValue(param1:*, param2:Object) : void
      {
         if(this[param1])
         {
            dispatchEvent(new DictionaryEvent("preupdateDictionary",param2,this[param1],param1));
            updateInArray(this[param1],param2);
            this[param1] = param2;
            dispatchEvent(new DictionaryEvent("updateDictionary",param2,this[param1],param1));
         }
         else
         {
            dispatchEvent(new DictionaryEvent("preaddDictionary",param2,this[param1],param1));
            addInArray(param2);
            this[param1] = param2;
            dispatchEvent(new DictionaryEvent("addDictionary",param2,this[param1],param1));
         }
      }
      
      private function addInArray(param1:Object) : void
      {
         _list.push(param1);
      }
      
      private function updateInArray(param1:Object, param2:Object) : void
      {
         var _loc3_:int = _list.indexOf(param1);
         if(_loc3_ > -1)
         {
            _list.splice(_loc3_,1,param2);
         }
      }
      
      private function delInArray(param1:Object) : void
      {
         var _loc2_:int = _list.indexOf(param1);
         if(_loc2_ > -1)
         {
            _list.splice(_loc2_,1);
         }
      }
      
      private function delValue(param1:*) : void
      {
         var _loc2_:Object = null;
         if(this[param1])
         {
            _loc2_ = this[param1];
            dispatchEvent(new DictionaryEvent("predeleteDictionary",null,_loc2_,param1));
            delInArray(_loc2_);
            delete this[param1];
            dispatchEvent(new DictionaryEvent("deleteDictionary",null,_loc2_,param1));
            _loc2_ = null;
         }
      }
      
      private function checkToAddOrUpdate(param1:*, param2:Object) : Boolean
      {
         if(param2 == null)
         {
            delValue(param1);
            return false;
         }
         return true;
      }
      
      public function add(param1:*, param2:Object) : void
      {
         if(checkToAddOrUpdate(param1,param2))
         {
            setValue(param1,param2);
         }
      }
      
      public function update(param1:*, param2:Object) : void
      {
         if(checkToAddOrUpdate(param1,param2))
         {
            setValue(param1,param2);
         }
      }
      
      public function del(param1:*) : void
      {
         delValue(param1);
      }
      
      public function clear() : void
      {
         dispatchEvent(new DictionaryEvent("preclearDictionary"));
         var _loc1_:Array = keys;
         for each(var _loc2_:String in _loc1_)
         {
            delete this[_loc2_];
         }
         _list = [];
         dispatchEvent(new DictionaryEvent("clearDictionary"));
      }
      
      public function setDictionary(param1:SimpleDictionary) : void
      {
         clear();
         for(var _loc2_:String in param1)
         {
            add(_loc2_,param1[_loc2_]);
         }
      }
      
      public function slice(param1:int = 0, param2:int = 166777215) : Array
      {
         var _loc5_:* = 0;
         var _loc4_:Object = null;
         var _loc3_:Array = keys.slice(param1,param2);
         var _loc6_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = {};
            _loc4_.key = _loc3_[_loc5_];
            _loc4_.value = this[_loc3_[_loc5_]];
            _loc6_.push(_loc4_);
            delInArray(this[_loc3_[_loc5_]]);
            delete this[_loc3_[_loc5_]];
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function splice(param1:int, param2:uint) : Array
      {
         var _loc5_:* = 0;
         var _loc4_:Object = null;
         var _loc3_:Array = keys.splice(param1,param2);
         var _loc6_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = {};
            _loc4_.key = _loc3_[_loc5_];
            _loc4_.value = this[_loc3_[_loc5_]];
            _loc6_.push(_loc4_);
            delInArray(this[_loc3_[_loc5_]]);
            delete this[_loc3_[_loc5_]];
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function getList() : Array
      {
         return _list;
      }
      
      public function dispatchEvent(param1:DictionaryEvent) : void
      {
         dispatcher.dispatchEvent(param1);
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         dispatcher.addEventListener(param1,param2);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         dispatcher.removeEventListener(param1,param2);
      }
   }
}

