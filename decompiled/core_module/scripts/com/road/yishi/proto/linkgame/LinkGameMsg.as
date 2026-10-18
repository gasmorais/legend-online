package com.road.yishi.proto.linkgame
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LinkGameMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var a_x$field:int;
      
      private var a_y$field:int;
      
      private var b_x$field:int;
      
      private var b_y$field:int;
      
      private var score$field:int;
      
      private var time$field:int;
      
      private var strength$field:int;
      
      private var points$field:String;
      
      private var bomb_count$field:int;
      
      private var reset_count$field:int;
      
      private var param1$field:int;
      
      private var tollgate$field:int;
      
      private var reward$field:String;
      
      private var comb_count$field:int;
      
      private var add_score$field:int;
      
      private var point_value$field:int;
      
      [ArrayElementType("int")]
      public var scoreValue:Array = [];
      
      public function LinkGameMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeAX() : void
      {
         hasField$0 &= 4294967293;
         a_x$field = new int();
      }
      
      public function get hasAX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set aX(param1:int) : void
      {
         hasField$0 |= 2;
         a_x$field = param1;
      }
      
      public function get aX() : int
      {
         return a_x$field;
      }
      
      public function removeAY() : void
      {
         hasField$0 &= 4294967291;
         a_y$field = new int();
      }
      
      public function get hasAY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set aY(param1:int) : void
      {
         hasField$0 |= 4;
         a_y$field = param1;
      }
      
      public function get aY() : int
      {
         return a_y$field;
      }
      
      public function removeBX() : void
      {
         hasField$0 &= 4294967287;
         b_x$field = new int();
      }
      
      public function get hasBX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bX(param1:int) : void
      {
         hasField$0 |= 8;
         b_x$field = param1;
      }
      
      public function get bX() : int
      {
         return b_x$field;
      }
      
      public function removeBY() : void
      {
         hasField$0 &= 4294967279;
         b_y$field = new int();
      }
      
      public function get hasBY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set bY(param1:int) : void
      {
         hasField$0 |= 16;
         b_y$field = param1;
      }
      
      public function get bY() : int
      {
         return b_y$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967263;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 32;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeTime() : void
      {
         hasField$0 &= 4294967231;
         time$field = new int();
      }
      
      public function get hasTime() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set time(param1:int) : void
      {
         hasField$0 |= 64;
         time$field = param1;
      }
      
      public function get time() : int
      {
         return time$field;
      }
      
      public function removeStrength() : void
      {
         hasField$0 &= 4294967167;
         strength$field = new int();
      }
      
      public function get hasStrength() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set strength(param1:int) : void
      {
         hasField$0 |= 128;
         strength$field = param1;
      }
      
      public function get strength() : int
      {
         return strength$field;
      }
      
      public function removePoints() : void
      {
         points$field = null;
      }
      
      public function get hasPoints() : Boolean
      {
         return points$field != null;
      }
      
      public function set points(param1:String) : void
      {
         points$field = param1;
      }
      
      public function get points() : String
      {
         return points$field;
      }
      
      public function removeBombCount() : void
      {
         hasField$0 &= 4294967039;
         bomb_count$field = new int();
      }
      
      public function get hasBombCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set bombCount(param1:int) : void
      {
         hasField$0 |= 256;
         bomb_count$field = param1;
      }
      
      public function get bombCount() : int
      {
         return bomb_count$field;
      }
      
      public function removeResetCount() : void
      {
         hasField$0 &= 4294966783;
         reset_count$field = new int();
      }
      
      public function get hasResetCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set resetCount(param1:int) : void
      {
         hasField$0 |= 512;
         reset_count$field = param1;
      }
      
      public function get resetCount() : int
      {
         return reset_count$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294966271;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 1024;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeTollgate() : void
      {
         hasField$0 &= 4294965247;
         tollgate$field = new int();
      }
      
      public function get hasTollgate() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set tollgate(param1:int) : void
      {
         hasField$0 |= 2048;
         tollgate$field = param1;
      }
      
      public function get tollgate() : int
      {
         return tollgate$field;
      }
      
      public function removeReward() : void
      {
         reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return reward$field != null;
      }
      
      public function set reward(param1:String) : void
      {
         reward$field = param1;
      }
      
      public function get reward() : String
      {
         return reward$field;
      }
      
      public function removeCombCount() : void
      {
         hasField$0 &= 4294963199;
         comb_count$field = new int();
      }
      
      public function get hasCombCount() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set combCount(param1:int) : void
      {
         hasField$0 |= 4096;
         comb_count$field = param1;
      }
      
      public function get combCount() : int
      {
         return comb_count$field;
      }
      
      public function removeAddScore() : void
      {
         hasField$0 &= 4294959103;
         add_score$field = new int();
      }
      
      public function get hasAddScore() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set addScore(param1:int) : void
      {
         hasField$0 |= 8192;
         add_score$field = param1;
      }
      
      public function get addScore() : int
      {
         return add_score$field;
      }
      
      public function removePointValue() : void
      {
         hasField$0 &= 4294950911;
         point_value$field = new int();
      }
      
      public function get hasPointValue() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set pointValue(param1:int) : void
      {
         hasField$0 |= 16384;
         point_value$field = param1;
      }
      
      public function get pointValue() : int
      {
         return point_value$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasAX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,a_x$field);
         }
         if(hasAY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,a_y$field);
         }
         if(hasBX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,b_x$field);
         }
         if(hasBY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,b_y$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasTime)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,time$field);
         }
         if(hasStrength)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,strength$field);
         }
         if(hasPoints)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,points$field);
         }
         if(hasBombCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,bomb_count$field);
         }
         if(hasResetCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,reset_count$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasTollgate)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,tollgate$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,reward$field);
         }
         if(hasCombCount)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,comb_count$field);
         }
         if(hasAddScore)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,add_score$field);
         }
         if(hasPointValue)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,point_value$field);
         }
         _loc2_ = 0;
         while(_loc2_ < scoreValue.length)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,scoreValue[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc18_:uint = 0;
         var _loc17_:uint = 0;
         var _loc13_:uint = 0;
         var _loc19_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc20_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.opType cannot be set twice.");
                  }
                  _loc12_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.aX cannot be set twice.");
                  }
                  _loc14_++;
                  aX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.aY cannot be set twice.");
                  }
                  _loc3_++;
                  aY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.bX cannot be set twice.");
                  }
                  _loc4_++;
                  bX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.bY cannot be set twice.");
                  }
                  _loc9_++;
                  bY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.score cannot be set twice.");
                  }
                  _loc18_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.time cannot be set twice.");
                  }
                  _loc17_++;
                  time = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.strength cannot be set twice.");
                  }
                  _loc13_++;
                  strength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.points cannot be set twice.");
                  }
                  _loc19_++;
                  points = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.bombCount cannot be set twice.");
                  }
                  _loc7_++;
                  bombCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.resetCount cannot be set twice.");
                  }
                  _loc8_++;
                  resetCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.tollgate cannot be set twice.");
                  }
                  _loc15_++;
                  tollgate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.reward cannot be set twice.");
                  }
                  _loc6_++;
                  reward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.combCount cannot be set twice.");
                  }
                  _loc10_++;
                  combCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.addScore cannot be set twice.");
                  }
                  _loc20_++;
                  addScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LinkGameMsg.pointValue cannot be set twice.");
                  }
                  _loc11_++;
                  pointValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if((_loc16_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,scoreValue);
                  }
                  else
                  {
                     scoreValue.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

