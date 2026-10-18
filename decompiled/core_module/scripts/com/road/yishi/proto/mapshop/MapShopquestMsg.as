package com.road.yishi.proto.mapshop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MapShopquestMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var para1$field:int;
      
      private var para2$field:int;
      
      private var payType$field:int;
      
      public function MapShopquestMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removePara1() : void
      {
         hasField$0 &= 4294967293;
         para1$field = new int();
      }
      
      public function get hasPara1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set para1(param1:int) : void
      {
         hasField$0 |= 2;
         para1$field = param1;
      }
      
      public function get para1() : int
      {
         return para1$field;
      }
      
      public function removePara2() : void
      {
         hasField$0 &= 4294967291;
         para2$field = new int();
      }
      
      public function get hasPara2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set para2(param1:int) : void
      {
         hasField$0 |= 4;
         para2$field = param1;
      }
      
      public function get para2() : int
      {
         return para2$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967287;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 8;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasPara1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,para1$field);
         }
         if(hasPara2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,para2$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopquestMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopquestMsg.para1 cannot be set twice.");
                  }
                  _loc5_++;
                  para1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopquestMsg.para2 cannot be set twice.");
                  }
                  _loc4_++;
                  para2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MapShopquestMsg.payType cannot be set twice.");
                  }
                  _loc3_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

