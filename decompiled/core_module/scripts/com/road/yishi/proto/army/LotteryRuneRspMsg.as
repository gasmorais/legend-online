package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LotteryRuneRspMsg extends Message implements IExternalizable
   {
      
      private var powerPointNum$field:int;
      
      private var hasField$0:uint = 0;
      
      private var runeChipNum$field:int;
      
      private var runePointNum$field:int;
      
      private var leftTime$field:int;
      
      private var tenSpotCount$field:int;
      
      private var items$field:String;
      
      public function LotteryRuneRspMsg()
      {
         super();
      }
      
      public function removePowerPointNum() : void
      {
         hasField$0 &= 4294967294;
         powerPointNum$field = new int();
      }
      
      public function get hasPowerPointNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set powerPointNum(param1:int) : void
      {
         hasField$0 |= 1;
         powerPointNum$field = param1;
      }
      
      public function get powerPointNum() : int
      {
         return powerPointNum$field;
      }
      
      public function removeRuneChipNum() : void
      {
         hasField$0 &= 4294967293;
         runeChipNum$field = new int();
      }
      
      public function get hasRuneChipNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set runeChipNum(param1:int) : void
      {
         hasField$0 |= 2;
         runeChipNum$field = param1;
      }
      
      public function get runeChipNum() : int
      {
         return runeChipNum$field;
      }
      
      public function removeRunePointNum() : void
      {
         hasField$0 &= 4294967291;
         runePointNum$field = new int();
      }
      
      public function get hasRunePointNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set runePointNum(param1:int) : void
      {
         hasField$0 |= 4;
         runePointNum$field = param1;
      }
      
      public function get runePointNum() : int
      {
         return runePointNum$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967287;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 8;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
      }
      
      public function removeTenSpotCount() : void
      {
         hasField$0 &= 4294967279;
         tenSpotCount$field = new int();
      }
      
      public function get hasTenSpotCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set tenSpotCount(param1:int) : void
      {
         hasField$0 |= 16;
         tenSpotCount$field = param1;
      }
      
      public function get tenSpotCount() : int
      {
         return tenSpotCount$field;
      }
      
      public function removeItems() : void
      {
         items$field = null;
      }
      
      public function get hasItems() : Boolean
      {
         return items$field != null;
      }
      
      public function set items(param1:String) : void
      {
         items$field = param1;
      }
      
      public function get items() : String
      {
         return items$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPowerPointNum)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,powerPointNum$field);
         }
         if(hasRuneChipNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,runeChipNum$field);
         }
         if(hasRunePointNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,runePointNum$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         if(hasTenSpotCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,tenSpotCount$field);
         }
         if(hasItems)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,items$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRuneRspMsg.powerPointNum cannot be set twice.");
                  }
                  _loc7_++;
                  powerPointNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRuneRspMsg.runeChipNum cannot be set twice.");
                  }
                  _loc5_++;
                  runeChipNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRuneRspMsg.runePointNum cannot be set twice.");
                  }
                  _loc4_++;
                  runePointNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRuneRspMsg.leftTime cannot be set twice.");
                  }
                  _loc9_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRuneRspMsg.tenSpotCount cannot be set twice.");
                  }
                  _loc3_++;
                  tenSpotCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRuneRspMsg.items cannot be set twice.");
                  }
                  _loc8_++;
                  items = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

