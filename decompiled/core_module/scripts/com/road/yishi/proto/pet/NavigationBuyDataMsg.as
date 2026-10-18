package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NavigationBuyDataMsg extends Message implements IExternalizable
   {
      
      private var shopId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var index$field:int;
      
      private var buy$field:Boolean;
      
      public function NavigationBuyDataMsg()
      {
         super();
      }
      
      public function removeShopId() : void
      {
         hasField$0 &= 4294967294;
         shopId$field = new int();
      }
      
      public function get hasShopId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set shopId(param1:int) : void
      {
         hasField$0 |= 1;
         shopId$field = param1;
      }
      
      public function get shopId() : int
      {
         return shopId$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeBuy() : void
      {
         hasField$0 &= 4294967291;
         buy$field = new Boolean();
      }
      
      public function get hasBuy() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buy(param1:Boolean) : void
      {
         hasField$0 |= 4;
         buy$field = param1;
      }
      
      public function get buy() : Boolean
      {
         return buy$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasShopId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,shopId$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasBuy)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,buy$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationBuyDataMsg.shopId cannot be set twice.");
                  }
                  _loc5_++;
                  shopId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationBuyDataMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NavigationBuyDataMsg.buy cannot be set twice.");
                  }
                  _loc4_++;
                  buy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

