package map.internals.view.hero.helper
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.internals.utils.PointUtils;
   import yishi.datas.ai.AIBaseInfo;
   
   public class HeroAvatarViewHelper
   {
      
      public function HeroAvatarViewHelper()
      {
         super();
      }
      
      public static function twoPointAngle(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:int = param1 - param3;
         var _loc6_:int = param2 - param4;
         _loc5_ = int(Math.abs(_loc5_) < 10 ? 0 : _loc5_);
         _loc6_ = int(Math.abs(_loc6_) < 10 ? 0 : _loc6_);
         var _loc7_:Number = Math.atan2(_loc6_,_loc5_);
         _loc7_ = _loc7_ * 180 / 3.141592653589793;
         if(_loc7_ < 0)
         {
            _loc7_ += 360;
         }
         return _loc7_;
      }
      
      public static function directionMove(param1:String, param2:int, param3:DisplayObject) : void
      {
         var _loc5_:String = null;
         var _loc4_:int = Math.sqrt(param2 * param2 / 2) + 1;
         switch(param1)
         {
            case "B":
               param3.y += param2 - 1;
               break;
            case "L":
               param3.x -= param2;
               break;
            case "R":
               param3.x += param2;
               break;
            case "T":
               param3.y -= param2 - 1;
               break;
            case "L_B":
               param3.x -= _loc4_;
               param3.y += _loc4_;
               break;
            case "L_T":
               param3.x -= _loc4_;
               param3.y -= _loc4_;
               break;
            case "R_B":
               param3.x += _loc4_;
               param3.y += _loc4_;
               break;
            case "R_T":
               param3.x += _loc4_;
               param3.y -= _loc4_;
               break;
            default:
               _loc5_ = LanguageMgr.GetTranslation("map.internals.view.hero.helper.HeroAvatarViewHelper.errorTip");
               throw new Error(_loc5_);
         }
      }
      
      public static function checkDirectionBySetup(param1:int, param2:Point, param3:AIBaseInfo) : int
      {
         var _loc6_:int = param1 - param3.walkIndex % param1;
         var _loc5_:int = param3.pathInfo.length > param3.walkIndex + _loc6_ ? param3.walkIndex + _loc6_ : param3.pathInfo.length - 1;
         _loc5_ = _loc5_ > param1 ? _loc5_ - param1 : 0;
         _loc5_ = param3.walkIndex + 1;
         var _loc4_:Point = new Point(param3.pathInfo[_loc5_].x * 20,param3.pathInfo[_loc5_].y * 20);
         return twoPointAngle(param2.x,param2.y,_loc4_.x,_loc4_.y);
      }
      
      public static function intervalPoint(param1:int, param2:Point, param3:AIBaseInfo) : Point
      {
         var _loc5_:int = param1 - param3.walkIndex % param1;
         var _loc4_:int = param3.pathInfo.length > param3.walkIndex + _loc5_ ? param3.walkIndex + _loc5_ : param3.pathInfo.length - 1;
         return new Point(param3.pathInfo[_loc4_].x * 20,param3.pathInfo[_loc4_].y * 20);
      }
      
      public static function getNextPoint(param1:Point, param2:Point, param3:Point) : Point
      {
         param2 = PointUtils.scaleTransformII(param2,20,20);
         param3 = PointUtils.clonePoint(param2);
         param3.x = Math.abs(param3.x - param1.x) < 12 ? param1.x : param3.x;
         param3.y = Math.abs(param3.y - param1.y) < 12 ? param1.y : param3.y;
         return param3;
      }
   }
}

