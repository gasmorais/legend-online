package yishi.utils
{
   import flash.display.Graphics;
   import flash.geom.Point;
   
   public class PathGraphicsUtil
   {
      
      public function PathGraphicsUtil()
      {
         super();
      }
      
      public static function drawZebraStripes(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void
      {
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         if(!param1 || !param2 || !param3 || param4 <= 0 || param5 <= 0)
         {
            return;
         }
         var _loc8_:Number = param2.x;
         var _loc9_:Number = param2.y;
         var _loc6_:Number = Point.distance(param2,param3);
         var _loc7_:Number = 0;
         var _loc19_:Number = param4 * 0.5;
         var _loc13_:Number = Math.atan2(param3.y - _loc9_,param3.x - _loc8_);
         var _loc12_:Number = (_loc13_ / 3.141592653589793 * 180 + 90) / 180 * 3.141592653589793;
         var _loc14_:Number = (_loc13_ / 3.141592653589793 * 180 - 90) / 180 * 3.141592653589793;
         while(_loc7_ <= _loc6_)
         {
            _loc10_ = _loc8_ + Math.cos(_loc13_) * _loc7_;
            _loc11_ = _loc9_ + Math.sin(_loc13_) * _loc7_;
            _loc15_ = _loc10_ + Math.cos(_loc12_) * _loc19_;
            _loc18_ = _loc11_ + Math.sin(_loc12_) * _loc19_;
            _loc17_ = _loc10_ + Math.cos(_loc14_) * _loc19_;
            _loc16_ = _loc11_ + Math.sin(_loc14_) * _loc19_;
            param1.moveTo(_loc15_,_loc18_);
            param1.lineTo(_loc17_,_loc16_);
            _loc7_ += param5;
         }
      }
      
      public static function drawDashed(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void
      {
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         if(!param1 || !param2 || !param3 || param4 <= 0 || param5 <= 0)
         {
            return;
         }
         var _loc9_:Number = param2.x;
         var _loc11_:Number = param2.y;
         var _loc12_:Number = Math.atan2(param3.y - _loc11_,param3.x - _loc9_);
         var _loc6_:Number = Point.distance(param2,param3);
         var _loc7_:Number = 0;
         while(_loc7_ <= _loc6_)
         {
            _loc8_ = _loc9_ + Math.cos(_loc12_) * _loc7_;
            _loc10_ = _loc11_ + Math.sin(_loc12_) * _loc7_;
            param1.moveTo(_loc8_,_loc10_);
            _loc7_ += param4;
            if(_loc7_ > _loc6_)
            {
               _loc7_ = _loc6_;
            }
            _loc8_ = _loc9_ + Math.cos(_loc12_) * _loc7_;
            _loc10_ = _loc11_ + Math.sin(_loc12_) * _loc7_;
            param1.lineTo(_loc8_,_loc10_);
            _loc7_ += param5;
         }
      }
   }
}

