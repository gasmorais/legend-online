package mvc.module.minos
{
   import managers.MinosManager;
   
   public class MinosPos
   {
      
      private var _up_left:MinosPos;
      
      private var _up:MinosPos;
      
      private var _up_right:MinosPos;
      
      private var _left:MinosPos;
      
      private var _right:MinosPos;
      
      private var _down_left:MinosPos;
      
      private var _down:MinosPos;
      
      private var _down_right:MinosPos;
      
      public var x:int;
      
      public var y:int;
      
      public var size:int = 0;
      
      public var evt:int = -1;
      
      public function MinosPos(param1:int, param2:int)
      {
         super();
         x = param1;
         y = param2;
      }
      
      public function init() : void
      {
         _up_left = model.getPos(x - 1,y - 1);
         _up = model.getPos(x,y - 1);
         _up_right = model.getPos(x + 1,y - 1);
         _left = model.getPos(x - 1,y);
         _right = model.getPos(x + 1,y);
         _down_left = model.getPos(x - 1,y + 1);
         _down = model.getPos(x,y + 1);
         _down_right = model.getPos(x + 1,y + 1);
      }
      
      public function retset() : void
      {
         size = 0;
         evt = -1;
      }
      
      public function get8arr() : Array
      {
         var _loc1_:Array = [];
         if(_up_left)
         {
            _loc1_.push(_up_left);
         }
         if(_up)
         {
            _loc1_.push(_up);
         }
         if(_up_right)
         {
            _loc1_.push(_up_right);
         }
         if(_left)
         {
            _loc1_.push(_left);
         }
         if(_right)
         {
            _loc1_.push(_right);
         }
         if(_down_left)
         {
            _loc1_.push(_down_left);
         }
         if(_down)
         {
            _loc1_.push(_down);
         }
         if(_down_right)
         {
            _loc1_.push(_down_right);
         }
         return _loc1_;
      }
      
      public function radomSize1() : MinosPos
      {
         var _loc1_:Array = null;
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:MinosPos = null;
         if(size == 1)
         {
            _loc1_ = get8arr();
         }
         else if(size == 4)
         {
            _loc5_ = getDownRightBox4();
            _loc1_ = get12arr(_loc5_);
         }
         if(_loc1_)
         {
            while(_loc1_.length > 0)
            {
               _loc3_ = int(_loc1_.length);
               _loc2_ = Math.random() * _loc3_;
               _loc4_ = _loc1_[_loc2_];
               if(_loc4_.evt == -1)
               {
                  return _loc4_;
               }
               _loc1_.splice(_loc2_,1);
            }
         }
         return null;
      }
      
      public function radomSize4() : MinosPos
      {
         var _loc1_:Array = null;
         var _loc8_:Array = null;
         var _loc5_:MinosPos = null;
         var _loc3_:Array = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         if(size == 1)
         {
            _loc8_ = getTopLeftBox4();
            _loc1_ = get12arr(_loc8_);
         }
         else if(size == 4)
         {
            _loc3_ = get8arr();
            _loc1_ = [];
            for each(_loc5_ in _loc3_)
            {
               _loc6_ = _loc5_.get8arr();
               for each(var _loc7_:MinosPos in _loc6_)
               {
                  if(_loc7_ != this && _loc3_.indexOf(_loc7_) == -1)
                  {
                     if(_loc1_.indexOf(_loc7_) == -1)
                     {
                        _loc1_.push(_loc7_);
                     }
                  }
               }
            }
         }
         if(_loc1_)
         {
            while(_loc1_.length > 0)
            {
               _loc4_ = int(_loc1_.length);
               _loc2_ = Math.random() * _loc4_;
               _loc5_ = _loc1_[_loc2_];
               _loc8_ = _loc5_.getDownRightBox4();
               if(_loc8_)
               {
                  _loc9_ = getBoxEventSize(_loc8_);
                  if(_loc9_ < 4)
                  {
                     return _loc5_;
                  }
                  _loc1_.splice(_loc2_,1);
               }
               else
               {
                  _loc1_.splice(_loc2_,1);
               }
            }
         }
         return null;
      }
      
      public function getBoxEventSize(param1:Array) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:MinosPos in param1)
         {
            _loc2_ += _loc3_.evt;
         }
         return _loc2_;
      }
      
      public function get12arr(param1:Array) : Array
      {
         var _loc5_:Array = null;
         var _loc2_:Array = [];
         for each(var _loc3_:MinosPos in param1)
         {
            _loc5_ = _loc3_.get8arr();
            for each(var _loc4_:MinosPos in _loc5_)
            {
               if(param1.indexOf(_loc4_) == -1)
               {
                  if(_loc2_.indexOf(_loc4_) == -1)
                  {
                     _loc2_.push(_loc4_);
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function getDownRightBox4() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:MinosPos = null;
         if(x + 1 < 16 && y + 1 < 10)
         {
            _loc1_ = [];
            _loc1_.push(this);
            _loc2_ = model.getPos(x + 1,y);
            _loc1_.push(_loc2_);
            _loc2_ = model.getPos(x,y + 1);
            _loc1_.push(_loc2_);
            _loc2_ = model.getPos(x + 1,y + 1);
            _loc1_.push(_loc2_);
            return _loc1_;
         }
         return null;
      }
      
      public function getTopLeftBox4() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:MinosPos = null;
         if(x - 1 >= 0 && y - 1 >= 0)
         {
            _loc1_ = [];
            _loc2_ = model.getPos(x - 1,y - 1);
            _loc1_.push(_loc2_);
            _loc2_ = model.getPos(x,y - 1);
            _loc1_.push(_loc2_);
            _loc2_ = model.getPos(x - 1,y);
            _loc1_.push(_loc2_);
            _loc1_.push(this);
            return _loc1_;
         }
         return null;
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
   }
}

