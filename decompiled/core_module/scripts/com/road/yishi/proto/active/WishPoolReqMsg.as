package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WishPoolReqMsg extends Message implements IExternalizable
   {
      
      private var optype$field:int;
      
      private var hasField$0:uint = 0;
      
      private var goodKey$field:int;
      
      private var buyCount$field:int;
      
      [ArrayElementType("int")]
      public var keys:Array = [];
      
      private var isUseProp$field:Boolean;
      
      public function WishPoolReqMsg()
      {
         super();
      }
      
      public function removeOptype() : void
      {
         hasField$0 &= 4294967294;
         optype$field = new int();
      }
      
      public function get hasOptype() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set optype(param1:int) : void
      {
         hasField$0 |= 1;
         optype$field = param1;
      }
      
      public function get optype() : int
      {
         return optype$field;
      }
      
      public function removeGoodKey() : void
      {
         hasField$0 &= 4294967293;
         goodKey$field = new int();
      }
      
      public function get hasGoodKey() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set goodKey(param1:int) : void
      {
         hasField$0 |= 2;
         goodKey$field = param1;
      }
      
      public function get goodKey() : int
      {
         return goodKey$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967291;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 4;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeIsUseProp() : void
      {
         hasField$0 &= 4294967287;
         isUseProp$field = new Boolean();
      }
      
      public function get hasIsUseProp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isUseProp(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isUseProp$field = param1;
      }
      
      public function get isUseProp() : Boolean
      {
         return isUseProp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOptype)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,optype$field);
         }
         if(hasGoodKey)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,goodKey$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < keys.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,keys[_loc2_]);
            _loc2_++;
         }
         if(hasIsUseProp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isUseProp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolReqMsg.optype cannot be set twice.");
                  }
                  _loc4_++;
                  optype = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolReqMsg.goodKey cannot be set twice.");
                  }
                  _loc7_++;
                  goodKey = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolReqMsg.buyCount cannot be set twice.");
                  }
                  _loc5_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,keys);
                  }
                  else
                  {
                     keys.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WishPoolReqMsg.isUseProp cannot be set twice.");
                  }
                  _loc3_++;
                  isUseProp = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

