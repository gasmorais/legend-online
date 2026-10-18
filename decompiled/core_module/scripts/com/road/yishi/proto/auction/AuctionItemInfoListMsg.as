package com.road.yishi.proto.auction
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AuctionItemInfoListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.auction.AuctionItemInfoMsg")]
      public var auctionItemInfos:Array = [];
      
      private var specialAuctionId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("String")]
      public var noticeTips:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.auction.AuctionItemInfoMsg")]
      public var allItemInfos:Array = [];
      
      private var leftSecond$field:int;
      
      public function AuctionItemInfoListMsg()
      {
         super();
      }
      
      public function removeSpecialAuctionId() : void
      {
         hasField$0 &= 4294967294;
         specialAuctionId$field = new int();
      }
      
      public function get hasSpecialAuctionId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set specialAuctionId(param1:int) : void
      {
         hasField$0 |= 1;
         specialAuctionId$field = param1;
      }
      
      public function get specialAuctionId() : int
      {
         return specialAuctionId$field;
      }
      
      public function removeLeftSecond() : void
      {
         hasField$0 &= 4294967293;
         leftSecond$field = new int();
      }
      
      public function get hasLeftSecond() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set leftSecond(param1:int) : void
      {
         hasField$0 |= 2;
         leftSecond$field = param1;
      }
      
      public function get leftSecond() : int
      {
         return leftSecond$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < auctionItemInfos.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,auctionItemInfos[_loc4_]);
            _loc4_++;
         }
         if(hasSpecialAuctionId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,specialAuctionId$field);
         }
         _loc3_ = 0;
         while(_loc3_ < noticeTips.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,noticeTips[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < allItemInfos.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,allItemInfos[_loc2_]);
            _loc2_++;
         }
         if(hasLeftSecond)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,leftSecond$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:AuctionItemInfoMsg = null;
         var _loc5_:AuctionItemInfoMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new AuctionItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  auctionItemInfos.push(_loc3_);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoListMsg.specialAuctionId cannot be set twice.");
                  }
                  _loc7_++;
                  specialAuctionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  noticeTips.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 3:
                  _loc5_ = new AuctionItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  allItemInfos.push(_loc5_);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoListMsg.leftSecond cannot be set twice.");
                  }
                  _loc4_++;
                  leftSecond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

