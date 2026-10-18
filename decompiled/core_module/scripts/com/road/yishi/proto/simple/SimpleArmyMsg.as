package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimpleArmyMsg extends Message implements IExternalizable
   {
      
      private var army_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var player_id$field:int;
      
      private var nick_name$field:String;
      
      private var map_id$field:int;
      
      private var start_pos_x$field:int;
      
      private var start_pos_y$field:int;
      
      private var cur_pos_x$field:int;
      
      private var cur_pos_y$field:int;
      
      private var end_pos_x$field:int;
      
      private var end_pos_y$field:int;
      
      private var state$field:int;
      
      private var velocity$field:int;
      
      private var cost_time$field:int;
      
      private var departure$field:String;
      
      private var destination$field:String;
      
      private var command$field:int;
      
      [ArrayElementType("String")]
      public var routeKey:Array = [];
      
      private var type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.simple.SimpleArmyPawnMsg")]
      public var armyPawn:Array = [];
      
      private var consortia_id$field:int;
      
      private var consortia_name$field:String;
      
      private var simple_hero$field:SimpleHeroMsg;
      
      private var temp_time$field:int;
      
      private var is_vip$field:Boolean;
      
      private var vip_type$field:int;
      
      private var store_grade$field:int;
      
      private var appellid$field:int;
      
      private var fateTotalGp$field:int;
      
      private var fateGrades$field:String;
      
      private var dragon_grade$field:String;
      
      private var transfer_grade$field:int;
      
      private var senior_store_grade$field:int;
      
      private var changeBranch$field:int;
      
      private var equipment_refining_grade$field:int;
      
      public function SimpleArmyMsg()
      {
         super();
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967294;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 1;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967293;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 2;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967291;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 4;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removeStartPosX() : void
      {
         hasField$0 &= 4294967287;
         start_pos_x$field = new int();
      }
      
      public function get hasStartPosX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set startPosX(param1:int) : void
      {
         hasField$0 |= 8;
         start_pos_x$field = param1;
      }
      
      public function get startPosX() : int
      {
         return start_pos_x$field;
      }
      
      public function removeStartPosY() : void
      {
         hasField$0 &= 4294967279;
         start_pos_y$field = new int();
      }
      
      public function get hasStartPosY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set startPosY(param1:int) : void
      {
         hasField$0 |= 16;
         start_pos_y$field = param1;
      }
      
      public function get startPosY() : int
      {
         return start_pos_y$field;
      }
      
      public function removeCurPosX() : void
      {
         hasField$0 &= 4294967263;
         cur_pos_x$field = new int();
      }
      
      public function get hasCurPosX() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set curPosX(param1:int) : void
      {
         hasField$0 |= 32;
         cur_pos_x$field = param1;
      }
      
      public function get curPosX() : int
      {
         return cur_pos_x$field;
      }
      
      public function removeCurPosY() : void
      {
         hasField$0 &= 4294967231;
         cur_pos_y$field = new int();
      }
      
      public function get hasCurPosY() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set curPosY(param1:int) : void
      {
         hasField$0 |= 64;
         cur_pos_y$field = param1;
      }
      
      public function get curPosY() : int
      {
         return cur_pos_y$field;
      }
      
      public function removeEndPosX() : void
      {
         hasField$0 &= 4294967167;
         end_pos_x$field = new int();
      }
      
      public function get hasEndPosX() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set endPosX(param1:int) : void
      {
         hasField$0 |= 128;
         end_pos_x$field = param1;
      }
      
      public function get endPosX() : int
      {
         return end_pos_x$field;
      }
      
      public function removeEndPosY() : void
      {
         hasField$0 &= 4294967039;
         end_pos_y$field = new int();
      }
      
      public function get hasEndPosY() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set endPosY(param1:int) : void
      {
         hasField$0 |= 256;
         end_pos_y$field = param1;
      }
      
      public function get endPosY() : int
      {
         return end_pos_y$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294966783;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 512;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeVelocity() : void
      {
         hasField$0 &= 4294966271;
         velocity$field = new int();
      }
      
      public function get hasVelocity() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set velocity(param1:int) : void
      {
         hasField$0 |= 1024;
         velocity$field = param1;
      }
      
      public function get velocity() : int
      {
         return velocity$field;
      }
      
      public function removeCostTime() : void
      {
         hasField$0 &= 4294965247;
         cost_time$field = new int();
      }
      
      public function get hasCostTime() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set costTime(param1:int) : void
      {
         hasField$0 |= 2048;
         cost_time$field = param1;
      }
      
      public function get costTime() : int
      {
         return cost_time$field;
      }
      
      public function removeDeparture() : void
      {
         departure$field = null;
      }
      
      public function get hasDeparture() : Boolean
      {
         return departure$field != null;
      }
      
      public function set departure(param1:String) : void
      {
         departure$field = param1;
      }
      
      public function get departure() : String
      {
         return departure$field;
      }
      
      public function removeDestination() : void
      {
         destination$field = null;
      }
      
      public function get hasDestination() : Boolean
      {
         return destination$field != null;
      }
      
      public function set destination(param1:String) : void
      {
         destination$field = param1;
      }
      
      public function get destination() : String
      {
         return destination$field;
      }
      
      public function removeCommand() : void
      {
         hasField$0 &= 4294963199;
         command$field = new int();
      }
      
      public function get hasCommand() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set command(param1:int) : void
      {
         hasField$0 |= 4096;
         command$field = param1;
      }
      
      public function get command() : int
      {
         return command$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294959103;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8192;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294950911;
         consortia_id$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 16384;
         consortia_id$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortia_id$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeSimpleHero() : void
      {
         simple_hero$field = null;
      }
      
      public function get hasSimpleHero() : Boolean
      {
         return simple_hero$field != null;
      }
      
      public function set simpleHero(param1:SimpleHeroMsg) : void
      {
         simple_hero$field = param1;
      }
      
      public function get simpleHero() : SimpleHeroMsg
      {
         return simple_hero$field;
      }
      
      public function removeTempTime() : void
      {
         hasField$0 &= 4294934527;
         temp_time$field = new int();
      }
      
      public function get hasTempTime() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set tempTime(param1:int) : void
      {
         hasField$0 |= 32768;
         temp_time$field = param1;
      }
      
      public function get tempTime() : int
      {
         return temp_time$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294901759;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 65536;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294836223;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 131072;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      public function removeStoreGrade() : void
      {
         hasField$0 &= 4294705151;
         store_grade$field = new int();
      }
      
      public function get hasStoreGrade() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set storeGrade(param1:int) : void
      {
         hasField$0 |= 262144;
         store_grade$field = param1;
      }
      
      public function get storeGrade() : int
      {
         return store_grade$field;
      }
      
      public function removeAppellid() : void
      {
         hasField$0 &= 4294443007;
         appellid$field = new int();
      }
      
      public function get hasAppellid() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set appellid(param1:int) : void
      {
         hasField$0 |= 524288;
         appellid$field = param1;
      }
      
      public function get appellid() : int
      {
         return appellid$field;
      }
      
      public function removeFateTotalGp() : void
      {
         hasField$0 &= 4293918719;
         fateTotalGp$field = new int();
      }
      
      public function get hasFateTotalGp() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set fateTotalGp(param1:int) : void
      {
         hasField$0 |= 1048576;
         fateTotalGp$field = param1;
      }
      
      public function get fateTotalGp() : int
      {
         return fateTotalGp$field;
      }
      
      public function removeFateGrades() : void
      {
         fateGrades$field = null;
      }
      
      public function get hasFateGrades() : Boolean
      {
         return fateGrades$field != null;
      }
      
      public function set fateGrades(param1:String) : void
      {
         fateGrades$field = param1;
      }
      
      public function get fateGrades() : String
      {
         return fateGrades$field;
      }
      
      public function removeDragonGrade() : void
      {
         dragon_grade$field = null;
      }
      
      public function get hasDragonGrade() : Boolean
      {
         return dragon_grade$field != null;
      }
      
      public function set dragonGrade(param1:String) : void
      {
         dragon_grade$field = param1;
      }
      
      public function get dragonGrade() : String
      {
         return dragon_grade$field;
      }
      
      public function removeTransferGrade() : void
      {
         hasField$0 &= 4292870143;
         transfer_grade$field = new int();
      }
      
      public function get hasTransferGrade() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set transferGrade(param1:int) : void
      {
         hasField$0 |= 2097152;
         transfer_grade$field = param1;
      }
      
      public function get transferGrade() : int
      {
         return transfer_grade$field;
      }
      
      public function removeSeniorStoreGrade() : void
      {
         hasField$0 &= 4290772991;
         senior_store_grade$field = new int();
      }
      
      public function get hasSeniorStoreGrade() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set seniorStoreGrade(param1:int) : void
      {
         hasField$0 |= 4194304;
         senior_store_grade$field = param1;
      }
      
      public function get seniorStoreGrade() : int
      {
         return senior_store_grade$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$0 &= 4286578687;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$0 |= 8388608;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
      }
      
      public function removeEquipmentRefiningGrade() : void
      {
         hasField$0 &= 4278190079;
         equipment_refining_grade$field = new int();
      }
      
      public function get hasEquipmentRefiningGrade() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set equipmentRefiningGrade(param1:int) : void
      {
         hasField$0 |= 16777216;
         equipment_refining_grade$field = param1;
      }
      
      public function get equipmentRefiningGrade() : int
      {
         return equipment_refining_grade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasStartPosX)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,start_pos_x$field);
         }
         if(hasStartPosY)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,start_pos_y$field);
         }
         if(hasCurPosX)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_x$field);
         }
         if(hasCurPosY)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,cur_pos_y$field);
         }
         if(hasEndPosX)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,end_pos_x$field);
         }
         if(hasEndPosY)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,end_pos_y$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasVelocity)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,velocity$field);
         }
         if(hasCostTime)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,cost_time$field);
         }
         if(hasDeparture)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,departure$field);
         }
         if(hasDestination)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,destination$field);
         }
         if(hasCommand)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,command$field);
         }
         _loc2_ = 0;
         while(_loc2_ < routeKey.length)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,routeKey[_loc2_]);
            _loc2_++;
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         _loc3_ = 0;
         while(_loc3_ < armyPawn.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,armyPawn[_loc3_]);
            _loc3_++;
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,consortia_id$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasSimpleHero)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_MESSAGE(param1,simple_hero$field);
         }
         if(hasTempTime)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,temp_time$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
         if(hasStoreGrade)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,store_grade$field);
         }
         if(hasAppellid)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,appellid$field);
         }
         if(hasFateTotalGp)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,fateTotalGp$field);
         }
         if(hasFateGrades)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_STRING(param1,fateGrades$field);
         }
         if(hasDragonGrade)
         {
            WriteUtils.writeTag(param1,2,30);
            WriteUtils.write$TYPE_STRING(param1,dragon_grade$field);
         }
         if(hasTransferGrade)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,transfer_grade$field);
         }
         if(hasSeniorStoreGrade)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_INT32(param1,senior_store_grade$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
         if(hasEquipmentRefiningGrade)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,equipment_refining_grade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc26_:SimpleArmyPawnMsg = null;
         var _loc32_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc35_:uint = 0;
         var _loc14_:uint = 0;
         var _loc27_:uint = 0;
         var _loc9_:uint = 0;
         var _loc22_:uint = 0;
         var _loc34_:uint = 0;
         var _loc3_:uint = 0;
         var _loc19_:uint = 0;
         var _loc33_:uint = 0;
         var _loc11_:uint = 0;
         var _loc30_:uint = 0;
         var _loc10_:uint = 0;
         var _loc36_:uint = 0;
         var _loc28_:uint = 0;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc31_:uint = 0;
         var _loc23_:uint = 0;
         var _loc20_:uint = 0;
         var _loc17_:uint = 0;
         var _loc24_:uint = 0;
         var _loc18_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc25_:uint = 0;
         var _loc29_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.armyId cannot be set twice.");
                  }
                  _loc32_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.playerId cannot be set twice.");
                  }
                  _loc5_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.mapId cannot be set twice.");
                  }
                  _loc35_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.startPosX cannot be set twice.");
                  }
                  _loc14_++;
                  startPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.startPosY cannot be set twice.");
                  }
                  _loc27_++;
                  startPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.curPosX cannot be set twice.");
                  }
                  _loc9_++;
                  curPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.curPosY cannot be set twice.");
                  }
                  _loc22_++;
                  curPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.endPosX cannot be set twice.");
                  }
                  _loc34_++;
                  endPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.endPosY cannot be set twice.");
                  }
                  _loc3_++;
                  endPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.state cannot be set twice.");
                  }
                  _loc19_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.velocity cannot be set twice.");
                  }
                  _loc33_++;
                  velocity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.costTime cannot be set twice.");
                  }
                  _loc11_++;
                  costTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.departure cannot be set twice.");
                  }
                  _loc30_++;
                  departure = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.destination cannot be set twice.");
                  }
                  _loc10_++;
                  destination = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.command cannot be set twice.");
                  }
                  _loc36_++;
                  command = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  routeKey.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 18:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.type cannot be set twice.");
                  }
                  _loc28_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  _loc26_ = new SimpleArmyPawnMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc26_);
                  armyPawn.push(_loc26_);
                  break;
               case 20:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.consortiaId cannot be set twice.");
                  }
                  _loc15_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.consortiaName cannot be set twice.");
                  }
                  _loc8_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.simpleHero cannot be set twice.");
                  }
                  _loc7_++;
                  simpleHero = new SimpleHeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,simpleHero);
                  break;
               case 23:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.tempTime cannot be set twice.");
                  }
                  _loc31_++;
                  tempTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.isVip cannot be set twice.");
                  }
                  _loc23_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 25:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.vipType cannot be set twice.");
                  }
                  _loc20_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.storeGrade cannot be set twice.");
                  }
                  _loc17_++;
                  storeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.appellid cannot be set twice.");
                  }
                  _loc24_++;
                  appellid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.fateTotalGp cannot be set twice.");
                  }
                  _loc18_++;
                  fateTotalGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.fateGrades cannot be set twice.");
                  }
                  _loc6_++;
                  fateGrades = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 30:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.dragonGrade cannot be set twice.");
                  }
                  _loc13_++;
                  dragonGrade = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 31:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.transferGrade cannot be set twice.");
                  }
                  _loc16_++;
                  transferGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.seniorStoreGrade cannot be set twice.");
                  }
                  _loc12_++;
                  seniorStoreGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 33:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.changeBranch cannot be set twice.");
                  }
                  _loc25_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 34:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: SimpleArmyMsg.equipmentRefiningGrade cannot be set twice.");
                  }
                  _loc29_++;
                  equipmentRefiningGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

