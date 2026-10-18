package com.road.yishi.proto.daylight
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DayLightTeamInfoMsg extends Message implements IExternalizable
   {
      
      private var teamCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var teamScore$field:int;
      
      private var defendCount$field:int;
      
      private var blessCount$field:int;
      
      private var towerHp$field:int;
      
      private var towerMaxHp$field:int;
      
      private var leftNpcCount$field:int;
      
      private var createNpcCd$field:int;
      
      private var assaultCount$field:int;
      
      private var consortiaName$field:String;
      
      public function DayLightTeamInfoMsg()
      {
         super();
      }
      
      public function removeTeamCount() : void
      {
         hasField$0 &= 4294967294;
         teamCount$field = new int();
      }
      
      public function get hasTeamCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set teamCount(param1:int) : void
      {
         hasField$0 |= 1;
         teamCount$field = param1;
      }
      
      public function get teamCount() : int
      {
         return teamCount$field;
      }
      
      public function removeTeamScore() : void
      {
         hasField$0 &= 4294967293;
         teamScore$field = new int();
      }
      
      public function get hasTeamScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set teamScore(param1:int) : void
      {
         hasField$0 |= 2;
         teamScore$field = param1;
      }
      
      public function get teamScore() : int
      {
         return teamScore$field;
      }
      
      public function removeDefendCount() : void
      {
         hasField$0 &= 4294967291;
         defendCount$field = new int();
      }
      
      public function get hasDefendCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defendCount(param1:int) : void
      {
         hasField$0 |= 4;
         defendCount$field = param1;
      }
      
      public function get defendCount() : int
      {
         return defendCount$field;
      }
      
      public function removeBlessCount() : void
      {
         hasField$0 &= 4294967287;
         blessCount$field = new int();
      }
      
      public function get hasBlessCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set blessCount(param1:int) : void
      {
         hasField$0 |= 8;
         blessCount$field = param1;
      }
      
      public function get blessCount() : int
      {
         return blessCount$field;
      }
      
      public function removeTowerHp() : void
      {
         hasField$0 &= 4294967279;
         towerHp$field = new int();
      }
      
      public function get hasTowerHp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set towerHp(param1:int) : void
      {
         hasField$0 |= 16;
         towerHp$field = param1;
      }
      
      public function get towerHp() : int
      {
         return towerHp$field;
      }
      
      public function removeTowerMaxHp() : void
      {
         hasField$0 &= 4294967263;
         towerMaxHp$field = new int();
      }
      
      public function get hasTowerMaxHp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set towerMaxHp(param1:int) : void
      {
         hasField$0 |= 32;
         towerMaxHp$field = param1;
      }
      
      public function get towerMaxHp() : int
      {
         return towerMaxHp$field;
      }
      
      public function removeLeftNpcCount() : void
      {
         hasField$0 &= 4294967231;
         leftNpcCount$field = new int();
      }
      
      public function get hasLeftNpcCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set leftNpcCount(param1:int) : void
      {
         hasField$0 |= 64;
         leftNpcCount$field = param1;
      }
      
      public function get leftNpcCount() : int
      {
         return leftNpcCount$field;
      }
      
      public function removeCreateNpcCd() : void
      {
         hasField$0 &= 4294967167;
         createNpcCd$field = new int();
      }
      
      public function get hasCreateNpcCd() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set createNpcCd(param1:int) : void
      {
         hasField$0 |= 128;
         createNpcCd$field = param1;
      }
      
      public function get createNpcCd() : int
      {
         return createNpcCd$field;
      }
      
      public function removeAssaultCount() : void
      {
         hasField$0 &= 4294967039;
         assaultCount$field = new int();
      }
      
      public function get hasAssaultCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set assaultCount(param1:int) : void
      {
         hasField$0 |= 256;
         assaultCount$field = param1;
      }
      
      public function get assaultCount() : int
      {
         return assaultCount$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortiaName$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortiaName$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortiaName$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortiaName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeamCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,teamCount$field);
         }
         if(hasTeamScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,teamScore$field);
         }
         if(hasDefendCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,defendCount$field);
         }
         if(hasBlessCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,blessCount$field);
         }
         if(hasTowerHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,towerHp$field);
         }
         if(hasTowerMaxHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,towerMaxHp$field);
         }
         if(hasLeftNpcCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,leftNpcCount$field);
         }
         if(hasCreateNpcCd)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,createNpcCd$field);
         }
         if(hasAssaultCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,assaultCount$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.teamCount cannot be set twice.");
                  }
                  _loc4_++;
                  teamCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.teamScore cannot be set twice.");
                  }
                  _loc13_++;
                  teamScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.defendCount cannot be set twice.");
                  }
                  _loc6_++;
                  defendCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.blessCount cannot be set twice.");
                  }
                  _loc5_++;
                  blessCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.towerHp cannot be set twice.");
                  }
                  _loc7_++;
                  towerHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.towerMaxHp cannot be set twice.");
                  }
                  _loc10_++;
                  towerMaxHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.leftNpcCount cannot be set twice.");
                  }
                  _loc8_++;
                  leftNpcCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.createNpcCd cannot be set twice.");
                  }
                  _loc12_++;
                  createNpcCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.assaultCount cannot be set twice.");
                  }
                  _loc9_++;
                  assaultCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightTeamInfoMsg.consortiaName cannot be set twice.");
                  }
                  _loc3_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

