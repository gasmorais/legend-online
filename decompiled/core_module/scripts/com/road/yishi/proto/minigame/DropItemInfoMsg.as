package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DropItemInfoMsg extends Message implements IExternalizable
   {
      
      private var score$field:int;
      
      private var hasField$0:uint = 0;
      
      private var itemTempId$field:int;
      
      private var count$field:int;
      
      public function DropItemInfoMsg()
      {
         super();
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967294;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 1;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeItemTempId() : void
      {
         hasField$0 &= 4294967293;
         itemTempId$field = new int();
      }
      
      public function get hasItemTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemTempId(param1:int) : void
      {
         hasField$0 |= 2;
         itemTempId$field = param1;
      }
      
      public function get itemTempId() : int
      {
         return itemTempId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasItemTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,itemTempId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DropItemInfoMsg.score cannot be set twice.");
                  }
                  _loc6_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DropItemInfoMsg.itemTempId cannot be set twice.");
                  }
                  _loc3_++;
                  itemTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DropItemInfoMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

