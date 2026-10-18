package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattlePrepareMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:String;
      
      private var battle_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var map_temp_id$field:int;
      
      private var need_animation$field:Boolean;
      
      private var side$field:int;
      
      private var has_assault$field:Boolean;
      
      private var use_way$field:int;
      
      private var attack_model$field:int;
      
      private var reinforceCount$field:int;
      
      private var currentReinforce$field:int;
      
      private var battle_capity$field:int;
      
      private var count_down$field:int;
      
      private var damage_improve$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.SoldierMsg")]
      public var soldiers:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var heros:Array = [];
      
      [ArrayElementType("int")]
      public var soldierTemplated:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.CoolDownMsg")]
      public var coolDown:Array = [];
      
      private var currentWave$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var pets:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var children:Array = [];
      
      [ArrayElementType("int")]
      public var heroTempId:Array = [];
      
      [ArrayElementType("Int64")]
      public var life:Array = [];
      
      private var battle_from$field:int;
      
      private var view_side$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var goddesses:Array = [];
      
      private var page$field:int;
      
      private var total_page$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var monsters:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.battle.HeroMsg")]
      public var chessList:Array = [];
      
      public function BattlePrepareMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         battle_id$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battle_id$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battle_id$field = param1;
      }
      
      public function get battleId() : String
      {
         return battle_id$field;
      }
      
      public function removeBattleType() : void
      {
         hasField$0 &= 4294967294;
         battle_type$field = new int();
      }
      
      public function get hasBattleType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set battleType(param1:int) : void
      {
         hasField$0 |= 1;
         battle_type$field = param1;
      }
      
      public function get battleType() : int
      {
         return battle_type$field;
      }
      
      public function removeMapTempId() : void
      {
         hasField$0 &= 4294967293;
         map_temp_id$field = new int();
      }
      
      public function get hasMapTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mapTempId(param1:int) : void
      {
         hasField$0 |= 2;
         map_temp_id$field = param1;
      }
      
      public function get mapTempId() : int
      {
         return map_temp_id$field;
      }
      
      public function removeNeedAnimation() : void
      {
         hasField$0 &= 4294967291;
         need_animation$field = new Boolean();
      }
      
      public function get hasNeedAnimation() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set needAnimation(param1:Boolean) : void
      {
         hasField$0 |= 4;
         need_animation$field = param1;
      }
      
      public function get needAnimation() : Boolean
      {
         return need_animation$field;
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
      
      public function removeHasAssault() : void
      {
         hasField$0 &= 4294967279;
         has_assault$field = new Boolean();
      }
      
      public function get hasHasAssault() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set hasAssault(param1:Boolean) : void
      {
         hasField$0 |= 16;
         has_assault$field = param1;
      }
      
      public function get hasAssault() : Boolean
      {
         return has_assault$field;
      }
      
      public function removeUseWay() : void
      {
         hasField$0 &= 4294967263;
         use_way$field = new int();
      }
      
      public function get hasUseWay() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set useWay(param1:int) : void
      {
         hasField$0 |= 32;
         use_way$field = param1;
      }
      
      public function get useWay() : int
      {
         return use_way$field;
      }
      
      public function removeAttackModel() : void
      {
         hasField$0 &= 4294967231;
         attack_model$field = new int();
      }
      
      public function get hasAttackModel() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set attackModel(param1:int) : void
      {
         hasField$0 |= 64;
         attack_model$field = param1;
      }
      
      public function get attackModel() : int
      {
         return attack_model$field;
      }
      
      public function removeReinforceCount() : void
      {
         hasField$0 &= 4294967167;
         reinforceCount$field = new int();
      }
      
      public function get hasReinforceCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set reinforceCount(param1:int) : void
      {
         hasField$0 |= 128;
         reinforceCount$field = param1;
      }
      
      public function get reinforceCount() : int
      {
         return reinforceCount$field;
      }
      
      public function removeCurrentReinforce() : void
      {
         hasField$0 &= 4294967039;
         currentReinforce$field = new int();
      }
      
      public function get hasCurrentReinforce() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set currentReinforce(param1:int) : void
      {
         hasField$0 |= 256;
         currentReinforce$field = param1;
      }
      
      public function get currentReinforce() : int
      {
         return currentReinforce$field;
      }
      
      public function removeBattleCapity() : void
      {
         hasField$0 &= 4294966783;
         battle_capity$field = new int();
      }
      
      public function get hasBattleCapity() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set battleCapity(param1:int) : void
      {
         hasField$0 |= 512;
         battle_capity$field = param1;
      }
      
      public function get battleCapity() : int
      {
         return battle_capity$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294966271;
         count_down$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 1024;
         count_down$field = param1;
      }
      
      public function get countDown() : int
      {
         return count_down$field;
      }
      
      public function removeDamageImprove() : void
      {
         hasField$0 &= 4294965247;
         damage_improve$field = new int();
      }
      
      public function get hasDamageImprove() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set damageImprove(param1:int) : void
      {
         hasField$0 |= 2048;
         damage_improve$field = param1;
      }
      
      public function get damageImprove() : int
      {
         return damage_improve$field;
      }
      
      public function removeCurrentWave() : void
      {
         hasField$0 &= 4294963199;
         currentWave$field = new int();
      }
      
      public function get hasCurrentWave() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set currentWave(param1:int) : void
      {
         hasField$0 |= 4096;
         currentWave$field = param1;
      }
      
      public function get currentWave() : int
      {
         return currentWave$field;
      }
      
      public function removeBattleFrom() : void
      {
         hasField$0 &= 4294959103;
         battle_from$field = new int();
      }
      
      public function get hasBattleFrom() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set battleFrom(param1:int) : void
      {
         hasField$0 |= 8192;
         battle_from$field = param1;
      }
      
      public function get battleFrom() : int
      {
         return battle_from$field;
      }
      
      public function removeViewSide() : void
      {
         hasField$0 &= 4294950911;
         view_side$field = new int();
      }
      
      public function get hasViewSide() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set viewSide(param1:int) : void
      {
         hasField$0 |= 16384;
         view_side$field = param1;
      }
      
      public function get viewSide() : int
      {
         return view_side$field;
      }
      
      public function removePage() : void
      {
         hasField$0 &= 4294934527;
         page$field = new int();
      }
      
      public function get hasPage() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set page(param1:int) : void
      {
         hasField$0 |= 32768;
         page$field = param1;
      }
      
      public function get page() : int
      {
         return page$field;
      }
      
      public function removeTotalPage() : void
      {
         hasField$0 &= 4294901759;
         total_page$field = new int();
      }
      
      public function get hasTotalPage() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set totalPage(param1:int) : void
      {
         hasField$0 |= 65536;
         total_page$field = param1;
      }
      
      public function get totalPage() : int
      {
         return total_page$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc7_:* = 0;
         var _loc11_:* = 0;
         var _loc3_:* = 0;
         var _loc12_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc10_:* = 0;
         var _loc5_:* = 0;
         var _loc9_:* = 0;
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasBattleType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,battle_type$field);
         }
         if(hasMapTempId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,map_temp_id$field);
         }
         if(hasNeedAnimation)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,need_animation$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasHasAssault)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,has_assault$field);
         }
         if(hasUseWay)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,use_way$field);
         }
         if(hasAttackModel)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,attack_model$field);
         }
         if(hasReinforceCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,reinforceCount$field);
         }
         if(hasCurrentReinforce)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,currentReinforce$field);
         }
         if(hasBattleCapity)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,battle_capity$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,count_down$field);
         }
         if(hasDamageImprove)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,damage_improve$field);
         }
         _loc7_ = 0;
         while(_loc7_ < soldiers.length)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,soldiers[_loc7_]);
            _loc7_++;
         }
         _loc11_ = 0;
         while(_loc11_ < heros.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,heros[_loc11_]);
            _loc11_++;
         }
         _loc3_ = 0;
         while(_loc3_ < soldierTemplated.length)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,soldierTemplated[_loc3_]);
            _loc3_++;
         }
         _loc12_ = 0;
         while(_loc12_ < coolDown.length)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_MESSAGE(param1,coolDown[_loc12_]);
            _loc12_++;
         }
         if(hasCurrentWave)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,currentWave$field);
         }
         _loc4_ = 0;
         while(_loc4_ < pets.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,pets[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < children.length)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_MESSAGE(param1,children[_loc2_]);
            _loc2_++;
         }
         _loc10_ = 0;
         while(_loc10_ < heroTempId.length)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,heroTempId[_loc10_]);
            _loc10_++;
         }
         _loc5_ = 0;
         while(_loc5_ < life.length)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT64(param1,life[_loc5_]);
            _loc5_++;
         }
         if(hasBattleFrom)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,battle_from$field);
         }
         if(hasViewSide)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,view_side$field);
         }
         _loc9_ = 0;
         while(_loc9_ < goddesses.length)
         {
            WriteUtils.writeTag(param1,2,25);
            WriteUtils.write$TYPE_MESSAGE(param1,goddesses[_loc9_]);
            _loc9_++;
         }
         if(hasPage)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,page$field);
         }
         if(hasTotalPage)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,total_page$field);
         }
         _loc6_ = 0;
         while(_loc6_ < monsters.length)
         {
            WriteUtils.writeTag(param1,2,28);
            WriteUtils.write$TYPE_MESSAGE(param1,monsters[_loc6_]);
            _loc6_++;
         }
         _loc8_ = 0;
         while(_loc8_ < chessList.length)
         {
            WriteUtils.writeTag(param1,2,29);
            WriteUtils.write$TYPE_MESSAGE(param1,chessList[_loc8_]);
            _loc8_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc6_:SoldierMsg = null;
         var _loc19_:HeroMsg = null;
         var _loc20_:CoolDownMsg = null;
         var _loc7_:HeroMsg = null;
         var _loc23_:HeroMsg = null;
         var _loc8_:HeroMsg = null;
         var _loc15_:HeroMsg = null;
         var _loc12_:HeroMsg = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc28_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc27_:uint = 0;
         var _loc22_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc24_:uint = 0;
         var _loc5_:uint = 0;
         var _loc25_:uint = 0;
         var _loc16_:uint = 0;
         var _loc29_:uint = 0;
         var _loc26_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.battleId cannot be set twice.");
                  }
                  _loc9_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.battleType cannot be set twice.");
                  }
                  _loc10_++;
                  battleType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.mapTempId cannot be set twice.");
                  }
                  _loc11_++;
                  mapTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.needAnimation cannot be set twice.");
                  }
                  _loc3_++;
                  needAnimation = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.side cannot be set twice.");
                  }
                  _loc28_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.hasAssault cannot be set twice.");
                  }
                  _loc17_++;
                  hasAssault = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.useWay cannot be set twice.");
                  }
                  _loc18_++;
                  useWay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.attackModel cannot be set twice.");
                  }
                  _loc27_++;
                  attackModel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.reinforceCount cannot be set twice.");
                  }
                  _loc22_++;
                  reinforceCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.currentReinforce cannot be set twice.");
                  }
                  _loc4_++;
                  currentReinforce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.battleCapity cannot be set twice.");
                  }
                  _loc13_++;
                  battleCapity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.countDown cannot be set twice.");
                  }
                  _loc24_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.damageImprove cannot be set twice.");
                  }
                  _loc5_++;
                  damageImprove = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  _loc6_ = new SoldierMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  soldiers.push(_loc6_);
                  break;
               case 15:
                  _loc19_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc19_);
                  heros.push(_loc19_);
                  break;
               case 16:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,soldierTemplated);
                  }
                  else
                  {
                     soldierTemplated.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 17:
                  _loc20_ = new CoolDownMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc20_);
                  coolDown.push(_loc20_);
                  break;
               case 18:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.currentWave cannot be set twice.");
                  }
                  _loc25_++;
                  currentWave = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  _loc7_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  pets.push(_loc7_);
                  break;
               case 20:
                  _loc23_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc23_);
                  children.push(_loc23_);
                  break;
               case 21:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,heroTempId);
                  }
                  else
                  {
                     heroTempId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 22:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT64,life);
                  }
                  else
                  {
                     life.push(ReadUtils.read$TYPE_INT64(param1));
                  }
                  break;
               case 23:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.battleFrom cannot be set twice.");
                  }
                  _loc16_++;
                  battleFrom = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.viewSide cannot be set twice.");
                  }
                  _loc29_++;
                  viewSide = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  _loc8_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  goddesses.push(_loc8_);
                  break;
               case 26:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.page cannot be set twice.");
                  }
                  _loc26_++;
                  page = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: BattlePrepareMsg.totalPage cannot be set twice.");
                  }
                  _loc14_++;
                  totalPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  _loc15_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc15_);
                  monsters.push(_loc15_);
                  break;
               case 29:
                  _loc12_ = new HeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc12_);
                  chessList.push(_loc12_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

