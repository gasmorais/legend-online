package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MallItemBuyMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var mall_item$field:MallItemMsg;
      
      private var bidup_point$field:int;
      
      private var buy_time$field:String;
      
      public function MallItemBuyMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeMallItem() : void
      {
         mall_item$field = null;
      }
      
      public function get hasMallItem() : Boolean
      {
         return mall_item$field != null;
      }
      
      public function set mallItem(param1:MallItemMsg) : void
      {
         mall_item$field = param1;
      }
      
      public function get mallItem() : MallItemMsg
      {
         return mall_item$field;
      }
      
      public function removeBidupPoint() : void
      {
         hasField$0 &= 4294967291;
         bidup_point$field = new int();
      }
      
      public function get hasBidupPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bidupPoint(param1:int) : void
      {
         hasField$0 |= 4;
         bidup_point$field = param1;
      }
      
      public function get bidupPoint() : int
      {
         return bidup_point$field;
      }
      
      public function removeBuyTime() : void
      {
         buy_time$field = null;
      }
      
      public function get hasBuyTime() : Boolean
      {
         return buy_time$field != null;
      }
      
      public function set buyTime(param1:String) : void
      {
         buy_time$field = param1;
      }
      
      public function get buyTime() : String
      {
         return buy_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasMallItem)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,mall_item$field);
         }
         if(hasBidupPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,bidup_point$field);
         }
         if(hasBuyTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,buy_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemBuyMsg.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemBuyMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemBuyMsg.mallItem cannot be set twice.");
                  }
                  _loc5_++;
                  mallItem = new MallItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,mallItem);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemBuyMsg.bidupPoint cannot be set twice.");
                  }
                  _loc7_++;
                  bidupPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemBuyMsg.buyTime cannot be set twice.");
                  }
                  _loc3_++;
                  buyTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

