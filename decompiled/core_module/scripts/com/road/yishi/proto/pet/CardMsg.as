package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CardMsg extends Message implements IExternalizable
   {
      
      private var rank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var suit$field:int;
      
      public function CardMsg()
      {
         super();
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967294;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 1;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeSuit() : void
      {
         hasField$0 &= 4294967293;
         suit$field = new int();
      }
      
      public function get hasSuit() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set suit(param1:int) : void
      {
         hasField$0 |= 2;
         suit$field = param1;
      }
      
      public function get suit() : int
      {
         return suit$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasSuit)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,suit$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CardMsg.rank cannot be set twice.");
                  }
                  _loc4_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CardMsg.suit cannot be set twice.");
                  }
                  _loc3_++;
                  suit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

