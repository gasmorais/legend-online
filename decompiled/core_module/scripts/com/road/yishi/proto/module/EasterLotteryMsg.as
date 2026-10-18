package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EasterLotteryMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var result:Array = [];
      
      private var lottery$field:String;
      
      private var num$field:int;
      
      public function EasterLotteryMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeLottery() : void
      {
         lottery$field = null;
      }
      
      public function get hasLottery() : Boolean
      {
         return lottery$field != null;
      }
      
      public function set lottery(param1:String) : void
      {
         lottery$field = param1;
      }
      
      public function get lottery() : String
      {
         return lottery$field;
      }
      
      public function removeNum() : void
      {
         hasField$0 &= 4294967293;
         num$field = new int();
      }
      
      public function get hasNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set num(param1:int) : void
      {
         hasField$0 |= 2;
         num$field = param1;
      }
      
      public function get num() : int
      {
         return num$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < result.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,result[_loc2_]);
            _loc2_++;
         }
         if(hasLottery)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,lottery$field);
         }
         if(hasNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,num$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EasterLotteryMsg.userId cannot be set twice.");
                  }
                  _loc4_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,result);
                  }
                  else
                  {
                     result.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EasterLotteryMsg.lottery cannot be set twice.");
                  }
                  _loc3_++;
                  lottery = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EasterLotteryMsg.num cannot be set twice.");
                  }
                  _loc6_++;
                  num = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

