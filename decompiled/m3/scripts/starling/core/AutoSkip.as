package starling.core
{
   import flash.display.Stage;
   import flash.utils.getTimer;
   
   public class AutoSkip
   {
      
      private var lastTimer:int;
      
      private var deadLine:int;
      
      private var minContiguousFrames:int;
      
      private var maxContiguousSkips:int;
      
      private var framesRendered:int;
      
      private var framesSkipped:int;
      
      public function AutoSkip(param1:Stage, param2:Number = 1.2, param3:int = 1, param4:int = 1)
      {
         super();
         this.lastTimer = 0;
         this.deadLine = Math.ceil(1000 / param1.frameRate * param2);
         this.minContiguousFrames = param3;
         this.maxContiguousSkips = param4;
         this.framesRendered = 0;
         this.framesSkipped = 0;
      }
      
      public function requestFrameSkip() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this.lastTimer;
         if(_loc3_ > this.deadLine && this.framesRendered >= this.minContiguousFrames && this.framesSkipped < this.maxContiguousSkips)
         {
            _loc1_ = true;
            this.framesRendered = 0;
            this.framesSkipped += 1;
         }
         else
         {
            this.framesSkipped = 0;
            this.framesRendered += 1;
         }
         this.lastTimer = _loc2_;
         return _loc1_;
      }
   }
}

