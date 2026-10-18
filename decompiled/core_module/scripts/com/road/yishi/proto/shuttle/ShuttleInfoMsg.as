package com.road.yishi.proto.shuttle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShuttleInfoMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var current_difficulty$field:int;
      
      [ArrayElementType("int")]
      public var petList:Array = [];
      
      [ArrayElementType("int")]
      public var petHpPercent:Array = [];
      
      private var fight_pet$field:int;
      
      [ArrayElementType("int")]
      public var areaLeftCount:Array = [];
      
      [ArrayElementType("Boolean")]
      public var rewardState:Array = [];
      
      private var arcane_zone_count$field:int;
      
      private var shuttle_score$field:int;
      
      private var reset_count$field:int;
      
      private var refresh_count$field:int;
      
      public function ShuttleInfoMsg()
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
      
      public function removeCurrentDifficulty() : void
      {
         hasField$0 &= 4294967293;
         current_difficulty$field = new int();
      }
      
      public function get hasCurrentDifficulty() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentDifficulty(param1:int) : void
      {
         hasField$0 |= 2;
         current_difficulty$field = param1;
      }
      
      public function get currentDifficulty() : int
      {
         return current_difficulty$field;
      }
      
      public function removeFightPet() : void
      {
         hasField$0 &= 4294967291;
         fight_pet$field = new int();
      }
      
      public function get hasFightPet() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightPet(param1:int) : void
      {
         hasField$0 |= 4;
         fight_pet$field = param1;
      }
      
      public function get fightPet() : int
      {
         return fight_pet$field;
      }
      
      public function removeArcaneZoneCount() : void
      {
         hasField$0 &= 4294967287;
         arcane_zone_count$field = new int();
      }
      
      public function get hasArcaneZoneCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set arcaneZoneCount(param1:int) : void
      {
         hasField$0 |= 8;
         arcane_zone_count$field = param1;
      }
      
      public function get arcaneZoneCount() : int
      {
         return arcane_zone_count$field;
      }
      
      public function removeShuttleScore() : void
      {
         hasField$0 &= 4294967279;
         shuttle_score$field = new int();
      }
      
      public function get hasShuttleScore() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set shuttleScore(param1:int) : void
      {
         hasField$0 |= 16;
         shuttle_score$field = param1;
      }
      
      public function get shuttleScore() : int
      {
         return shuttle_score$field;
      }
      
      public function removeResetCount() : void
      {
         hasField$0 &= 4294967263;
         reset_count$field = new int();
      }
      
      public function get hasResetCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set resetCount(param1:int) : void
      {
         hasField$0 |= 32;
         reset_count$field = param1;
      }
      
      public function get resetCount() : int
      {
         return reset_count$field;
      }
      
      public function removeRefreshCount() : void
      {
         hasField$0 &= 4294967231;
         refresh_count$field = new int();
      }
      
      public function get hasRefreshCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set refreshCount(param1:int) : void
      {
         hasField$0 |= 64;
         refresh_count$field = param1;
      }
      
      public function get refreshCount() : int
      {
         return refresh_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasCurrentDifficulty)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,current_difficulty$field);
         }
         _loc4_ = 0;
         while(_loc4_ < petList.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,petList[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < petHpPercent.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,petHpPercent[_loc2_]);
            _loc2_++;
         }
         if(hasFightPet)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fight_pet$field);
         }
         _loc3_ = 0;
         while(_loc3_ < areaLeftCount.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,areaLeftCount[_loc3_]);
            _loc3_++;
         }
         _loc5_ = 0;
         while(_loc5_ < rewardState.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,rewardState[_loc5_]);
            _loc5_++;
         }
         if(hasArcaneZoneCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,arcane_zone_count$field);
         }
         if(hasShuttleScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,shuttle_score$field);
         }
         if(hasResetCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,reset_count$field);
         }
         if(hasRefreshCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,refresh_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleInfoMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleInfoMsg.currentDifficulty cannot be set twice.");
                  }
                  _loc3_++;
                  currentDifficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,petList);
                  }
                  else
                  {
                     petList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,petHpPercent);
                  }
                  else
                  {
                     petHpPercent.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleInfoMsg.fightPet cannot be set twice.");
                  }
                  _loc5_++;
                  fightPet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,areaLeftCount);
                  }
                  else
                  {
                     areaLeftCount.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_BOOL,rewardState);
                  }
                  else
                  {
                     rewardState.push(ReadUtils.read$TYPE_BOOL(param1));
                  }
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleInfoMsg.arcaneZoneCount cannot be set twice.");
                  }
                  _loc7_++;
                  arcaneZoneCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleInfoMsg.shuttleScore cannot be set twice.");
                  }
                  _loc6_++;
                  shuttleScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleInfoMsg.resetCount cannot be set twice.");
                  }
                  _loc9_++;
                  resetCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShuttleInfoMsg.refreshCount cannot be set twice.");
                  }
                  _loc4_++;
                  refreshCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

