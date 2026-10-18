package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChallengeRankRewardMsg extends Message implements IExternalizable
   {
      
      private var is_take$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:int;
      
      private var param4$field:int;
      
      public function ChallengeRankRewardMsg()
      {
         super();
      }
      
      public function removeIsTake() : void
      {
         hasField$0 &= 4294967294;
         is_take$field = new Boolean();
      }
      
      public function get hasIsTake() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isTake(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_take$field = param1;
      }
      
      public function get isTake() : Boolean
      {
         return is_take$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967293;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 2;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967291;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 4;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         hasField$0 &= 4294967287;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 8;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         hasField$0 &= 4294967279;
         param4$field = new int();
      }
      
      public function get hasParam4() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param4(param1:int) : void
      {
         hasField$0 |= 16;
         param4$field = param1;
      }
      
      public function get param4() : int
      {
         return param4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsTake)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_take$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,param4$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeRankRewardMsg.isTake cannot be set twice.");
                  }
                  _loc3_++;
                  isTake = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeRankRewardMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeRankRewardMsg.param2 cannot be set twice.");
                  }
                  _loc8_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeRankRewardMsg.param3 cannot be set twice.");
                  }
                  _loc5_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeRankRewardMsg.param4 cannot be set twice.");
                  }
                  _loc7_++;
                  param4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

