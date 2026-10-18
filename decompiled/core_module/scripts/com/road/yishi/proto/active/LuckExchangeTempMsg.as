package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LuckExchangeTempMsg extends Message implements IExternalizable
   {
      
      private var id$field:String;
      
      private var name$field:String;
      
      private var consume_item_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consume_item_count$field:int;
      
      private var luck_value$field:int;
      
      private var start_time$field:String;
      
      private var end_time$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.LuckExchangeItemTempMsg")]
      public var dropItems:Array = [];
      
      public function LuckExchangeTempMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         id$field = null;
      }
      
      public function get hasId() : Boolean
      {
         return id$field != null;
      }
      
      public function set id(param1:String) : void
      {
         id$field = param1;
      }
      
      public function get id() : String
      {
         return id$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeConsumeItemId() : void
      {
         hasField$0 &= 4294967294;
         consume_item_id$field = new int();
      }
      
      public function get hasConsumeItemId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consumeItemId(param1:int) : void
      {
         hasField$0 |= 1;
         consume_item_id$field = param1;
      }
      
      public function get consumeItemId() : int
      {
         return consume_item_id$field;
      }
      
      public function removeConsumeItemCount() : void
      {
         hasField$0 &= 4294967293;
         consume_item_count$field = new int();
      }
      
      public function get hasConsumeItemCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set consumeItemCount(param1:int) : void
      {
         hasField$0 |= 2;
         consume_item_count$field = param1;
      }
      
      public function get consumeItemCount() : int
      {
         return consume_item_count$field;
      }
      
      public function removeLuckValue() : void
      {
         hasField$0 &= 4294967291;
         luck_value$field = new int();
      }
      
      public function get hasLuckValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set luckValue(param1:int) : void
      {
         hasField$0 |= 4;
         luck_value$field = param1;
      }
      
      public function get luckValue() : int
      {
         return luck_value$field;
      }
      
      public function removeStartTime() : void
      {
         start_time$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return start_time$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         start_time$field = param1;
      }
      
      public function get startTime() : String
      {
         return start_time$field;
      }
      
      public function removeEndTime() : void
      {
         end_time$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return end_time$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasConsumeItemId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,consume_item_id$field);
         }
         if(hasConsumeItemCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,consume_item_count$field);
         }
         if(hasLuckValue)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,luck_value$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
         _loc2_ = 0;
         while(_loc2_ < dropItems.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,dropItems[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc11_:LuckExchangeItemTempMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeTempMsg.id cannot be set twice.");
                  }
                  _loc7_++;
                  id = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeTempMsg.name cannot be set twice.");
                  }
                  _loc4_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeTempMsg.consumeItemId cannot be set twice.");
                  }
                  _loc3_++;
                  consumeItemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeTempMsg.consumeItemCount cannot be set twice.");
                  }
                  _loc5_++;
                  consumeItemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeTempMsg.luckValue cannot be set twice.");
                  }
                  _loc9_++;
                  luckValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeTempMsg.startTime cannot be set twice.");
                  }
                  _loc6_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LuckExchangeTempMsg.endTime cannot be set twice.");
                  }
                  _loc8_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  _loc11_ = new LuckExchangeItemTempMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  dropItems.push(_loc11_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

