package battle.particle.freeze
{
   import flash.geom.Point;
   
   public class Polygon
   {
      
      public var lines:Array;
      
      public function Polygon(param1:Array)
      {
         var _loc2_:int = 0;
         super();
         lines = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length - 1)
         {
            lines.push(new Line(param1[_loc2_],param1[_loc2_ + 1]));
            _loc2_++;
         }
         lines.push(new Line(param1[_loc2_],param1[0]));
      }
      
      public static function breakPolygon(param1:Polygon, param2:int, param3:Array) : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:Line = null;
         var _loc12_:Line = null;
         var _loc14_:Number = NaN;
         var _loc7_:Point = null;
         var _loc15_:Point = null;
         var _loc17_:int = 0;
         var _loc4_:Point = null;
         var _loc9_:Array = null;
         var _loc6_:int = 0;
         var _loc13_:int = 0;
         var _loc16_:Polygon = null;
         var _loc10_:Array = null;
         var _loc18_:Polygon = null;
         if(param2 > 0)
         {
            param2--;
            _loc5_ = 0;
            _loc8_ = (_loc5_ + Math.floor(param1.lines.length * 0.5)) % param1.lines.length;
            _loc11_ = param1.lines[_loc5_];
            _loc12_ = param1.lines[_loc8_];
            _loc14_ = 0.2;
            _loc7_ = new Point(_loc11_.startPoint.x + (_loc11_.endPoint.x - _loc11_.startPoint.x) * _loc14_,_loc11_.startPoint.y + (_loc11_.endPoint.y - _loc11_.startPoint.y) * _loc14_);
            _loc14_ = 0.3;
            _loc15_ = new Point(_loc12_.startPoint.x + (_loc12_.endPoint.x - _loc12_.startPoint.x) * _loc14_,_loc12_.startPoint.y + (_loc12_.endPoint.y - _loc12_.startPoint.y) * _loc14_);
            if(_loc5_ > _loc8_)
            {
               _loc17_ = _loc5_;
               _loc5_ = _loc8_;
               _loc8_ = _loc17_;
               _loc4_ = _loc7_;
               _loc7_ = _loc15_;
               _loc15_ = _loc4_;
            }
            _loc9_ = [];
            _loc6_ = _loc5_;
            while(_loc6_ < _loc8_)
            {
               _loc9_.push(param1.lines[_loc6_].endPoint.clone());
               _loc6_++;
            }
            _loc13_ = _loc9_.length - 1;
            if(_loc9_[_loc13_].x != _loc15_.x || _loc9_[_loc13_].y != _loc15_.y)
            {
               _loc9_.push(_loc15_.clone());
            }
            if(_loc9_[0].x != _loc7_.x || _loc9_[0].y != _loc7_.y)
            {
               _loc9_.push(_loc7_.clone());
            }
            _loc16_ = new Polygon(_loc9_);
            if(_loc16_.len > 10)
            {
               breakPolygon(_loc16_,param2,param3);
            }
            _loc10_ = [];
            _loc6_ = _loc8_;
            while(_loc6_ < param1.lines.length)
            {
               _loc10_.push(param1.lines[_loc6_].endPoint.clone());
               _loc6_++;
            }
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc10_.push(param1.lines[_loc6_].endPoint.clone());
               _loc6_++;
            }
            _loc13_ = _loc10_.length - 1;
            if(_loc10_[_loc13_].x != _loc7_.x || _loc10_[_loc13_].y != _loc7_.y)
            {
               _loc10_.push(_loc7_.clone());
            }
            if(_loc10_[0].x != _loc15_.x || _loc10_[0].y != _loc15_.y)
            {
               _loc10_.push(_loc15_.clone());
            }
            _loc18_ = new Polygon(_loc10_);
            if(_loc18_.len > 10)
            {
               breakPolygon(_loc18_,param2,param3);
            }
         }
         else
         {
            param3.push(param1);
         }
      }
      
      public function get len() : Number
      {
         var _loc1_:Number = 0;
         for each(var _loc2_:Line in lines)
         {
            _loc1_ += _loc2_.len;
         }
         return _loc1_;
      }
      
      public function get centerPoint() : Point
      {
         var _loc3_:int = 0;
         var _loc2_:Number = 0;
         var _loc1_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < lines.length)
         {
            _loc2_ += lines[_loc3_].startPoint.x;
            _loc1_ += lines[_loc3_].startPoint.y;
            _loc3_++;
         }
         return new Point(_loc2_ / lines.length,_loc1_ / lines.length);
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:Line in lines)
         {
            _loc1_.dispose();
         }
         lines.splice(0,lines.length);
         lines = null;
      }
   }
}

