package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaOrderInfoMsg extends Message implements IExternalizable
   {
      
      private var consortia_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade_order$field:int;
      
      private var fight_power_order$field:int;
      
      private var last_day_offer$field:int;
      
      private var last_day_order$field:int;
      
      private var last_week_offer$field:int;
      
      private var last_week_order$field:int;
      
      private var offer$field:int;
      
      private var last_day_date$field:String;
      
      private var last_week_date$field:String;
      
      public function ConsortiaOrderInfoMsg()
      {
         super();
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967294;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 1;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
      }
      
      public function removeGradeOrder() : void
      {
         hasField$0 &= 4294967293;
         grade_order$field = new int();
      }
      
      public function get hasGradeOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gradeOrder(param1:int) : void
      {
         hasField$0 |= 2;
         grade_order$field = param1;
      }
      
      public function get gradeOrder() : int
      {
         return grade_order$field;
      }
      
      public function removeFightPowerOrder() : void
      {
         hasField$0 &= 4294967291;
         fight_power_order$field = new int();
      }
      
      public function get hasFightPowerOrder() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightPowerOrder(param1:int) : void
      {
         hasField$0 |= 4;
         fight_power_order$field = param1;
      }
      
      public function get fightPowerOrder() : int
      {
         return fight_power_order$field;
      }
      
      public function removeLastDayOffer() : void
      {
         hasField$0 &= 4294967287;
         last_day_offer$field = new int();
      }
      
      public function get hasLastDayOffer() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set lastDayOffer(param1:int) : void
      {
         hasField$0 |= 8;
         last_day_offer$field = param1;
      }
      
      public function get lastDayOffer() : int
      {
         return last_day_offer$field;
      }
      
      public function removeLastDayOrder() : void
      {
         hasField$0 &= 4294967279;
         last_day_order$field = new int();
      }
      
      public function get hasLastDayOrder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set lastDayOrder(param1:int) : void
      {
         hasField$0 |= 16;
         last_day_order$field = param1;
      }
      
      public function get lastDayOrder() : int
      {
         return last_day_order$field;
      }
      
      public function removeLastWeekOffer() : void
      {
         hasField$0 &= 4294967263;
         last_week_offer$field = new int();
      }
      
      public function get hasLastWeekOffer() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set lastWeekOffer(param1:int) : void
      {
         hasField$0 |= 32;
         last_week_offer$field = param1;
      }
      
      public function get lastWeekOffer() : int
      {
         return last_week_offer$field;
      }
      
      public function removeLastWeekOrder() : void
      {
         hasField$0 &= 4294967231;
         last_week_order$field = new int();
      }
      
      public function get hasLastWeekOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set lastWeekOrder(param1:int) : void
      {
         hasField$0 |= 64;
         last_week_order$field = param1;
      }
      
      public function get lastWeekOrder() : int
      {
         return last_week_order$field;
      }
      
      public function removeOffer() : void
      {
         hasField$0 &= 4294967167;
         offer$field = new int();
      }
      
      public function get hasOffer() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set offer(param1:int) : void
      {
         hasField$0 |= 128;
         offer$field = param1;
      }
      
      public function get offer() : int
      {
         return offer$field;
      }
      
      public function removeLastDayDate() : void
      {
         last_day_date$field = null;
      }
      
      public function get hasLastDayDate() : Boolean
      {
         return last_day_date$field != null;
      }
      
      public function set lastDayDate(param1:String) : void
      {
         last_day_date$field = param1;
      }
      
      public function get lastDayDate() : String
      {
         return last_day_date$field;
      }
      
      public function removeLastWeekDate() : void
      {
         last_week_date$field = null;
      }
      
      public function get hasLastWeekDate() : Boolean
      {
         return last_week_date$field != null;
      }
      
      public function set lastWeekDate(param1:String) : void
      {
         last_week_date$field = param1;
      }
      
      public function get lastWeekDate() : String
      {
         return last_week_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasGradeOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grade_order$field);
         }
         if(hasFightPowerOrder)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fight_power_order$field);
         }
         if(hasLastDayOffer)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,last_day_offer$field);
         }
         if(hasLastDayOrder)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,last_day_order$field);
         }
         if(hasLastWeekOffer)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,last_week_offer$field);
         }
         if(hasLastWeekOrder)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,last_week_order$field);
         }
         if(hasOffer)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,offer$field);
         }
         if(hasLastDayDate)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,last_day_date$field);
         }
         if(hasLastWeekDate)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,last_week_date$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.consortiaId cannot be set twice.");
                  }
                  _loc11_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.gradeOrder cannot be set twice.");
                  }
                  _loc5_++;
                  gradeOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.fightPowerOrder cannot be set twice.");
                  }
                  _loc6_++;
                  fightPowerOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.lastDayOffer cannot be set twice.");
                  }
                  _loc7_++;
                  lastDayOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.lastDayOrder cannot be set twice.");
                  }
                  _loc9_++;
                  lastDayOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.lastWeekOffer cannot be set twice.");
                  }
                  _loc13_++;
                  lastWeekOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.lastWeekOrder cannot be set twice.");
                  }
                  _loc10_++;
                  lastWeekOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.offer cannot be set twice.");
                  }
                  _loc4_++;
                  offer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.lastDayDate cannot be set twice.");
                  }
                  _loc8_++;
                  lastDayDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaOrderInfoMsg.lastWeekDate cannot be set twice.");
                  }
                  _loc3_++;
                  lastWeekDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

