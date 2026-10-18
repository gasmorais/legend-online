package starling.events
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.core.starling_internal;
   import starling.display.DisplayObject;
   import starling.utils.MatrixUtil;
   import starling.utils.formatString;
   
   use namespace starling_internal;
   
   public class Touch
   {
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private var mID:int;
      
      private var mGlobalX:Number;
      
      private var mGlobalY:Number;
      
      private var mPreviousGlobalX:Number;
      
      private var mPreviousGlobalY:Number;
      
      private var mTapCount:int;
      
      private var mPhase:String;
      
      private var mTarget:DisplayObject;
      
      private var mTimestamp:Number;
      
      private var mPressure:Number;
      
      private var mWidth:Number;
      
      private var mHeight:Number;
      
      private var mBubbleChain:Vector.<EventDispatcher>;
      
      public function Touch(param1:int, param2:Number, param3:Number, param4:String, param5:DisplayObject)
      {
         super();
         this.mID = param1;
         this.mGlobalX = this.mPreviousGlobalX = param2;
         this.mGlobalY = this.mPreviousGlobalY = param3;
         this.mTapCount = 0;
         this.mPhase = param4;
         this.mTarget = param5;
         this.mPressure = this.mWidth = this.mHeight = 1;
         this.mBubbleChain = new Vector.<EventDispatcher>(0);
         this.updateBubbleChain();
      }
      
      public function getLocation(param1:DisplayObject, param2:Point = null) : Point
      {
         if(param2 == null)
         {
            param2 = new Point();
         }
         param1.base.getTransformationMatrix(param1,sHelperMatrix);
         return MatrixUtil.transformCoords(sHelperMatrix,this.mGlobalX,this.mGlobalY,param2);
      }
      
      public function getPreviousLocation(param1:DisplayObject, param2:Point = null) : Point
      {
         if(param2 == null)
         {
            param2 = new Point();
         }
         param1.base.getTransformationMatrix(param1,sHelperMatrix);
         return MatrixUtil.transformCoords(sHelperMatrix,this.mPreviousGlobalX,this.mPreviousGlobalY,param2);
      }
      
      public function getMovement(param1:DisplayObject, param2:Point = null) : Point
      {
         if(param2 == null)
         {
            param2 = new Point();
         }
         this.getLocation(param1,param2);
         var _loc3_:Number = param2.x;
         var _loc4_:Number = param2.y;
         this.getPreviousLocation(param1,param2);
         param2.setTo(_loc3_ - param2.x,_loc4_ - param2.y);
         return param2;
      }
      
      public function isTouching(param1:DisplayObject) : Boolean
      {
         return this.mBubbleChain.indexOf(param1) != -1;
      }
      
      public function toString() : String
      {
         return formatString("Touch {0}: globalX={1}, globalY={2}, phase={3}",this.mID,this.mGlobalX,this.mGlobalY,this.mPhase);
      }
      
      public function clone() : Touch
      {
         var _loc1_:Touch = new Touch(this.mID,this.mGlobalX,this.mGlobalY,this.mPhase,this.mTarget);
         _loc1_.mPreviousGlobalX = this.mPreviousGlobalX;
         _loc1_.mPreviousGlobalY = this.mPreviousGlobalY;
         _loc1_.mTapCount = this.mTapCount;
         _loc1_.mTimestamp = this.mTimestamp;
         _loc1_.mPressure = this.mPressure;
         _loc1_.mWidth = this.mWidth;
         _loc1_.mHeight = this.mHeight;
         return _loc1_;
      }
      
      private function updateBubbleChain() : void
      {
         var _loc1_:* = 0;
         var _loc2_:DisplayObject = null;
         if(this.mTarget)
         {
            _loc1_ = 1;
            _loc2_ = this.mTarget;
            this.mBubbleChain.length = 1;
            this.mBubbleChain[0] = _loc2_;
            while(true)
            {
               _loc2_ = _loc2_.parent;
               if(_loc2_ == null)
               {
                  break;
               }
               this.mBubbleChain[int(_loc1_++)] = _loc2_;
            }
         }
         else
         {
            this.mBubbleChain.length = 0;
         }
      }
      
      public function get id() : int
      {
         return this.mID;
      }
      
      public function get globalX() : Number
      {
         return this.mGlobalX;
      }
      
      public function get globalY() : Number
      {
         return this.mGlobalY;
      }
      
      public function get previousGlobalX() : Number
      {
         return this.mPreviousGlobalX;
      }
      
      public function get previousGlobalY() : Number
      {
         return this.mPreviousGlobalY;
      }
      
      public function get tapCount() : int
      {
         return this.mTapCount;
      }
      
      public function get phase() : String
      {
         return this.mPhase;
      }
      
      public function get target() : DisplayObject
      {
         return this.mTarget;
      }
      
      public function get timestamp() : Number
      {
         return this.mTimestamp;
      }
      
      public function get pressure() : Number
      {
         return this.mPressure;
      }
      
      public function get width() : Number
      {
         return this.mWidth;
      }
      
      public function get height() : Number
      {
         return this.mHeight;
      }
      
      starling_internal function dispatchEvent(param1:TouchEvent) : void
      {
         if(this.mTarget)
         {
            param1.dispatch(this.mBubbleChain);
         }
      }
      
      starling_internal function get bubbleChain() : Vector.<EventDispatcher>
      {
         return this.mBubbleChain.concat();
      }
      
      starling_internal function setTarget(param1:DisplayObject) : void
      {
         this.mTarget = param1;
         this.updateBubbleChain();
      }
      
      starling_internal function setPosition(param1:Number, param2:Number) : void
      {
         this.mPreviousGlobalX = this.mGlobalX;
         this.mPreviousGlobalY = this.mGlobalY;
         this.mGlobalX = param1;
         this.mGlobalY = param2;
      }
      
      starling_internal function setSize(param1:Number, param2:Number) : void
      {
         this.mWidth = param1;
         this.mHeight = param2;
      }
      
      starling_internal function setPhase(param1:String) : void
      {
         this.mPhase = param1;
      }
      
      starling_internal function setTapCount(param1:int) : void
      {
         this.mTapCount = param1;
      }
      
      starling_internal function setTimestamp(param1:Number) : void
      {
         this.mTimestamp = param1;
      }
      
      starling_internal function setPressure(param1:Number) : void
      {
         this.mPressure = param1;
      }
   }
}

