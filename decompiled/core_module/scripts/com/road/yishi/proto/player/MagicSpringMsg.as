package com.road.yishi.proto.player
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MagicSpringMsg extends Message implements IExternalizable
   {
      
      private var open_slot_count$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.player.MagicSpringSlotMsg")]
      public var slotList:Array = [];
      
      private var potion_count_1$field:int;
      
      private var potion_count_2$field:int;
      
      private var potion_count_3$field:int;
      
      private var new_temp_id$field:int;
      
      public function MagicSpringMsg()
      {
         super();
      }
      
      public function removeOpenSlotCount() : void
      {
         hasField$0 &= 4294967294;
         open_slot_count$field = new int();
      }
      
      public function get hasOpenSlotCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set openSlotCount(param1:int) : void
      {
         hasField$0 |= 1;
         open_slot_count$field = param1;
      }
      
      public function get openSlotCount() : int
      {
         return open_slot_count$field;
      }
      
      public function removePotionCount_1() : void
      {
         hasField$0 &= 4294967293;
         potion_count_1$field = new int();
      }
      
      public function get hasPotionCount_1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set potionCount_1(param1:int) : void
      {
         hasField$0 |= 2;
         potion_count_1$field = param1;
      }
      
      public function get potionCount_1() : int
      {
         return potion_count_1$field;
      }
      
      public function removePotionCount_2() : void
      {
         hasField$0 &= 4294967291;
         potion_count_2$field = new int();
      }
      
      public function get hasPotionCount_2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set potionCount_2(param1:int) : void
      {
         hasField$0 |= 4;
         potion_count_2$field = param1;
      }
      
      public function get potionCount_2() : int
      {
         return potion_count_2$field;
      }
      
      public function removePotionCount_3() : void
      {
         hasField$0 &= 4294967287;
         potion_count_3$field = new int();
      }
      
      public function get hasPotionCount_3() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set potionCount_3(param1:int) : void
      {
         hasField$0 |= 8;
         potion_count_3$field = param1;
      }
      
      public function get potionCount_3() : int
      {
         return potion_count_3$field;
      }
      
      public function removeNewTempId() : void
      {
         hasField$0 &= 4294967279;
         new_temp_id$field = new int();
      }
      
      public function get hasNewTempId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set newTempId(param1:int) : void
      {
         hasField$0 |= 16;
         new_temp_id$field = param1;
      }
      
      public function get newTempId() : int
      {
         return new_temp_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpenSlotCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,open_slot_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < slotList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,slotList[_loc2_]);
            _loc2_++;
         }
         if(hasPotionCount_1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,potion_count_1$field);
         }
         if(hasPotionCount_2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,potion_count_2$field);
         }
         if(hasPotionCount_3)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,potion_count_3$field);
         }
         if(hasNewTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,new_temp_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:MagicSpringSlotMsg = null;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MagicSpringMsg.openSlotCount cannot be set twice.");
                  }
                  _loc5_++;
                  openSlotCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new MagicSpringSlotMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  slotList.push(_loc4_);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MagicSpringMsg.potionCount_1 cannot be set twice.");
                  }
                  _loc7_++;
                  potionCount_1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MagicSpringMsg.potionCount_2 cannot be set twice.");
                  }
                  _loc9_++;
                  potionCount_2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MagicSpringMsg.potionCount_3 cannot be set twice.");
                  }
                  _loc6_++;
                  potionCount_3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MagicSpringMsg.newTempId cannot be set twice.");
                  }
                  _loc3_++;
                  newTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

