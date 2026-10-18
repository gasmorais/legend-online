package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarTowerDetailMsg extends Message implements IExternalizable
   {
      
      private var teamId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var towerId$field:int;
      
      private var name$field:String;
      
      private var fightPower$field:int;
      
      private var blood$field:int;
      
      private var troubleCount$field:int;
      
      [ArrayElementType("int")]
      public var sealList:Array = [];
      
      private var userBufferId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.consortiawar.ConsortiaWarDefendRecordMsg")]
      public var recordList:Array = [];
      
      public function ConsortiaWarTowerDetailMsg()
      {
         super();
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967294;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 1;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeTowerId() : void
      {
         hasField$0 &= 4294967293;
         towerId$field = new int();
      }
      
      public function get hasTowerId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set towerId(param1:int) : void
      {
         hasField$0 |= 2;
         towerId$field = param1;
      }
      
      public function get towerId() : int
      {
         return towerId$field;
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
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967291;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 4;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeBlood() : void
      {
         hasField$0 &= 4294967287;
         blood$field = new int();
      }
      
      public function get hasBlood() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set blood(param1:int) : void
      {
         hasField$0 |= 8;
         blood$field = param1;
      }
      
      public function get blood() : int
      {
         return blood$field;
      }
      
      public function removeTroubleCount() : void
      {
         hasField$0 &= 4294967279;
         troubleCount$field = new int();
      }
      
      public function get hasTroubleCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set troubleCount(param1:int) : void
      {
         hasField$0 |= 16;
         troubleCount$field = param1;
      }
      
      public function get troubleCount() : int
      {
         return troubleCount$field;
      }
      
      public function removeUserBufferId() : void
      {
         hasField$0 &= 4294967263;
         userBufferId$field = new int();
      }
      
      public function get hasUserBufferId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set userBufferId(param1:int) : void
      {
         hasField$0 |= 32;
         userBufferId$field = param1;
      }
      
      public function get userBufferId() : int
      {
         return userBufferId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasTowerId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,towerId$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasBlood)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,blood$field);
         }
         if(hasTroubleCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,troubleCount$field);
         }
         _loc3_ = 0;
         while(_loc3_ < sealList.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,sealList[_loc3_]);
            _loc3_++;
         }
         if(hasUserBufferId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,userBufferId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < recordList.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,recordList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:ConsortiaWarDefendRecordMsg = null;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTowerDetailMsg.teamId cannot be set twice.");
                  }
                  _loc7_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTowerDetailMsg.towerId cannot be set twice.");
                  }
                  _loc9_++;
                  towerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTowerDetailMsg.name cannot be set twice.");
                  }
                  _loc4_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTowerDetailMsg.fightPower cannot be set twice.");
                  }
                  _loc5_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTowerDetailMsg.blood cannot be set twice.");
                  }
                  _loc10_++;
                  blood = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTowerDetailMsg.troubleCount cannot be set twice.");
                  }
                  _loc11_++;
                  troubleCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,sealList);
                  }
                  else
                  {
                     sealList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarTowerDetailMsg.userBufferId cannot be set twice.");
                  }
                  _loc3_++;
                  userBufferId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc6_ = new ConsortiaWarDefendRecordMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  recordList.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

