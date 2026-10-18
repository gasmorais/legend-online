package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WildLandMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var map_id$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var template_id$field:int;
      
      private var type$field:int;
      
      private var occupy_player_id$field:int;
      
      private var occupy_player_name$field:String;
      
      private var occupy_league_name$field:String;
      
      private var level$field:int;
      
      private var refresh_time$field:int;
      
      private var state$field:int;
      
      private var create_date$field:String;
      
      private var simple_hero_info$field:SimpleHeroInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.army.ArmyPawnInfoMsg")]
      public var armyPawn:Array = [];
      
      [ArrayElementType("int")]
      public var curArmyId:Array = [];
      
      private var fight_capaity$field:int;
      
      private var BossType$field:int;
      
      private var size$field:int;
      
      private var lifeMasterType$field:int;
      
      private var lifeSonType$field:int;
      
      public function WildLandMsg()
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
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967293;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 2;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967291;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 4;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967287;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 8;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967279;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 16;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967263;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 32;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeOccupyPlayerId() : void
      {
         hasField$0 &= 4294967231;
         occupy_player_id$field = new int();
      }
      
      public function get hasOccupyPlayerId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set occupyPlayerId(param1:int) : void
      {
         hasField$0 |= 64;
         occupy_player_id$field = param1;
      }
      
      public function get occupyPlayerId() : int
      {
         return occupy_player_id$field;
      }
      
      public function removeOccupyPlayerName() : void
      {
         occupy_player_name$field = null;
      }
      
      public function get hasOccupyPlayerName() : Boolean
      {
         return occupy_player_name$field != null;
      }
      
      public function set occupyPlayerName(param1:String) : void
      {
         occupy_player_name$field = param1;
      }
      
      public function get occupyPlayerName() : String
      {
         return occupy_player_name$field;
      }
      
      public function removeOccupyLeagueName() : void
      {
         occupy_league_name$field = null;
      }
      
      public function get hasOccupyLeagueName() : Boolean
      {
         return occupy_league_name$field != null;
      }
      
      public function set occupyLeagueName(param1:String) : void
      {
         occupy_league_name$field = param1;
      }
      
      public function get occupyLeagueName() : String
      {
         return occupy_league_name$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967167;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 128;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeRefreshTime() : void
      {
         hasField$0 &= 4294967039;
         refresh_time$field = new int();
      }
      
      public function get hasRefreshTime() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set refreshTime(param1:int) : void
      {
         hasField$0 |= 256;
         refresh_time$field = param1;
      }
      
      public function get refreshTime() : int
      {
         return refresh_time$field;
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
      
      public function removeCreateDate() : void
      {
         create_date$field = null;
      }
      
      public function get hasCreateDate() : Boolean
      {
         return create_date$field != null;
      }
      
      public function set createDate(param1:String) : void
      {
         create_date$field = param1;
      }
      
      public function get createDate() : String
      {
         return create_date$field;
      }
      
      public function removeSimpleHeroInfo() : void
      {
         simple_hero_info$field = null;
      }
      
      public function get hasSimpleHeroInfo() : Boolean
      {
         return simple_hero_info$field != null;
      }
      
      public function set simpleHeroInfo(param1:SimpleHeroInfoMsg) : void
      {
         simple_hero_info$field = param1;
      }
      
      public function get simpleHeroInfo() : SimpleHeroInfoMsg
      {
         return simple_hero_info$field;
      }
      
      public function removeFightCapaity() : void
      {
         hasField$0 &= 4294966271;
         fight_capaity$field = new int();
      }
      
      public function get hasFightCapaity() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set fightCapaity(param1:int) : void
      {
         hasField$0 |= 1024;
         fight_capaity$field = param1;
      }
      
      public function get fightCapaity() : int
      {
         return fight_capaity$field;
      }
      
      public function removeBossType() : void
      {
         hasField$0 &= 4294965247;
         BossType$field = new int();
      }
      
      public function get hasBossType() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set bossType(param1:int) : void
      {
         hasField$0 |= 2048;
         BossType$field = param1;
      }
      
      public function get bossType() : int
      {
         return BossType$field;
      }
      
      public function removeSize() : void
      {
         hasField$0 &= 4294963199;
         size$field = new int();
      }
      
      public function get hasSize() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set size(param1:int) : void
      {
         hasField$0 |= 4096;
         size$field = param1;
      }
      
      public function get size() : int
      {
         return size$field;
      }
      
      public function removeLifeMasterType() : void
      {
         hasField$0 &= 4294959103;
         lifeMasterType$field = new int();
      }
      
      public function get hasLifeMasterType() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set lifeMasterType(param1:int) : void
      {
         hasField$0 |= 8192;
         lifeMasterType$field = param1;
      }
      
      public function get lifeMasterType() : int
      {
         return lifeMasterType$field;
      }
      
      public function removeLifeSonType() : void
      {
         hasField$0 &= 4294950911;
         lifeSonType$field = new int();
      }
      
      public function get hasLifeSonType() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set lifeSonType(param1:int) : void
      {
         hasField$0 |= 16384;
         lifeSonType$field = param1;
      }
      
      public function get lifeSonType() : int
      {
         return lifeSonType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasOccupyPlayerId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,occupy_player_id$field);
         }
         if(hasOccupyPlayerName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,occupy_player_name$field);
         }
         if(hasOccupyLeagueName)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,occupy_league_name$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasRefreshTime)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,refresh_time$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasCreateDate)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,create_date$field);
         }
         if(hasSimpleHeroInfo)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,simple_hero_info$field);
         }
         _loc2_ = 0;
         while(_loc2_ < armyPawn.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,armyPawn[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < curArmyId.length)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,curArmyId[_loc3_]);
            _loc3_++;
         }
         if(hasFightCapaity)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,fight_capaity$field);
         }
         if(hasBossType)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,BossType$field);
         }
         if(hasSize)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,size$field);
         }
         if(hasLifeMasterType)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,lifeMasterType$field);
         }
         if(hasLifeSonType)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,lifeSonType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc9_:ArmyPawnInfoMsg = null;
         var _loc8_:uint = 0;
         var _loc19_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc20_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc22_:uint = 0;
         var _loc14_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc16_:uint = 0;
         var _loc15_:uint = 0;
         var _loc7_:uint = 0;
         var _loc23_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.id cannot be set twice.");
                  }
                  _loc8_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.mapId cannot be set twice.");
                  }
                  _loc19_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.posX cannot be set twice.");
                  }
                  _loc13_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.templateId cannot be set twice.");
                  }
                  _loc20_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.type cannot be set twice.");
                  }
                  _loc11_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.occupyPlayerId cannot be set twice.");
                  }
                  _loc4_++;
                  occupyPlayerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.occupyPlayerName cannot be set twice.");
                  }
                  _loc22_++;
                  occupyPlayerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.occupyLeagueName cannot be set twice.");
                  }
                  _loc14_++;
                  occupyLeagueName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.level cannot be set twice.");
                  }
                  _loc5_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.refreshTime cannot be set twice.");
                  }
                  _loc6_++;
                  refreshTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.state cannot be set twice.");
                  }
                  _loc17_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.createDate cannot be set twice.");
                  }
                  _loc18_++;
                  createDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.simpleHeroInfo cannot be set twice.");
                  }
                  _loc12_++;
                  simpleHeroInfo = new SimpleHeroInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,simpleHeroInfo);
                  break;
               case 15:
                  _loc9_ = new ArmyPawnInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  armyPawn.push(_loc9_);
                  break;
               case 16:
                  if((_loc21_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,curArmyId);
                  }
                  else
                  {
                     curArmyId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 17:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.fightCapaity cannot be set twice.");
                  }
                  _loc16_++;
                  fightCapaity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.bossType cannot be set twice.");
                  }
                  _loc15_++;
                  bossType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.size cannot be set twice.");
                  }
                  _loc7_++;
                  size = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.lifeMasterType cannot be set twice.");
                  }
                  _loc23_++;
                  lifeMasterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WildLandMsg.lifeSonType cannot be set twice.");
                  }
                  _loc10_++;
                  lifeSonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

