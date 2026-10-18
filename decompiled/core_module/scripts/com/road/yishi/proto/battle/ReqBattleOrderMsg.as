package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReqBattleOrderMsg extends Message implements IExternalizable
   {
      
      private var defence_user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var defence_server_name$field:String;
      
      private var side$field:int;
      
      private var nodeId$field:int;
      
      private var campaign_uid$field:String;
      
      private var campaign_id$field:int;
      
      private var property1$field:int;
      
      private var property2$field:String;
      
      private var battleType$field:int;
      
      private var battle_scene$field:int;
      
      private var server_name$field:String;
      
      private var user_id$field:int;
      
      public function ReqBattleOrderMsg()
      {
         super();
      }
      
      public function removeDefenceUserId() : void
      {
         hasField$0 &= 4294967294;
         defence_user_id$field = new int();
      }
      
      public function get hasDefenceUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set defenceUserId(param1:int) : void
      {
         hasField$0 |= 1;
         defence_user_id$field = param1;
      }
      
      public function get defenceUserId() : int
      {
         return defence_user_id$field;
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
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967293;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 2;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967291;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 4;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeCampaignUid() : void
      {
         campaign_uid$field = null;
      }
      
      public function get hasCampaignUid() : Boolean
      {
         return campaign_uid$field != null;
      }
      
      public function set campaignUid(param1:String) : void
      {
         campaign_uid$field = param1;
      }
      
      public function get campaignUid() : String
      {
         return campaign_uid$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967287;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 8;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294967279;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 16;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      public function removeBattleType() : void
      {
         hasField$0 &= 4294967263;
         battleType$field = new int();
      }
      
      public function get hasBattleType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set battleType(param1:int) : void
      {
         hasField$0 |= 32;
         battleType$field = param1;
      }
      
      public function get battleType() : int
      {
         return battleType$field;
      }
      
      public function removeBattleScene() : void
      {
         hasField$0 &= 4294967231;
         battle_scene$field = new int();
      }
      
      public function get hasBattleScene() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set battleScene(param1:int) : void
      {
         hasField$0 |= 64;
         battle_scene$field = param1;
      }
      
      public function get battleScene() : int
      {
         return battle_scene$field;
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967167;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 128;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasDefenceUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,defence_user_id$field);
         }
         if(hasDefenceServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,defence_server_name$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasCampaignUid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,campaign_uid$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         if(hasBattleType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,battleType$field);
         }
         if(hasBattleScene)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,battle_scene$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.defenceUserId cannot be set twice.");
                  }
                  _loc11_++;
                  defenceUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.defenceServerName cannot be set twice.");
                  }
                  _loc6_++;
                  defenceServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.side cannot be set twice.");
                  }
                  _loc9_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.campaignUid cannot be set twice.");
                  }
                  _loc4_++;
                  campaignUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.campaignId cannot be set twice.");
                  }
                  _loc8_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.property1 cannot be set twice.");
                  }
                  _loc10_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.property2 cannot be set twice.");
                  }
                  _loc15_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.battleType cannot be set twice.");
                  }
                  _loc12_++;
                  battleType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.battleScene cannot be set twice.");
                  }
                  _loc5_++;
                  battleScene = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.serverName cannot be set twice.");
                  }
                  _loc7_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ReqBattleOrderMsg.userId cannot be set twice.");
                  }
                  _loc13_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

