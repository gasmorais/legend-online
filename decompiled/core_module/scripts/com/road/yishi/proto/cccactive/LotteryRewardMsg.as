package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LotteryRewardMsg extends Message implements IExternalizable
   {
      
      private var point1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var point2$field:int;
      
      private var point3$field:int;
      
      private var point4$field:int;
      
      private var point5$field:int;
      
      private var point6$field:int;
      
      private var level$field:int;
      
      private var needPoint$field:int;
      
      public function LotteryRewardMsg()
      {
         super();
      }
      
      public function removePoint1() : void
      {
         hasField$0 &= 4294967294;
         point1$field = new int();
      }
      
      public function get hasPoint1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set point1(param1:int) : void
      {
         hasField$0 |= 1;
         point1$field = param1;
      }
      
      public function get point1() : int
      {
         return point1$field;
      }
      
      public function removePoint2() : void
      {
         hasField$0 &= 4294967293;
         point2$field = new int();
      }
      
      public function get hasPoint2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set point2(param1:int) : void
      {
         hasField$0 |= 2;
         point2$field = param1;
      }
      
      public function get point2() : int
      {
         return point2$field;
      }
      
      public function removePoint3() : void
      {
         hasField$0 &= 4294967291;
         point3$field = new int();
      }
      
      public function get hasPoint3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set point3(param1:int) : void
      {
         hasField$0 |= 4;
         point3$field = param1;
      }
      
      public function get point3() : int
      {
         return point3$field;
      }
      
      public function removePoint4() : void
      {
         hasField$0 &= 4294967287;
         point4$field = new int();
      }
      
      public function get hasPoint4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set point4(param1:int) : void
      {
         hasField$0 |= 8;
         point4$field = param1;
      }
      
      public function get point4() : int
      {
         return point4$field;
      }
      
      public function removePoint5() : void
      {
         hasField$0 &= 4294967279;
         point5$field = new int();
      }
      
      public function get hasPoint5() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set point5(param1:int) : void
      {
         hasField$0 |= 16;
         point5$field = param1;
      }
      
      public function get point5() : int
      {
         return point5$field;
      }
      
      public function removePoint6() : void
      {
         hasField$0 &= 4294967263;
         point6$field = new int();
      }
      
      public function get hasPoint6() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set point6(param1:int) : void
      {
         hasField$0 |= 32;
         point6$field = param1;
      }
      
      public function get point6() : int
      {
         return point6$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967231;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 64;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeNeedPoint() : void
      {
         hasField$0 &= 4294967167;
         needPoint$field = new int();
      }
      
      public function get hasNeedPoint() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set needPoint(param1:int) : void
      {
         hasField$0 |= 128;
         needPoint$field = param1;
      }
      
      public function get needPoint() : int
      {
         return needPoint$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPoint1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,point1$field);
         }
         if(hasPoint2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,point2$field);
         }
         if(hasPoint3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,point3$field);
         }
         if(hasPoint4)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,point4$field);
         }
         if(hasPoint5)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,point5$field);
         }
         if(hasPoint6)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,point6$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasNeedPoint)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,needPoint$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.point1 cannot be set twice.");
                  }
                  _loc6_++;
                  point1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.point2 cannot be set twice.");
                  }
                  _loc5_++;
                  point2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.point3 cannot be set twice.");
                  }
                  _loc9_++;
                  point3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.point4 cannot be set twice.");
                  }
                  _loc7_++;
                  point4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.point5 cannot be set twice.");
                  }
                  _loc3_++;
                  point5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.point6 cannot be set twice.");
                  }
                  _loc8_++;
                  point6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.level cannot be set twice.");
                  }
                  _loc4_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRewardMsg.needPoint cannot be set twice.");
                  }
                  _loc11_++;
                  needPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

