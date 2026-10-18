package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArmyMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var name$field:String;
      
      private var type$field:int;
      
      private var side$field:int;
      
      private var formation$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var hero:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.SoldierMsg")]
      public var soldier:Array = [];
      
      private var result$field:int;
      
      private var is_join$field:Boolean;
      
      private var army_type$field:int;
      
      private var is_robot$field:Boolean;
      
      private var failed_count$field:int;
      
      private var server_name$field:String;
      
      private var army_player_info$field:ArmyPlayerInfoMsg;
      
      private var curWave$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var pet:Array = [];
      
      private var fightPower$field:int;
      
      private var uid$field:String;
      
      private var leftCount$field:int;
      
      private var multiLordsInspireLevel$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var childs:Array = [];
      
      private var nickName$field:String;
      
      private var vehicleTemplateId$field:int;
      
      private var isReject$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var childPets:Array = [];
      
      private var scuffleScore$field:int;
      
      private var player_uuid$field:String;
      
      private var mateScoreRateItems$field:String;
      
      private var pvpLordsScore$field:int;
      
      private var pvpTeamType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var goddesses:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var monsters:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var chessList:Array = [];
      
      public function ArmyMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967287;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 8;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removeFormation() : void
      {
         hasField$0 &= 4294967279;
         formation$field = new int();
      }
      
      public function get hasFormation() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set formation(param1:int) : void
      {
         hasField$0 |= 16;
         formation$field = param1;
      }
      
      public function get formation() : int
      {
         return formation$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967263;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 32;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeIsJoin() : void
      {
         hasField$0 &= 4294967231;
         is_join$field = new Boolean();
      }
      
      public function get hasIsJoin() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isJoin(param1:Boolean) : void
      {
         hasField$0 |= 64;
         is_join$field = param1;
      }
      
      public function get isJoin() : Boolean
      {
         return is_join$field;
      }
      
      public function removeArmyType() : void
      {
         hasField$0 &= 4294967167;
         army_type$field = new int();
      }
      
      public function get hasArmyType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set armyType(param1:int) : void
      {
         hasField$0 |= 128;
         army_type$field = param1;
      }
      
      public function get armyType() : int
      {
         return army_type$field;
      }
      
      public function removeIsRobot() : void
      {
         hasField$0 &= 4294967039;
         is_robot$field = new Boolean();
      }
      
      public function get hasIsRobot() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isRobot(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_robot$field = param1;
      }
      
      public function get isRobot() : Boolean
      {
         return is_robot$field;
      }
      
      public function removeFailedCount() : void
      {
         hasField$0 &= 4294966783;
         failed_count$field = new int();
      }
      
      public function get hasFailedCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set failedCount(param1:int) : void
      {
         hasField$0 |= 512;
         failed_count$field = param1;
      }
      
      public function get failedCount() : int
      {
         return failed_count$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeArmyPlayerInfo() : void
      {
         army_player_info$field = null;
      }
      
      public function get hasArmyPlayerInfo() : Boolean
      {
         return army_player_info$field != null;
      }
      
      public function set armyPlayerInfo(param1:ArmyPlayerInfoMsg) : void
      {
         army_player_info$field = param1;
      }
      
      public function get armyPlayerInfo() : ArmyPlayerInfoMsg
      {
         return army_player_info$field;
      }
      
      public function removeCurWave() : void
      {
         hasField$0 &= 4294966271;
         curWave$field = new int();
      }
      
      public function get hasCurWave() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set curWave(param1:int) : void
      {
         hasField$0 |= 1024;
         curWave$field = param1;
      }
      
      public function get curWave() : int
      {
         return curWave$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294965247;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 2048;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeUid() : void
      {
         uid$field = null;
      }
      
      public function get hasUid() : Boolean
      {
         return uid$field != null;
      }
      
      public function set uid(param1:String) : void
      {
         uid$field = param1;
      }
      
      public function get uid() : String
      {
         return uid$field;
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294963199;
         leftCount$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 4096;
         leftCount$field = param1;
      }
      
      public function get leftCount() : int
      {
         return leftCount$field;
      }
      
      public function removeMultiLordsInspireLevel() : void
      {
         hasField$0 &= 4294959103;
         multiLordsInspireLevel$field = new int();
      }
      
      public function get hasMultiLordsInspireLevel() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set multiLordsInspireLevel(param1:int) : void
      {
         hasField$0 |= 8192;
         multiLordsInspireLevel$field = param1;
      }
      
      public function get multiLordsInspireLevel() : int
      {
         return multiLordsInspireLevel$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeVehicleTemplateId() : void
      {
         hasField$0 &= 4294950911;
         vehicleTemplateId$field = new int();
      }
      
      public function get hasVehicleTemplateId() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set vehicleTemplateId(param1:int) : void
      {
         hasField$0 |= 16384;
         vehicleTemplateId$field = param1;
      }
      
      public function get vehicleTemplateId() : int
      {
         return vehicleTemplateId$field;
      }
      
      public function removeIsReject() : void
      {
         hasField$0 &= 4294934527;
         isReject$field = new Boolean();
      }
      
      public function get hasIsReject() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set isReject(param1:Boolean) : void
      {
         hasField$0 |= 32768;
         isReject$field = param1;
      }
      
      public function get isReject() : Boolean
      {
         return isReject$field;
      }
      
      public function removeScuffleScore() : void
      {
         hasField$0 &= 4294901759;
         scuffleScore$field = new int();
      }
      
      public function get hasScuffleScore() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set scuffleScore(param1:int) : void
      {
         hasField$0 |= 65536;
         scuffleScore$field = param1;
      }
      
      public function get scuffleScore() : int
      {
         return scuffleScore$field;
      }
      
      public function removePlayerUuid() : void
      {
         player_uuid$field = null;
      }
      
      public function get hasPlayerUuid() : Boolean
      {
         return player_uuid$field != null;
      }
      
      public function set playerUuid(param1:String) : void
      {
         player_uuid$field = param1;
      }
      
      public function get playerUuid() : String
      {
         return player_uuid$field;
      }
      
      public function removeMateScoreRateItems() : void
      {
         mateScoreRateItems$field = null;
      }
      
      public function get hasMateScoreRateItems() : Boolean
      {
         return mateScoreRateItems$field != null;
      }
      
      public function set mateScoreRateItems(param1:String) : void
      {
         mateScoreRateItems$field = param1;
      }
      
      public function get mateScoreRateItems() : String
      {
         return mateScoreRateItems$field;
      }
      
      public function removePvpLordsScore() : void
      {
         hasField$0 &= 4294836223;
         pvpLordsScore$field = new int();
      }
      
      public function get hasPvpLordsScore() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set pvpLordsScore(param1:int) : void
      {
         hasField$0 |= 131072;
         pvpLordsScore$field = param1;
      }
      
      public function get pvpLordsScore() : int
      {
         return pvpLordsScore$field;
      }
      
      public function removePvpTeamType() : void
      {
         hasField$0 &= 4294705151;
         pvpTeamType$field = new int();
      }
      
      public function get hasPvpTeamType() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set pvpTeamType(param1:int) : void
      {
         hasField$0 |= 262144;
         pvpTeamType$field = param1;
      }
      
      public function get pvpTeamType() : int
      {
         return pvpTeamType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc9_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc8_:* = 0;
         var _loc7_:* = 0;
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasFormation)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,formation$field);
         }
         _loc4_ = 0;
         while(_loc4_ < hero.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,hero[_loc4_]);
            _loc4_++;
         }
         _loc9_ = 0;
         while(_loc9_ < soldier.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,soldier[_loc9_]);
            _loc9_++;
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasIsJoin)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,is_join$field);
         }
         if(hasArmyType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,army_type$field);
         }
         if(hasIsRobot)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,is_robot$field);
         }
         if(hasFailedCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,failed_count$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasArmyPlayerInfo)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,army_player_info$field);
         }
         if(hasCurWave)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,curWave$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pet.length)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_MESSAGE(param1,pet[_loc2_]);
            _loc2_++;
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,leftCount$field);
         }
         if(hasMultiLordsInspireLevel)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,multiLordsInspireLevel$field);
         }
         _loc5_ = 0;
         while(_loc5_ < childs.length)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_MESSAGE(param1,childs[_loc5_]);
            _loc5_++;
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasVehicleTemplateId)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,vehicleTemplateId$field);
         }
         if(hasIsReject)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_BOOL(param1,isReject$field);
         }
         _loc8_ = 0;
         while(_loc8_ < childPets.length)
         {
            WriteUtils.writeTag(param1,2,26);
            WriteUtils.write$TYPE_MESSAGE(param1,childPets[_loc8_]);
            _loc8_++;
         }
         if(hasScuffleScore)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,scuffleScore$field);
         }
         if(hasPlayerUuid)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_STRING(param1,player_uuid$field);
         }
         if(hasMateScoreRateItems)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_STRING(param1,mateScoreRateItems$field);
         }
         if(hasPvpLordsScore)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,pvpLordsScore$field);
         }
         if(hasPvpTeamType)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,pvpTeamType$field);
         }
         _loc7_ = 0;
         while(_loc7_ < goddesses.length)
         {
            WriteUtils.writeTag(param1,2,32);
            WriteUtils.write$TYPE_MESSAGE(param1,goddesses[_loc7_]);
            _loc7_++;
         }
         _loc3_ = 0;
         while(_loc3_ < monsters.length)
         {
            WriteUtils.writeTag(param1,2,33);
            WriteUtils.write$TYPE_MESSAGE(param1,monsters[_loc3_]);
            _loc3_++;
         }
         _loc6_ = 0;
         while(_loc6_ < chessList.length)
         {
            WriteUtils.writeTag(param1,2,34);
            WriteUtils.write$TYPE_MESSAGE(param1,chessList[_loc6_]);
            _loc6_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc22_:* = 0;
         var _loc3_:HeroMsg = null;
         var _loc31_:SoldierMsg = null;
         var _loc24_:HeroMsg = null;
         var _loc35_:HeroMsg = null;
         var _loc6_:HeroMsg = null;
         var _loc10_:HeroMsg = null;
         var _loc15_:HeroMsg = null;
         var _loc14_:HeroMsg = null;
         var _loc27_:uint = 0;
         var _loc20_:uint = 0;
         var _loc32_:uint = 0;
         var _loc29_:uint = 0;
         var _loc34_:uint = 0;
         var _loc25_:uint = 0;
         var _loc7_:uint = 0;
         var _loc18_:uint = 0;
         var _loc16_:uint = 0;
         var _loc30_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc19_:uint = 0;
         var _loc5_:uint = 0;
         var _loc26_:uint = 0;
         var _loc23_:uint = 0;
         var _loc21_:uint = 0;
         var _loc28_:uint = 0;
         var _loc17_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc33_:uint = 0;
         var _loc4_:uint = 0;
         var _loc36_:uint = 0;
         var _loc37_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc22_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.id cannot be set twice.");
                  }
                  _loc27_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.userId cannot be set twice.");
                  }
                  _loc20_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.name cannot be set twice.");
                  }
                  _loc32_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.type cannot be set twice.");
                  }
                  _loc29_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.side cannot be set twice.");
                  }
                  _loc34_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.formation cannot be set twice.");
                  }
                  _loc25_++;
                  formation = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc3_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  hero.push(_loc3_);
                  break;
               case 8:
                  _loc31_ = new SoldierMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc31_);
                  soldier.push(_loc31_);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.result cannot be set twice.");
                  }
                  _loc7_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.isJoin cannot be set twice.");
                  }
                  _loc18_++;
                  isJoin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.armyType cannot be set twice.");
                  }
                  _loc16_++;
                  armyType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.isRobot cannot be set twice.");
                  }
                  _loc30_++;
                  isRobot = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.failedCount cannot be set twice.");
                  }
                  _loc13_++;
                  failedCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.armyPlayerInfo cannot be set twice.");
                  }
                  _loc19_++;
                  armyPlayerInfo = new ArmyPlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,armyPlayerInfo);
                  break;
               case 16:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.curWave cannot be set twice.");
                  }
                  _loc5_++;
                  curWave = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  _loc24_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc24_);
                  pet.push(_loc24_);
                  break;
               case 18:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.fightPower cannot be set twice.");
                  }
                  _loc26_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.uid cannot be set twice.");
                  }
                  _loc23_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.leftCount cannot be set twice.");
                  }
                  _loc21_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.multiLordsInspireLevel cannot be set twice.");
                  }
                  _loc28_++;
                  multiLordsInspireLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  _loc35_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc35_);
                  childs.push(_loc35_);
                  break;
               case 23:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.nickName cannot be set twice.");
                  }
                  _loc17_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 24:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.vehicleTemplateId cannot be set twice.");
                  }
                  _loc11_++;
                  vehicleTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.isReject cannot be set twice.");
                  }
                  _loc12_++;
                  isReject = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 26:
                  _loc6_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  childPets.push(_loc6_);
                  break;
               case 27:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.scuffleScore cannot be set twice.");
                  }
                  _loc8_++;
                  scuffleScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.playerUuid cannot be set twice.");
                  }
                  _loc33_++;
                  playerUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 29:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.mateScoreRateItems cannot be set twice.");
                  }
                  _loc4_++;
                  mateScoreRateItems = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 30:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.pvpLordsScore cannot be set twice.");
                  }
                  _loc36_++;
                  pvpLordsScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyMsg.pvpTeamType cannot be set twice.");
                  }
                  _loc37_++;
                  pvpTeamType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  _loc10_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  goddesses.push(_loc10_);
                  break;
               case 33:
                  _loc15_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc15_);
                  monsters.push(_loc15_);
                  break;
               case 34:
                  _loc14_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  chessList.push(_loc14_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc22_ & 7);
            }
         }
      }
   }
}

