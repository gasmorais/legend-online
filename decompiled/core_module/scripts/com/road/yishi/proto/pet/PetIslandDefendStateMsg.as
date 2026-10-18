package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetIslandDefendStateMsg extends Message implements IExternalizable
   {
      
      private var left_time$field:Int64;
      
      private var map_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var boss_id$field:int;
      
      private var peace_middle$field:int;
      
      private var peace_high$field:int;
      
      private var peace_boss$field:int;
      
      private var rage_point$field:int;
      
      public function PetIslandDefendStateMsg()
      {
         super();
      }
      
      public function removeLeftTime() : void
      {
         left_time$field = null;
      }
      
      public function get hasLeftTime() : Boolean
      {
         return left_time$field != null;
      }
      
      public function set leftTime(param1:Int64) : void
      {
         left_time$field = param1;
      }
      
      public function get leftTime() : Int64
      {
         return left_time$field;
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967294;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 1;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967293;
         boss_id$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 2;
         boss_id$field = param1;
      }
      
      public function get bossId() : int
      {
         return boss_id$field;
      }
      
      public function removePeaceMiddle() : void
      {
         hasField$0 &= 4294967291;
         peace_middle$field = new int();
      }
      
      public function get hasPeaceMiddle() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set peaceMiddle(param1:int) : void
      {
         hasField$0 |= 4;
         peace_middle$field = param1;
      }
      
      public function get peaceMiddle() : int
      {
         return peace_middle$field;
      }
      
      public function removePeaceHigh() : void
      {
         hasField$0 &= 4294967287;
         peace_high$field = new int();
      }
      
      public function get hasPeaceHigh() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set peaceHigh(param1:int) : void
      {
         hasField$0 |= 8;
         peace_high$field = param1;
      }
      
      public function get peaceHigh() : int
      {
         return peace_high$field;
      }
      
      public function removePeaceBoss() : void
      {
         hasField$0 &= 4294967279;
         peace_boss$field = new int();
      }
      
      public function get hasPeaceBoss() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set peaceBoss(param1:int) : void
      {
         hasField$0 |= 16;
         peace_boss$field = param1;
      }
      
      public function get peaceBoss() : int
      {
         return peace_boss$field;
      }
      
      public function removeRagePoint() : void
      {
         hasField$0 &= 4294967263;
         rage_point$field = new int();
      }
      
      public function get hasRagePoint() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set ragePoint(param1:int) : void
      {
         hasField$0 |= 32;
         rage_point$field = param1;
      }
      
      public function get ragePoint() : int
      {
         return rage_point$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT64(param1,left_time$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,boss_id$field);
         }
         if(hasPeaceMiddle)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,peace_middle$field);
         }
         if(hasPeaceHigh)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,peace_high$field);
         }
         if(hasPeaceBoss)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,peace_boss$field);
         }
         if(hasRagePoint)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,rage_point$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetIslandDefendStateMsg.leftTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PetIslandDefendStateMsg.mapId cannot be set twice.");
                  }
                  _loc8_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetIslandDefendStateMsg.bossId cannot be set twice.");
                  }
                  _loc3_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PetIslandDefendStateMsg.peaceMiddle cannot be set twice.");
                  }
                  _loc10_++;
                  peaceMiddle = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PetIslandDefendStateMsg.peaceHigh cannot be set twice.");
                  }
                  _loc5_++;
                  peaceHigh = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PetIslandDefendStateMsg.peaceBoss cannot be set twice.");
                  }
                  _loc6_++;
                  peaceBoss = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PetIslandDefendStateMsg.ragePoint cannot be set twice.");
                  }
                  _loc7_++;
                  ragePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

