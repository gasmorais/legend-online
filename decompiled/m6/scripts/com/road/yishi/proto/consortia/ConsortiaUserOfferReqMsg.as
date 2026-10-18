package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaUserOfferReqMsg extends Message implements IExternalizable
   {
      
      private var offer_gold$field:int;
      
      private var hasField$0:uint = 0;
      
      private var offer_point$field:int;
      
      public function ConsortiaUserOfferReqMsg()
      {
         super();
      }
      
      public function removeOfferGold() : void
      {
         hasField$0 &= 4294967294;
         offer_gold$field = new int();
      }
      
      public function get hasOfferGold() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set offerGold(param1:int) : void
      {
         hasField$0 |= 1;
         offer_gold$field = param1;
      }
      
      public function get offerGold() : int
      {
         return offer_gold$field;
      }
      
      public function removeOfferPoint() : void
      {
         hasField$0 &= 4294967293;
         offer_point$field = new int();
      }
      
      public function get hasOfferPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set offerPoint(param1:int) : void
      {
         hasField$0 |= 2;
         offer_point$field = param1;
      }
      
      public function get offerPoint() : int
      {
         return offer_point$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOfferGold)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,offer_gold$field);
         }
         if(hasOfferPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,offer_point$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserOfferReqMsg.offerGold cannot be set twice.");
                  }
                  _loc5_++;
                  offerGold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaUserOfferReqMsg.offerPoint cannot be set twice.");
                  }
                  _loc3_++;
                  offerPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

