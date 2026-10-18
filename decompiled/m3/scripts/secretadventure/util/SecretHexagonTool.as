package secretadventure.util
{
   import secretadventure.item.SecretHexagon;
   
   public class SecretHexagonTool
   {
      
      private static var openList:Array = [];
      
      private static var closeList:Array = [];
      
      public function SecretHexagonTool()
      {
         super();
      }
      
      private static function remove(param1:SecretHexagon, param2:Array) : void
      {
         var _loc3_:int = param2.indexOf(param1);
         if(_loc3_ >= 0)
         {
            param2.splice(_loc3_,1);
         }
      }
      
      public static function getNearIdList(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc12_:int = 0;
         var _loc15_:int = 0;
         var _loc5_:int = 0;
         var _loc14_:int = 0;
         var _loc6_:int = param1 / param2;
         var _loc7_:int = param1 % param2;
         var _loc9_:Array = [];
         var _loc13_:int = (_loc6_ - 1) * param2 + _loc7_;
         if(_loc6_ - 1 >= 0)
         {
            _loc9_.push(_loc13_);
         }
         var _loc10_:int = (_loc6_ + 1) * param2 + _loc7_;
         if(_loc6_ + 1 < param3)
         {
            _loc9_.push(_loc10_);
         }
         var _loc11_:int = _loc6_ * param2 + _loc7_ - 1;
         if(_loc7_ - 1 >= 0)
         {
            _loc9_.push(_loc11_);
         }
         var _loc8_:int = _loc6_ * param2 + _loc7_ + 1;
         if(_loc7_ + 1 < param2)
         {
            _loc9_.push(_loc8_);
         }
         if(param4 == 1)
         {
            _loc12_ = (_loc6_ - 1) * param2 + _loc7_ + 1;
            if(_loc6_ - 1 >= 0 && _loc7_ + 1 < param2)
            {
               _loc9_.push(_loc12_);
            }
            _loc15_ = (_loc6_ + 1) * param2 + _loc7_ + 1;
            if(_loc6_ + 1 < param3 && _loc7_ + 1 < param2)
            {
               _loc9_.push(_loc15_);
            }
         }
         else if(param4 == -1)
         {
            _loc5_ = (_loc6_ - 1) * param2 + _loc7_ - 1;
            if(_loc6_ - 1 >= 0 && _loc7_ - 1 >= 0)
            {
               _loc9_.push(_loc5_);
            }
            _loc14_ = (_loc6_ + 1) * param2 + _loc7_ - 1;
            if(_loc6_ + 1 < param3 && _loc7_ - 1 >= 0)
            {
               _loc9_.push(_loc14_);
            }
         }
         return _loc9_;
      }
      
      public static function searchPath(param1:SecretHexagon, param2:SecretHexagon) : Array
      {
         var _loc6_:Array = null;
         var _loc10_:int = 0;
         var _loc7_:SecretHexagon = null;
         var _loc8_:SecretHexagon = null;
         var _loc5_:SecretHexagon = param1;
         openList.push(_loc5_);
         var _loc4_:Boolean = false;
         while(!_loc4_)
         {
            remove(_loc5_,openList);
            closeList.push(_loc5_);
            _loc6_ = _loc5_.getNeighborList();
            for each(var _loc9_:SecretHexagon in _loc6_)
            {
               if(_loc9_ != null)
               {
                  if(_loc9_ == param2)
                  {
                     _loc4_ = true;
                     _loc9_.setFatherHexagon(_loc5_);
                  }
                  if(!(closeList.indexOf(_loc9_) != -1 || !_loc9_.canPass()))
                  {
                     if(openList.indexOf(_loc9_) != -1)
                     {
                        _loc10_ = _loc9_.computeGValue(_loc5_) + _loc5_.getgValue();
                        if(_loc10_ < _loc9_.getgValue())
                        {
                           remove(_loc9_,openList);
                           _loc9_.setgValue(_loc10_);
                           openList.push(_loc9_);
                        }
                     }
                     else
                     {
                        _loc9_.sethValue(_loc9_.computeHValue(param2));
                        _loc9_.setgValue(_loc9_.computeGValue(_loc5_) + _loc5_.getgValue());
                        openList.push(_loc9_);
                        _loc9_.setFatherHexagon(_loc5_);
                     }
                  }
               }
            }
            if(openList.length <= 0)
            {
               break;
            }
            _loc5_ = openList[0];
         }
         openList.length = 0;
         closeList.length = 0;
         var _loc3_:Array = [];
         if(_loc4_)
         {
            _loc7_ = param2;
            while(_loc7_ != param1)
            {
               _loc3_.push(_loc7_);
               _loc7_ = _loc8_ = _loc7_.getFatherHexagon();
            }
            _loc3_.push(_loc7_);
         }
         _loc3_.reverse();
         return _loc3_;
      }
   }
}

