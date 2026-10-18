package dragonBones.animation
{
   import flash.utils.getTimer;
   
   public final class WorldClock implements IAnimatable
   {
      
      public static var clock:WorldClock = new WorldClock();
      
      private var animatableList:Vector.<IAnimatable>;
      
      private var _time:Number;
      
      private var _timeScale:Number = 1;
      
      public function WorldClock()
      {
         super();
         this._time = getTimer() * 0.001;
         this.animatableList = new Vector.<IAnimatable>();
      }
      
      public function get time() : Number
      {
         return this._time;
      }
      
      public function get timeScale() : Number
      {
         return this._timeScale;
      }
      
      public function set timeScale(param1:Number) : void
      {
         if(param1 < 0 || isNaN(param1))
         {
            param1 = 0;
         }
         this._timeScale = param1;
      }
      
      public function contains(param1:IAnimatable) : Boolean
      {
         return this.animatableList.indexOf(param1) >= 0;
      }
      
      public function add(param1:IAnimatable) : void
      {
         if(param1)
         {
            this.animatableList.push(param1);
         }
      }
      
      public function remove(param1:IAnimatable) : void
      {
         var _loc2_:int = this.animatableList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.animatableList[_loc2_] = null;
         }
      }
      
      public function clear() : void
      {
         this.animatableList.length = 0;
      }
      
      public function advanceTime(param1:Number, param2:String = "", param3:int = 0) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:IAnimatable = null;
         if(param1 < 0)
         {
            _loc7_ = getTimer() * 0.001;
            param1 = _loc7_ - this._time;
            this._time = _loc7_;
         }
         else
         {
            this._time = getTimer() * 0.001;
         }
         param1 *= this._timeScale;
         var _loc4_:int = int(this.animatableList.length);
         if(_loc4_ == 0)
         {
            return;
         }
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = this.animatableList[_loc6_];
            if(_loc8_)
            {
               if(_loc5_ != _loc6_)
               {
                  this.animatableList[_loc5_] = _loc8_;
                  this.animatableList[_loc6_] = null;
               }
               _loc8_.advanceTime(param1,param2,param3);
               _loc5_++;
            }
            _loc6_++;
         }
         if(_loc5_ != _loc6_)
         {
            _loc4_ = int(this.animatableList.length);
            while(_loc6_ < _loc4_)
            {
               var _loc9_:Number;
               this.animatableList[_loc9_ = _loc5_++] = this.animatableList[_loc6_++];
            }
            this.animatableList.length = _loc5_;
         }
      }
      
      public function isUpdateFrame(param1:Number) : Number
      {
         return 0;
      }
   }
}

