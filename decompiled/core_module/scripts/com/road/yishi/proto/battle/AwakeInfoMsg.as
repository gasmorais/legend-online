package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AwakeInfoMsg extends Message implements IExternalizable
   {
      
      private var living_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var awake$field:int;
      
      private var childAwake$field:int;
      
      public function AwakeInfoMsg()
      {
         super();
      }
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967294;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 1;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeAwake() : void
      {
         hasField$0 &= 4294967293;
         awake$field = new int();
      }
      
      public function get hasAwake() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set awake(param1:int) : void
      {
         hasField$0 |= 2;
         awake$field = param1;
      }
      
      public function get awake() : int
      {
         return awake$field;
      }
      
      public function removeChildAwake() : void
      {
         hasField$0 &= 4294967291;
         childAwake$field = new int();
      }
      
      public function get hasChildAwake() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set childAwake(param1:int) : void
      {
         hasField$0 |= 4;
         childAwake$field = param1;
      }
      
      public function get childAwake() : int
      {
         return childAwake$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasAwake)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,awake$field);
         }
         if(hasChildAwake)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,childAwake$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AwakeInfoMsg.livingId cannot be set twice.");
                  }
                  _loc5_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AwakeInfoMsg.awake cannot be set twice.");
                  }
                  _loc3_++;
                  awake = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AwakeInfoMsg.childAwake cannot be set twice.");
                  }
                  _loc6_++;
                  childAwake = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

