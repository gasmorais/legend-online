package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossBufferMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var point_value$field:int;
      
      private var gift_value$field:int;
      
      private var op$field:int;
      
      private var result$field:int;
      
      private var wound$field:int;
      
      public function WorldBossBufferMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removePointValue() : void
      {
         hasField$0 &= 4294967293;
         point_value$field = new int();
      }
      
      public function get hasPointValue() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pointValue(param1:int) : void
      {
         hasField$0 |= 2;
         point_value$field = param1;
      }
      
      public function get pointValue() : int
      {
         return point_value$field;
      }
      
      public function removeGiftValue() : void
      {
         hasField$0 &= 4294967291;
         gift_value$field = new int();
      }
      
      public function get hasGiftValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set giftValue(param1:int) : void
      {
         hasField$0 |= 4;
         gift_value$field = param1;
      }
      
      public function get giftValue() : int
      {
         return gift_value$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967287;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 8;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967279;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 16;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeWound() : void
      {
         hasField$0 &= 4294967263;
         wound$field = new int();
      }
      
      public function get hasWound() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set wound(param1:int) : void
      {
         hasField$0 |= 32;
         wound$field = param1;
      }
      
      public function get wound() : int
      {
         return wound$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasPointValue)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,point_value$field);
         }
         if(hasGiftValue)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gift_value$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasWound)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,wound$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossBufferMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossBufferMsg.pointValue cannot be set twice.");
                  }
                  _loc3_++;
                  pointValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossBufferMsg.giftValue cannot be set twice.");
                  }
                  _loc4_++;
                  giftValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossBufferMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossBufferMsg.result cannot be set twice.");
                  }
                  _loc5_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossBufferMsg.wound cannot be set twice.");
                  }
                  _loc6_++;
                  wound = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

