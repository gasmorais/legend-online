package com.road.yishi.proto.unrealshooting
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class UnrealShootingPlayerMsg extends Message implements IExternalizable
   {
      
      private var serverName$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var score$field:int;
      
      private var rank$field:int;
      
      private var uuid$field:String;
      
      private var fightPower$field:int;
      
      private var template_id$field:int;
      
      private var killNum$field:int;
      
      private var param1$field:int;
      
      private var team$field:int;
      
      private var item_count$field:int;
      
      private var is_on_hook$field:Boolean;
      
      public function UnrealShootingPlayerMsg()
      {
         super();
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
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
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967291;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 4;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967287;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 8;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
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
      
      public function removeKillNum() : void
      {
         hasField$0 &= 4294967263;
         killNum$field = new int();
      }
      
      public function get hasKillNum() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set killNum(param1:int) : void
      {
         hasField$0 |= 32;
         killNum$field = param1;
      }
      
      public function get killNum() : int
      {
         return killNum$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967231;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 64;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeTeam() : void
      {
         hasField$0 &= 4294967167;
         team$field = new int();
      }
      
      public function get hasTeam() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set team(param1:int) : void
      {
         hasField$0 |= 128;
         team$field = param1;
      }
      
      public function get team() : int
      {
         return team$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967039;
         item_count$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 256;
         item_count$field = param1;
      }
      
      public function get itemCount() : int
      {
         return item_count$field;
      }
      
      public function removeIsOnHook() : void
      {
         hasField$0 &= 4294966783;
         is_on_hook$field = new Boolean();
      }
      
      public function get hasIsOnHook() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isOnHook(param1:Boolean) : void
      {
         hasField$0 |= 512;
         is_on_hook$field = param1;
      }
      
      public function get isOnHook() : Boolean
      {
         return is_on_hook$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasKillNum)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,killNum$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,item_count$field);
         }
         if(hasIsOnHook)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,is_on_hook$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.nickName cannot be set twice.");
                  }
                  _loc11_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.score cannot be set twice.");
                  }
                  _loc14_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.rank cannot be set twice.");
                  }
                  _loc3_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.uuid cannot be set twice.");
                  }
                  _loc9_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.templateId cannot be set twice.");
                  }
                  _loc12_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.killNum cannot be set twice.");
                  }
                  _loc7_++;
                  killNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.team cannot be set twice.");
                  }
                  _loc15_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.itemCount cannot be set twice.");
                  }
                  _loc16_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: UnrealShootingPlayerMsg.isOnHook cannot be set twice.");
                  }
                  _loc10_++;
                  isOnHook = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

