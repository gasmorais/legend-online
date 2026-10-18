package utils
{
   public class NewbieUtils
   {
      
      public function NewbieUtils()
      {
         super();
      }
      
      public static function execFunc(param1:Function, param2:Array = null, param3:Function = null, param4:Array = null) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc7_:Boolean = param3 != null;
         if(param2)
         {
            switch(_loc5_ = int(param2.length))
            {
               case 0:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4)) : Boolean(param1());
                  break;
               case 1:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0])) : Boolean(param1(param2[0]));
                  break;
               case 2:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1])) : Boolean(param1(param2[0],param2[1]));
                  break;
               case 3:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2])) : Boolean(param1(param2[0],param2[1],param2[2]));
                  break;
               case 4:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3]));
                  break;
               case 5:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4]));
                  break;
               case 6:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]));
                  break;
               case 7:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]));
                  break;
               case 8:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]));
                  break;
               case 9:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]));
                  break;
               case 10:
                  _loc6_ = _loc7_ ? Boolean(param1(param3,param4,param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9])) : Boolean(param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]));
                  break;
               default:
                  throw new Error("目前限制{invalid_utf8=230}{invalid_utf8=156}?多支{invalid_utf8=230}{invalid_utf8=140}?10个参数，可增{invalid_utf8=229}{invalid_utf8=138}?");
            }
         }
         else
         {
            _loc6_ = _loc7_ ? Boolean(param1(param3,param4)) : Boolean(param1());
         }
         return _loc6_;
      }
      
      public static function execFuncSimple(param1:Function, param2:Array = null) : Object
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         if(!param2)
         {
            return param1();
         }
         _loc3_ = int(param2.length);
         switch(_loc3_)
         {
            case 0:
               return param1();
            case 1:
               return param1(param2[0]);
            case 2:
               return param1(param2[0],param2[1]);
            case 3:
               return param1(param2[0],param2[1],param2[2]);
            case 4:
               return param1(param2[0],param2[1],param2[2],param2[3]);
            case 5:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
            case 6:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
            case 7:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
            case 8:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
            case 9:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
            case 10:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
            default:
               throw new Error("目前限制{invalid_utf8=230}{invalid_utf8=156}?多支{invalid_utf8=230}{invalid_utf8=140}?10个参数，可增{invalid_utf8=229}{invalid_utf8=138}?");
         }
      }
      
      public static function stringToObject(param1:String) : Object
      {
         var _loc6_:Array = null;
         var _loc8_:String = null;
         var _loc7_:String = null;
         var _loc4_:Object = {};
         var _loc2_:String = param1.slice(1,param1.length - 1);
         var _loc3_:Array = _loc2_.split("_");
         for each(var _loc5_:String in _loc3_)
         {
            _loc6_ = _loc5_.split(":");
            _loc8_ = _loc6_[0];
            _loc7_ = _loc6_[1];
            if(_loc7_ == "true")
            {
               _loc4_[_loc8_] = true;
            }
            else if(_loc7_ == "false")
            {
               _loc4_[_loc8_] = false;
            }
            else if(_loc7_.indexOf("\'") == -1)
            {
               _loc4_[_loc8_] = Number(_loc7_);
            }
            else
            {
               _loc4_[_loc8_] = _loc7_;
            }
         }
         return _loc4_;
      }
   }
}

