package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarReportMsg extends Message implements IExternalizable
   {
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var user_id$field:int;
      
      private var score$field:int;
      
      private var hitCount$field:int;
      
      private var team_id$field:int;
      
      private var geste$field:int;
      
      private var server_name$field:String;
      
      private var item_count$field:int;
      
      private var win_geste_count$field:int;
      
      private var seniorStoreCount$field:int;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var soulsStoreCount$field:int;
      
      private var player_uuid$field:String;
      
      public function WarReportMsg()
      {
         super();
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967294;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 1;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
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
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967291;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 4;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeHitCount() : void
      {
         hasField$0 &= 4294967287;
         hitCount$field = new int();
      }
      
      public function get hasHitCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set hitCount(param1:int) : void
      {
         hasField$0 |= 8;
         hitCount$field = param1;
      }
      
      public function get hitCount() : int
      {
         return hitCount$field;
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967279;
         team_id$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 16;
         team_id$field = param1;
      }
      
      public function get teamId() : int
      {
         return team_id$field;
      }
      
      public function removeGeste() : void
      {
         hasField$0 &= 4294967263;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 32;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
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
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967231;
         item_count$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 64;
         item_count$field = param1;
      }
      
      public function get itemCount() : int
      {
         return item_count$field;
      }
      
      public function removeWinGesteCount() : void
      {
         hasField$0 &= 4294967167;
         win_geste_count$field = new int();
      }
      
      public function get hasWinGesteCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set winGesteCount(param1:int) : void
      {
         hasField$0 |= 128;
         win_geste_count$field = param1;
      }
      
      public function get winGesteCount() : int
      {
         return win_geste_count$field;
      }
      
      public function removeSeniorStoreCount() : void
      {
         hasField$0 &= 4294967039;
         seniorStoreCount$field = new int();
      }
      
      public function get hasSeniorStoreCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set seniorStoreCount(param1:int) : void
      {
         hasField$0 |= 256;
         seniorStoreCount$field = param1;
      }
      
      public function get seniorStoreCount() : int
      {
         return seniorStoreCount$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294966783;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 512;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294966271;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 1024;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeSoulsStoreCount() : void
      {
         hasField$0 &= 4294965247;
         soulsStoreCount$field = new int();
      }
      
      public function get hasSoulsStoreCount() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set soulsStoreCount(param1:int) : void
      {
         hasField$0 |= 2048;
         soulsStoreCount$field = param1;
      }
      
      public function get soulsStoreCount() : int
      {
         return soulsStoreCount$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasHitCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,hitCount$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,item_count$field);
         }
         if(hasWinGesteCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,win_geste_count$field);
         }
         if(hasSeniorStoreCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,seniorStoreCount$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasSoulsStoreCount)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,soulsStoreCount$field);
         }
         if(hasPlayerUuid)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,player_uuid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc17_:uint = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.order cannot be set twice.");
                  }
                  _loc8_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.userId cannot be set twice.");
                  }
                  _loc11_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.score cannot be set twice.");
                  }
                  _loc13_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.hitCount cannot be set twice.");
                  }
                  _loc14_++;
                  hitCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.teamId cannot be set twice.");
                  }
                  _loc6_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.geste cannot be set twice.");
                  }
                  _loc17_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.serverName cannot be set twice.");
                  }
                  _loc5_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.itemCount cannot be set twice.");
                  }
                  _loc15_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.winGesteCount cannot be set twice.");
                  }
                  _loc16_++;
                  winGesteCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.seniorStoreCount cannot be set twice.");
                  }
                  _loc10_++;
                  seniorStoreCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.param2 cannot be set twice.");
                  }
                  _loc18_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.soulsStoreCount cannot be set twice.");
                  }
                  _loc9_++;
                  soulsStoreCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportMsg.playerUuid cannot be set twice.");
                  }
                  _loc7_++;
                  playerUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

