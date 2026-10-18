package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RollInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rollNum$field:int;
      
      private var isRoll$field:Boolean;
      
      private var isLast$field:Boolean;
      
      private var specialNums$field:int;
      
      public function RollInfoMsg()
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
      
      public function removeRollNum() : void
      {
         hasField$0 &= 4294967293;
         rollNum$field = new int();
      }
      
      public function get hasRollNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rollNum(param1:int) : void
      {
         hasField$0 |= 2;
         rollNum$field = param1;
      }
      
      public function get rollNum() : int
      {
         return rollNum$field;
      }
      
      public function removeIsRoll() : void
      {
         hasField$0 &= 4294967291;
         isRoll$field = new Boolean();
      }
      
      public function get hasIsRoll() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isRoll(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isRoll$field = param1;
      }
      
      public function get isRoll() : Boolean
      {
         return isRoll$field;
      }
      
      public function removeIsLast() : void
      {
         hasField$0 &= 4294967287;
         isLast$field = new Boolean();
      }
      
      public function get hasIsLast() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isLast(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isLast$field = param1;
      }
      
      public function get isLast() : Boolean
      {
         return isLast$field;
      }
      
      public function removeSpecialNums() : void
      {
         hasField$0 &= 4294967279;
         specialNums$field = new int();
      }
      
      public function get hasSpecialNums() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set specialNums(param1:int) : void
      {
         hasField$0 |= 16;
         specialNums$field = param1;
      }
      
      public function get specialNums() : int
      {
         return specialNums$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasRollNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rollNum$field);
         }
         if(hasIsRoll)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isRoll$field);
         }
         if(hasIsLast)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isLast$field);
         }
         if(hasSpecialNums)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,specialNums$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RollInfoMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RollInfoMsg.rollNum cannot be set twice.");
                  }
                  _loc3_++;
                  rollNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RollInfoMsg.isRoll cannot be set twice.");
                  }
                  _loc4_++;
                  isRoll = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RollInfoMsg.isLast cannot be set twice.");
                  }
                  _loc8_++;
                  isLast = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RollInfoMsg.specialNums cannot be set twice.");
                  }
                  _loc5_++;
                  specialNums = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

