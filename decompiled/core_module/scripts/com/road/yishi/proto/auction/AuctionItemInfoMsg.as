package com.road.yishi.proto.auction
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AuctionItemInfoMsg extends Message implements IExternalizable
   {
      
      private var auctionId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var counts$field:int;
      
      private var startPoint$field:int;
      
      private var fixPoint$field:int;
      
      private var seconds$field:int;
      
      private var buyPoint$field:int;
      
      private var buyUserId$field:int;
      
      private var states$field:int;
      
      private var currentPoint$field:int;
      
      private var op$field:int;
      
      private var index$field:int;
      
      private var currentBidUserId$field:int;
      
      public function AuctionItemInfoMsg()
      {
         super();
      }
      
      public function removeAuctionId() : void
      {
         hasField$0 &= 4294967294;
         auctionId$field = new int();
      }
      
      public function get hasAuctionId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set auctionId(param1:int) : void
      {
         hasField$0 |= 1;
         auctionId$field = param1;
      }
      
      public function get auctionId() : int
      {
         return auctionId$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeCounts() : void
      {
         hasField$0 &= 4294967291;
         counts$field = new int();
      }
      
      public function get hasCounts() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set counts(param1:int) : void
      {
         hasField$0 |= 4;
         counts$field = param1;
      }
      
      public function get counts() : int
      {
         return counts$field;
      }
      
      public function removeStartPoint() : void
      {
         hasField$0 &= 4294967287;
         startPoint$field = new int();
      }
      
      public function get hasStartPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set startPoint(param1:int) : void
      {
         hasField$0 |= 8;
         startPoint$field = param1;
      }
      
      public function get startPoint() : int
      {
         return startPoint$field;
      }
      
      public function removeFixPoint() : void
      {
         hasField$0 &= 4294967279;
         fixPoint$field = new int();
      }
      
      public function get hasFixPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fixPoint(param1:int) : void
      {
         hasField$0 |= 16;
         fixPoint$field = param1;
      }
      
      public function get fixPoint() : int
      {
         return fixPoint$field;
      }
      
      public function removeSeconds() : void
      {
         hasField$0 &= 4294967263;
         seconds$field = new int();
      }
      
      public function get hasSeconds() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set seconds(param1:int) : void
      {
         hasField$0 |= 32;
         seconds$field = param1;
      }
      
      public function get seconds() : int
      {
         return seconds$field;
      }
      
      public function removeBuyPoint() : void
      {
         hasField$0 &= 4294967231;
         buyPoint$field = new int();
      }
      
      public function get hasBuyPoint() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set buyPoint(param1:int) : void
      {
         hasField$0 |= 64;
         buyPoint$field = param1;
      }
      
      public function get buyPoint() : int
      {
         return buyPoint$field;
      }
      
      public function removeBuyUserId() : void
      {
         hasField$0 &= 4294967167;
         buyUserId$field = new int();
      }
      
      public function get hasBuyUserId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set buyUserId(param1:int) : void
      {
         hasField$0 |= 128;
         buyUserId$field = param1;
      }
      
      public function get buyUserId() : int
      {
         return buyUserId$field;
      }
      
      public function removeStates() : void
      {
         hasField$0 &= 4294967039;
         states$field = new int();
      }
      
      public function get hasStates() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set states(param1:int) : void
      {
         hasField$0 |= 256;
         states$field = param1;
      }
      
      public function get states() : int
      {
         return states$field;
      }
      
      public function removeCurrentPoint() : void
      {
         hasField$0 &= 4294966783;
         currentPoint$field = new int();
      }
      
      public function get hasCurrentPoint() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set currentPoint(param1:int) : void
      {
         hasField$0 |= 512;
         currentPoint$field = param1;
      }
      
      public function get currentPoint() : int
      {
         return currentPoint$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294966271;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1024;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294965247;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2048;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeCurrentBidUserId() : void
      {
         hasField$0 &= 4294963199;
         currentBidUserId$field = new int();
      }
      
      public function get hasCurrentBidUserId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set currentBidUserId(param1:int) : void
      {
         hasField$0 |= 4096;
         currentBidUserId$field = param1;
      }
      
      public function get currentBidUserId() : int
      {
         return currentBidUserId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAuctionId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,auctionId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasCounts)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,counts$field);
         }
         if(hasStartPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,startPoint$field);
         }
         if(hasFixPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fixPoint$field);
         }
         if(hasSeconds)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,seconds$field);
         }
         if(hasBuyPoint)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,buyPoint$field);
         }
         if(hasBuyUserId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,buyUserId$field);
         }
         if(hasStates)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,states$field);
         }
         if(hasCurrentPoint)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,currentPoint$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasCurrentBidUserId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,currentBidUserId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc16_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.auctionId cannot be set twice.");
                  }
                  _loc13_++;
                  auctionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.templateId cannot be set twice.");
                  }
                  _loc3_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.counts cannot be set twice.");
                  }
                  _loc8_++;
                  counts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.startPoint cannot be set twice.");
                  }
                  _loc4_++;
                  startPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.fixPoint cannot be set twice.");
                  }
                  _loc6_++;
                  fixPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.seconds cannot be set twice.");
                  }
                  _loc9_++;
                  seconds = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.buyPoint cannot be set twice.");
                  }
                  _loc15_++;
                  buyPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.buyUserId cannot be set twice.");
                  }
                  _loc12_++;
                  buyUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.states cannot be set twice.");
                  }
                  _loc10_++;
                  states = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.currentPoint cannot be set twice.");
                  }
                  _loc7_++;
                  currentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.op cannot be set twice.");
                  }
                  _loc16_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.index cannot be set twice.");
                  }
                  _loc11_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AuctionItemInfoMsg.currentBidUserId cannot be set twice.");
                  }
                  _loc5_++;
                  currentBidUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

