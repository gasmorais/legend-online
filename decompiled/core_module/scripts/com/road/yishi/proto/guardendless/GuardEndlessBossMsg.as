package com.road.yishi.proto.guardendless
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GuardEndlessBossMsg extends Message implements IExternalizable
   {
      
      private var bossOrder$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bossState$field:int;
      
      private var bossIndex$field:int;
      
      public function GuardEndlessBossMsg()
      {
         super();
      }
      
      public function removeBossOrder() : void
      {
         hasField$0 &= 4294967294;
         bossOrder$field = new int();
      }
      
      public function get hasBossOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bossOrder(param1:int) : void
      {
         hasField$0 |= 1;
         bossOrder$field = param1;
      }
      
      public function get bossOrder() : int
      {
         return bossOrder$field;
      }
      
      public function removeBossState() : void
      {
         hasField$0 &= 4294967293;
         bossState$field = new int();
      }
      
      public function get hasBossState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bossState(param1:int) : void
      {
         hasField$0 |= 2;
         bossState$field = param1;
      }
      
      public function get bossState() : int
      {
         return bossState$field;
      }
      
      public function removeBossIndex() : void
      {
         hasField$0 &= 4294967291;
         bossIndex$field = new int();
      }
      
      public function get hasBossIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bossIndex(param1:int) : void
      {
         hasField$0 |= 4;
         bossIndex$field = param1;
      }
      
      public function get bossIndex() : int
      {
         return bossIndex$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBossOrder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bossOrder$field);
         }
         if(hasBossState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bossState$field);
         }
         if(hasBossIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,bossIndex$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GuardEndlessBossMsg.bossOrder cannot be set twice.");
                  }
                  _loc3_++;
                  bossOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GuardEndlessBossMsg.bossState cannot be set twice.");
                  }
                  _loc6_++;
                  bossState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GuardEndlessBossMsg.bossIndex cannot be set twice.");
                  }
                  _loc4_++;
                  bossIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

