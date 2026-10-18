package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerVehicleMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var hp$field:int;
      
      private var team$field:int;
      
      [ArrayElementType("int")]
      public var buffState:Array = [];
      
      private var grade$field:int;
      
      private var name$field:String;
      
      private var head$field:int;
      
      private var x$field:int;
      
      private var y$field:int;
      
      private var playerId$field:int;
      
      private var consortia$field:String;
      
      private var vip$field:int;
      
      private var appellId$field:int;
      
      private var rebornTime$field:int;
      
      private var npcNodeId$field:int;
      
      private var serverName$field:String;
      
      private var trans_grade$field:int;
      
      private var vipType$field:int;
      
      private var is_back_player$field:Boolean;
      
      private var changeBranch$field:int;
      
      private var maxHp$field:int;
      
      private var defaultSkills$field:String;
      
      private var isHoldKey$field:Boolean;
      
      public function PlayerVehicleMsg()
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
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967291;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 4;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeTeam() : void
      {
         hasField$0 &= 4294967287;
         team$field = new int();
      }
      
      public function get hasTeam() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set team(param1:int) : void
      {
         hasField$0 |= 8;
         team$field = param1;
      }
      
      public function get team() : int
      {
         return team$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967279;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 16;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
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
      
      public function removeHead() : void
      {
         hasField$0 &= 4294967263;
         head$field = new int();
      }
      
      public function get hasHead() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set head(param1:int) : void
      {
         hasField$0 |= 32;
         head$field = param1;
      }
      
      public function get head() : int
      {
         return head$field;
      }
      
      public function removeX() : void
      {
         hasField$0 &= 4294967231;
         x$field = new int();
      }
      
      public function get hasX() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set x(param1:int) : void
      {
         hasField$0 |= 64;
         x$field = param1;
      }
      
      public function get x() : int
      {
         return x$field;
      }
      
      public function removeY() : void
      {
         hasField$0 &= 4294967167;
         y$field = new int();
      }
      
      public function get hasY() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set y(param1:int) : void
      {
         hasField$0 |= 128;
         y$field = param1;
      }
      
      public function get y() : int
      {
         return y$field;
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967039;
         playerId$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 256;
         playerId$field = param1;
      }
      
      public function get playerId() : int
      {
         return playerId$field;
      }
      
      public function removeConsortia() : void
      {
         consortia$field = null;
      }
      
      public function get hasConsortia() : Boolean
      {
         return consortia$field != null;
      }
      
      public function set consortia(param1:String) : void
      {
         consortia$field = param1;
      }
      
      public function get consortia() : String
      {
         return consortia$field;
      }
      
      public function removeVip() : void
      {
         hasField$0 &= 4294966783;
         vip$field = new int();
      }
      
      public function get hasVip() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set vip(param1:int) : void
      {
         hasField$0 |= 512;
         vip$field = param1;
      }
      
      public function get vip() : int
      {
         return vip$field;
      }
      
      public function removeAppellId() : void
      {
         hasField$0 &= 4294966271;
         appellId$field = new int();
      }
      
      public function get hasAppellId() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set appellId(param1:int) : void
      {
         hasField$0 |= 1024;
         appellId$field = param1;
      }
      
      public function get appellId() : int
      {
         return appellId$field;
      }
      
      public function removeRebornTime() : void
      {
         hasField$0 &= 4294965247;
         rebornTime$field = new int();
      }
      
      public function get hasRebornTime() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set rebornTime(param1:int) : void
      {
         hasField$0 |= 2048;
         rebornTime$field = param1;
      }
      
      public function get rebornTime() : int
      {
         return rebornTime$field;
      }
      
      public function removeNpcNodeId() : void
      {
         hasField$0 &= 4294963199;
         npcNodeId$field = new int();
      }
      
      public function get hasNpcNodeId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set npcNodeId(param1:int) : void
      {
         hasField$0 |= 4096;
         npcNodeId$field = param1;
      }
      
      public function get npcNodeId() : int
      {
         return npcNodeId$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 4294959103;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 8192;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294950911;
         vipType$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 16384;
         vipType$field = param1;
      }
      
      public function get vipType() : int
      {
         return vipType$field;
      }
      
      public function removeIsBackPlayer() : void
      {
         hasField$0 &= 4294934527;
         is_back_player$field = new Boolean();
      }
      
      public function get hasIsBackPlayer() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set isBackPlayer(param1:Boolean) : void
      {
         hasField$0 |= 32768;
         is_back_player$field = param1;
      }
      
      public function get isBackPlayer() : Boolean
      {
         return is_back_player$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$0 &= 4294901759;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$0 |= 65536;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
      }
      
      public function removeMaxHp() : void
      {
         hasField$0 &= 4294836223;
         maxHp$field = new int();
      }
      
      public function get hasMaxHp() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set maxHp(param1:int) : void
      {
         hasField$0 |= 131072;
         maxHp$field = param1;
      }
      
      public function get maxHp() : int
      {
         return maxHp$field;
      }
      
      public function removeDefaultSkills() : void
      {
         defaultSkills$field = null;
      }
      
      public function get hasDefaultSkills() : Boolean
      {
         return defaultSkills$field != null;
      }
      
      public function set defaultSkills(param1:String) : void
      {
         defaultSkills$field = param1;
      }
      
      public function get defaultSkills() : String
      {
         return defaultSkills$field;
      }
      
      public function removeIsHoldKey() : void
      {
         hasField$0 &= 4294705151;
         isHoldKey$field = new Boolean();
      }
      
      public function get hasIsHoldKey() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set isHoldKey(param1:Boolean) : void
      {
         hasField$0 |= 262144;
         isHoldKey$field = param1;
      }
      
      public function get isHoldKey() : Boolean
      {
         return isHoldKey$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         _loc2_ = 0;
         while(_loc2_ < buffState.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,buffState[_loc2_]);
            _loc2_++;
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasHead)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,head$field);
         }
         if(hasX)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,x$field);
         }
         if(hasY)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,y$field);
         }
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,playerId$field);
         }
         if(hasConsortia)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,consortia$field);
         }
         if(hasVip)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,vip$field);
         }
         if(hasAppellId)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,appellId$field);
         }
         if(hasRebornTime)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,rebornTime$field);
         }
         if(hasNpcNodeId)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,npcNodeId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,vipType$field);
         }
         if(hasIsBackPlayer)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_BOOL(param1,is_back_player$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,maxHp$field);
         }
         if(hasDefaultSkills)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,defaultSkills$field);
         }
         if(hasIsHoldKey)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_BOOL(param1,isHoldKey$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc4_:uint = 0;
         var _loc21_:uint = 0;
         var _loc19_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         var _loc26_:uint = 0;
         var _loc20_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc23_:uint = 0;
         var _loc22_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.id cannot be set twice.");
                  }
                  _loc17_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.templateId cannot be set twice.");
                  }
                  _loc18_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.hp cannot be set twice.");
                  }
                  _loc24_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.team cannot be set twice.");
                  }
                  _loc25_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,buffState);
                  }
                  else
                  {
                     buffState.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.name cannot be set twice.");
                  }
                  _loc21_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.head cannot be set twice.");
                  }
                  _loc19_++;
                  head = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.x cannot be set twice.");
                  }
                  _loc14_++;
                  x = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.y cannot be set twice.");
                  }
                  _loc3_++;
                  y = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.playerId cannot be set twice.");
                  }
                  _loc15_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.consortia cannot be set twice.");
                  }
                  _loc8_++;
                  consortia = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.vip cannot be set twice.");
                  }
                  _loc26_++;
                  vip = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.appellId cannot be set twice.");
                  }
                  _loc20_++;
                  appellId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.rebornTime cannot be set twice.");
                  }
                  _loc6_++;
                  rebornTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.npcNodeId cannot be set twice.");
                  }
                  _loc5_++;
                  npcNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.transGrade cannot be set twice.");
                  }
                  _loc7_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.vipType cannot be set twice.");
                  }
                  _loc10_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.isBackPlayer cannot be set twice.");
                  }
                  _loc11_++;
                  isBackPlayer = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 21:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.changeBranch cannot be set twice.");
                  }
                  _loc16_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.maxHp cannot be set twice.");
                  }
                  _loc12_++;
                  maxHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.defaultSkills cannot be set twice.");
                  }
                  _loc23_++;
                  defaultSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 24:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerVehicleMsg.isHoldKey cannot be set twice.");
                  }
                  _loc22_++;
                  isHoldKey = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

