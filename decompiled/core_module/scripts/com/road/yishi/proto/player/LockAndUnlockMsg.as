package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LockAndUnlockMsg extends Message implements IExternalizable
   {
      
      private var op_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var item_pos$field:int;
      
      private var pet_id$field:int;
      
      public function LockAndUnlockMsg()
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
      
      public function removeItemPos() : void
      {
         hasField$0 &= 4294967293;
         item_pos$field = new int();
      }
      
      public function get hasItemPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemPos(param1:int) : void
      {
         hasField$0 |= 2;
         item_pos$field = param1;
      }
      
      public function get itemPos() : int
      {
         return item_pos$field;
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967291;
         pet_id$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 4;
         pet_id$field = param1;
      }
      
      public function get petId() : int
      {
         return pet_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasItemPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,item_pos$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pet_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LockAndUnlockMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LockAndUnlockMsg.itemPos cannot be set twice.");
                  }
                  _loc3_++;
                  itemPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LockAndUnlockMsg.petId cannot be set twice.");
                  }
                  _loc5_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

