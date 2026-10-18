package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleCreateMsg extends Message implements IExternalizable
   {
      
      private var map_temp_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var proxy_id$field:String;
      
      private var type$field:int;
      
      private var attacker_num$field:int;
      
      private var user_side$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.ArmyMsg")]
      public var army:Array = [];
      
      private var reinforceCount$field:int;
      
      private var campaign_id$field:int;
      
      private var capity$field:int;
      
      private var last_wound$field:Int64;
      
      private var node_id$field:int;
      
      private var castle_room_id$field:int;
      
      private var server_name$field:String;
      
      private var defence_server_name$field:String;
      
      private var defence_user_id$field:int;
      
      private var campaign_uuid$field:String;
      
      private var server_id$field:int;
      
      private var battle_uid$field:String;
      
      private var maxLeagueScore$field:int;
      
      private var site$field:String;
      
      private var battleModel$field:int;
      
      private var param1$field:int;
      
      private var rempteSkills$field:String;
      
      private var page$field:int;
      
      private var total_page$field:int;
      
      public function BattleCreateMsg()
      {
         super();
      }
      
      public function removeMapTempId() : void
      {
         hasField$0 &= 4294967294;
         map_temp_id$field = new int();
      }
      
      public function get hasMapTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapTempId(param1:int) : void
      {
         hasField$0 |= 1;
         map_temp_id$field = param1;
      }
      
      public function get mapTempId() : int
      {
         return map_temp_id$field;
      }
      
      public function removeProxyId() : void
      {
         proxy_id$field = null;
      }
      
      public function get hasProxyId() : Boolean
      {
         return proxy_id$field != null;
      }
      
      public function set proxyId(param1:String) : void
      {
         proxy_id$field = param1;
      }
      
      public function get proxyId() : String
      {
         return proxy_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeAttackerNum() : void
      {
         hasField$0 &= 4294967291;
         attacker_num$field = new int();
      }
      
      public function get hasAttackerNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set attackerNum(param1:int) : void
      {
         hasField$0 |= 4;
         attacker_num$field = param1;
      }
      
      public function get attackerNum() : int
      {
         return attacker_num$field;
      }
      
      public function removeUserSide() : void
      {
         hasField$0 &= 4294967287;
         user_side$field = new int();
      }
      
      public function get hasUserSide() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set userSide(param1:int) : void
      {
         hasField$0 |= 8;
         user_side$field = param1;
      }
      
      public function get userSide() : int
      {
         return user_side$field;
      }
      
      public function removeReinforceCount() : void
      {
         hasField$0 &= 4294967279;
         reinforceCount$field = new int();
      }
      
      public function get hasReinforceCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set reinforceCount(param1:int) : void
      {
         hasField$0 |= 16;
         reinforceCount$field = param1;
      }
      
      public function get reinforceCount() : int
      {
         return reinforceCount$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967263;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 32;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeCapity() : void
      {
         hasField$0 &= 4294967231;
         capity$field = new int();
      }
      
      public function get hasCapity() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set capity(param1:int) : void
      {
         hasField$0 |= 64;
         capity$field = param1;
      }
      
      public function get capity() : int
      {
         return capity$field;
      }
      
      public function removeLastWound() : void
      {
         last_wound$field = null;
      }
      
      public function get hasLastWound() : Boolean
      {
         return last_wound$field != null;
      }
      
      public function set lastWound(param1:Int64) : void
      {
         last_wound$field = param1;
      }
      
      public function get lastWound() : Int64
      {
         return last_wound$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967167;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 128;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeCastleRoomId() : void
      {
         hasField$0 &= 4294967039;
         castle_room_id$field = new int();
      }
      
      public function get hasCastleRoomId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set castleRoomId(param1:int) : void
      {
         hasField$0 |= 256;
         castle_room_id$field = param1;
      }
      
      public function get castleRoomId() : int
      {
         return castle_room_id$field;
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
      
      public function removeDefenceServerName() : void
      {
         defence_server_name$field = null;
      }
      
      public function get hasDefenceServerName() : Boolean
      {
         return defence_server_name$field != null;
      }
      
      public function set defenceServerName(param1:String) : void
      {
         defence_server_name$field = param1;
      }
      
      public function get defenceServerName() : String
      {
         return defence_server_name$field;
      }
      
      public function removeDefenceUserId() : void
      {
         hasField$0 &= 4294966783;
         defence_user_id$field = new int();
      }
      
      public function get hasDefenceUserId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set defenceUserId(param1:int) : void
      {
         hasField$0 |= 512;
         defence_user_id$field = param1;
      }
      
      public function get defenceUserId() : int
      {
         return defence_user_id$field;
      }
      
      public function removeCampaignUuid() : void
      {
         campaign_uuid$field = null;
      }
      
      public function get hasCampaignUuid() : Boolean
      {
         return campaign_uuid$field != null;
      }
      
      public function set campaignUuid(param1:String) : void
      {
         campaign_uuid$field = param1;
      }
      
      public function get campaignUuid() : String
      {
         return campaign_uuid$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294966271;
         server_id$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 1024;
         server_id$field = param1;
      }
      
      public function get serverId() : int
      {
         return server_id$field;
      }
      
      public function removeBattleUid() : void
      {
         battle_uid$field = null;
      }
      
      public function get hasBattleUid() : Boolean
      {
         return battle_uid$field != null;
      }
      
      public function set battleUid(param1:String) : void
      {
         battle_uid$field = param1;
      }
      
      public function get battleUid() : String
      {
         return battle_uid$field;
      }
      
      public function removeMaxLeagueScore() : void
      {
         hasField$0 &= 4294965247;
         maxLeagueScore$field = new int();
      }
      
      public function get hasMaxLeagueScore() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set maxLeagueScore(param1:int) : void
      {
         hasField$0 |= 2048;
         maxLeagueScore$field = param1;
      }
      
      public function get maxLeagueScore() : int
      {
         return maxLeagueScore$field;
      }
      
      public function removeSite() : void
      {
         site$field = null;
      }
      
      public function get hasSite() : Boolean
      {
         return site$field != null;
      }
      
      public function set site(param1:String) : void
      {
         site$field = param1;
      }
      
      public function get site() : String
      {
         return site$field;
      }
      
      public function removeBattleModel() : void
      {
         hasField$0 &= 4294963199;
         battleModel$field = new int();
      }
      
      public function get hasBattleModel() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set battleModel(param1:int) : void
      {
         hasField$0 |= 4096;
         battleModel$field = param1;
      }
      
      public function get battleModel() : int
      {
         return battleModel$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294959103;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 8192;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeRempteSkills() : void
      {
         rempteSkills$field = null;
      }
      
      public function get hasRempteSkills() : Boolean
      {
         return rempteSkills$field != null;
      }
      
      public function set rempteSkills(param1:String) : void
      {
         rempteSkills$field = param1;
      }
      
      public function get rempteSkills() : String
      {
         return rempteSkills$field;
      }
      
      public function removePage() : void
      {
         hasField$0 &= 4294950911;
         page$field = new int();
      }
      
      public function get hasPage() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set page(param1:int) : void
      {
         hasField$0 |= 16384;
         page$field = param1;
      }
      
      public function get page() : int
      {
         return page$field;
      }
      
      public function removeTotalPage() : void
      {
         hasField$0 &= 4294934527;
         total_page$field = new int();
      }
      
      public function get hasTotalPage() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set totalPage(param1:int) : void
      {
         hasField$0 |= 32768;
         total_page$field = param1;
      }
      
      public function get totalPage() : int
      {
         return total_page$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasMapTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,map_temp_id$field);
         }
         if(hasProxyId)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,proxy_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasAttackerNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,attacker_num$field);
         }
         if(hasUserSide)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,user_side$field);
         }
         _loc2_ = 0;
         while(_loc2_ < army.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,army[_loc2_]);
            _loc2_++;
         }
         if(hasReinforceCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,reinforceCount$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasCapity)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,capity$field);
         }
         if(hasLastWound)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT64(param1,last_wound$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasCastleRoomId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,castle_room_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasDefenceServerName)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,defence_server_name$field);
         }
         if(hasDefenceUserId)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,defence_user_id$field);
         }
         if(hasCampaignUuid)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,campaign_uuid$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,server_id$field);
         }
         if(hasBattleUid)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,battle_uid$field);
         }
         if(hasMaxLeagueScore)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,maxLeagueScore$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
         if(hasBattleModel)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,battleModel$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasRempteSkills)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_STRING(param1,rempteSkills$field);
         }
         if(hasPage)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,page$field);
         }
         if(hasTotalPage)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,total_page$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc20_:ArmyMsg = null;
         var _loc9_:uint = 0;
         var _loc16_:uint = 0;
         var _loc23_:uint = 0;
         var _loc6_:uint = 0;
         var _loc25_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc28_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc21_:uint = 0;
         var _loc26_:uint = 0;
         var _loc27_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc24_:uint = 0;
         var _loc5_:uint = 0;
         var _loc19_:uint = 0;
         var _loc18_:uint = 0;
         var _loc22_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.mapTempId cannot be set twice.");
                  }
                  _loc9_++;
                  mapTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.proxyId cannot be set twice.");
                  }
                  _loc16_++;
                  proxyId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.type cannot be set twice.");
                  }
                  _loc23_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.attackerNum cannot be set twice.");
                  }
                  _loc6_++;
                  attackerNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.userSide cannot be set twice.");
                  }
                  _loc25_++;
                  userSide = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc20_ = new ArmyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc20_);
                  army.push(_loc20_);
                  break;
               case 7:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.reinforceCount cannot be set twice.");
                  }
                  _loc17_++;
                  reinforceCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.campaignId cannot be set twice.");
                  }
                  _loc10_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.capity cannot be set twice.");
                  }
                  _loc28_++;
                  capity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.lastWound cannot be set twice.");
                  }
                  _loc12_++;
                  lastWound = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 11:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.nodeId cannot be set twice.");
                  }
                  _loc7_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.castleRoomId cannot be set twice.");
                  }
                  _loc3_++;
                  castleRoomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.defenceServerName cannot be set twice.");
                  }
                  _loc21_++;
                  defenceServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.defenceUserId cannot be set twice.");
                  }
                  _loc26_++;
                  defenceUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.campaignUuid cannot be set twice.");
                  }
                  _loc27_++;
                  campaignUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.serverId cannot be set twice.");
                  }
                  _loc4_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.battleUid cannot be set twice.");
                  }
                  _loc13_++;
                  battleUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.maxLeagueScore cannot be set twice.");
                  }
                  _loc15_++;
                  maxLeagueScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.site cannot be set twice.");
                  }
                  _loc24_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.battleModel cannot be set twice.");
                  }
                  _loc5_++;
                  battleModel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.param1 cannot be set twice.");
                  }
                  _loc19_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.rempteSkills cannot be set twice.");
                  }
                  _loc18_++;
                  rempteSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 24:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.page cannot be set twice.");
                  }
                  _loc22_++;
                  page = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BattleCreateMsg.totalPage cannot be set twice.");
                  }
                  _loc11_++;
                  totalPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

