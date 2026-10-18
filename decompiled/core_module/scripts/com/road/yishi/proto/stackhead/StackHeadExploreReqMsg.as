package com.road.yishi.proto.stackhead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadExploreReqMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      private var dice_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("String")]
      public var linePath:Array = [];
      
      private var payType$field:int;
      
      public function StackHeadExploreReqMsg()
      {
         super();
      }
      
      public function removeDiceId() : void
      {
         hasField$0 &= 4294967294;
         dice_id$field = new int();
      }
      
      public function get hasDiceId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set diceId(param1:int) : void
      {
         hasField$0 |= 1;
         dice_id$field = param1;
      }
      
      public function get diceId() : int
      {
         return dice_id$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_ENUM(param1,op);
         if(hasDiceId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,dice_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < linePath.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,linePath[_loc2_]);
            _loc2_++;
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
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
                     throw new IOError("Bad data format: StackHeadExploreReqMsg.op cannot be set twice.");
                  }
                  _loc6_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreReqMsg.diceId cannot be set twice.");
                  }
                  _loc3_++;
                  diceId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  linePath.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreReqMsg.payType cannot be set twice.");
                  }
                  _loc4_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc6_ != 1)
         {
            throw new IOError("Bad data format: StackHeadExploreReqMsg.op must be set.");
         }
      }
   }
}

