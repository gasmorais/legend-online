package mvc.module.poker
{
   import com.road.yishi.proto.pet.CardMsg;
   import yishi.manager.PokerManager;
   
   public class PokerResultHelper
   {
      
      public function PokerResultHelper()
      {
         super();
      }
      
      public static function getResultCardArr(param1:PokerPlayerInfo) : Array
      {
         var _loc10_:Array = null;
         var _loc13_:Boolean = false;
         var _loc15_:* = 0;
         var _loc4_:int = 0;
         var _loc12_:CardMsg = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc14_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = int(param1.rankings[0]);
         var _loc11_:Array = param1.rankings;
         var _loc2_:Array = [];
         var _loc3_:Array = [0,1,2,3];
         switch(_loc6_)
         {
            case 0:
               _loc10_ = [_loc11_[1],_loc11_[2],_loc11_[3],_loc11_[4],_loc11_[5]];
               break;
            case 1:
               _loc10_ = [_loc11_[1],_loc11_[1],_loc11_[2],_loc11_[3],_loc11_[4]];
               break;
            case 2:
               _loc10_ = [_loc11_[1],_loc11_[1],_loc11_[2],_loc11_[2],_loc11_[3]];
               break;
            case 3:
               _loc10_ = [_loc11_[1],_loc11_[1],_loc11_[1],_loc11_[2],_loc11_[3]];
               break;
            case 4:
               _loc10_ = [_loc11_[1],_loc11_[1] - 1,_loc11_[1] - 2,_loc11_[1] - 3,_loc11_[1] - 4];
               break;
            case 5:
               _loc13_ = true;
               _loc10_ = [_loc11_[1],_loc11_[2],_loc11_[3],_loc11_[4],_loc11_[5]];
               break;
            case 6:
               _loc10_ = [_loc11_[1],_loc11_[1],_loc11_[1],_loc11_[2],_loc11_[2]];
               break;
            case 7:
               _loc10_ = [_loc11_[1],_loc11_[1],_loc11_[1],_loc11_[1],_loc11_[2]];
               break;
            case 8:
               _loc13_ = true;
               if(_loc11_[1] == 3)
               {
                  _loc10_ = [12,0,1,2,3];
               }
               else
               {
                  _loc10_ = [_loc11_[1],_loc11_[1] - 1,_loc11_[1] - 2,_loc11_[1] - 3,_loc11_[1] - 4];
               }
               break;
            case 9:
               _loc13_ = true;
               _loc10_ = [12,11,10,9,8];
         }
         var _loc7_:Array = param1.cardArr.concat(PokerManager.instance.boardInfo.cardArr);
         _loc10_ = _loc10_.sort(0x10 | 2);
         var _loc16_:Array = [];
         if(_loc13_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc4_ = 0;
               _loc9_ = 0;
               while(_loc9_ < _loc7_.length)
               {
                  _loc12_ = _loc7_[_loc9_] as CardMsg;
                  if(_loc12_.suit == _loc8_)
                  {
                     _loc4_++;
                  }
                  _loc9_++;
               }
               if(_loc4_ >= 5)
               {
                  _loc15_ = _loc8_;
                  break;
               }
               _loc8_++;
            }
         }
         _loc14_ = 0;
         while(_loc14_ < _loc10_.length)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               _loc12_ = _loc7_[_loc5_] as CardMsg;
               if(_loc16_.indexOf(_loc5_) == -1)
               {
                  if(_loc12_.rank == _loc10_[_loc14_])
                  {
                     if(_loc13_)
                     {
                        if(_loc12_.suit == _loc15_)
                        {
                           _loc2_.push(_loc12_);
                           _loc16_.push(_loc5_);
                           break;
                        }
                     }
                     else if(_loc2_.length < 5)
                     {
                        _loc2_.push(_loc12_);
                        _loc16_.push(_loc5_);
                        break;
                     }
                  }
               }
               _loc5_++;
            }
            _loc14_++;
         }
         return _loc2_;
      }
   }
}

