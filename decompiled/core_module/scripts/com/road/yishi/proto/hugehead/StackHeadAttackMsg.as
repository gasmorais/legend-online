package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadAttackMsg extends Message implements IExternalizable
   {
      
      private var from_pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var to_pos$field:int;
      
      private var total_count$field:int;
      
      private var change_count$field:int;
      
      public function StackHeadAttackMsg()
      {
         super();
      }
      
      public function removeFromPos() : void
      {
         hasField$0 &= 4294967294;
         from_pos$field = new int();
      }
      
      public function get hasFromPos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fromPos(param1:int) : void
      {
         hasField$0 |= 1;
         from_pos$field = param1;
      }
      
      public function get fromPos() : int
      {
         return from_pos$field;
      }
      
      public function removeToPos() : void
      {
         hasField$0 &= 4294967293;
         to_pos$field = new int();
      }
      
      public function get hasToPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set toPos(param1:int) : void
      {
         hasField$0 |= 2;
         to_pos$field = param1;
      }
      
      public function get toPos() : int
      {
         return to_pos$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967291;
         total_count$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 4;
         total_count$field = param1;
      }
      
      public function get totalCount() : int
      {
         return total_count$field;
      }
      
      public function removeChangeCount() : void
      {
         hasField$0 &= 4294967287;
         change_count$field = new int();
      }
      
      public function get hasChangeCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set changeCount(param1:int) : void
      {
         hasField$0 |= 8;
         change_count$field = param1;
      }
      
      public function get changeCount() : int
      {
         return change_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFromPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,from_pos$field);
         }
         if(hasToPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,to_pos$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,total_count$field);
         }
         if(hasChangeCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,change_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadAttackMsg.fromPos cannot be set twice.");
                  }
                  _loc7_++;
                  fromPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadAttackMsg.toPos cannot be set twice.");
                  }
                  _loc3_++;
                  toPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadAttackMsg.totalCount cannot be set twice.");
                  }
                  _loc4_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadAttackMsg.changeCount cannot be set twice.");
                  }
                  _loc5_++;
                  changeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

