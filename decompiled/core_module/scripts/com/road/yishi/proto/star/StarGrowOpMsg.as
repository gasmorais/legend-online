package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarGrowOpMsg extends Message implements IExternalizable
   {
      
      private var starType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var starPos$field:int;
      
      private var itemCount$field:int;
      
      private var opType$field:int;
      
      public function StarGrowOpMsg()
      {
         super();
      }
      
      public function removeStarType() : void
      {
         hasField$0 &= 4294967294;
         starType$field = new int();
      }
      
      public function get hasStarType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set starType(param1:int) : void
      {
         hasField$0 |= 1;
         starType$field = param1;
      }
      
      public function get starType() : int
      {
         return starType$field;
      }
      
      public function removeStarPos() : void
      {
         hasField$0 &= 4294967293;
         starPos$field = new int();
      }
      
      public function get hasStarPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set starPos(param1:int) : void
      {
         hasField$0 |= 2;
         starPos$field = param1;
      }
      
      public function get starPos() : int
      {
         return starPos$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967291;
         itemCount$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 4;
         itemCount$field = param1;
      }
      
      public function get itemCount() : int
      {
         return itemCount$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967287;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 8;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasStarType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,starType$field);
         }
         if(hasStarPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,starPos$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,itemCount$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StarGrowOpMsg.starType cannot be set twice.");
                  }
                  _loc7_++;
                  starType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarGrowOpMsg.starPos cannot be set twice.");
                  }
                  _loc4_++;
                  starPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarGrowOpMsg.itemCount cannot be set twice.");
                  }
                  _loc3_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StarGrowOpMsg.opType cannot be set twice.");
                  }
                  _loc5_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

