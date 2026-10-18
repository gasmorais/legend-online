package com.road.yishi.proto.daylight
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DayLightUserInfoMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var isViceHero$field:Boolean;
      
      private var isVip$field:Boolean;
      
      private var fightPower$field:int;
      
      private var team$field:int;
      
      private var state$field:int;
      
      private var score$field:int;
      
      private var honor$field:int;
      
      private var reviveCd$field:int;
      
      private var repelCount$field:int;
      
      private var remainCount$field:int;
      
      private var skills$field:String;
      
      private var order$field:int;
      
      private var isReward$field:Boolean;
      
      public function DayLightUserInfoMsg()
      {
         super();
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
      
      public function removeIsViceHero() : void
      {
         hasField$0 &= 4294967293;
         isViceHero$field = new Boolean();
      }
      
      public function get hasIsViceHero() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isViceHero(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isViceHero$field = param1;
      }
      
      public function get isViceHero() : Boolean
      {
         return isViceHero$field;
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294967291;
         isVip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isVip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return isVip$field;
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
      
      public function removeTeam() : void
      {
         hasField$0 &= 4294967279;
         team$field = new int();
      }
      
      public function get hasTeam() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set team(param1:int) : void
      {
         hasField$0 |= 16;
         team$field = param1;
      }
      
      public function get team() : int
      {
         return team$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967263;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 32;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967231;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 64;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeHonor() : void
      {
         hasField$0 &= 4294967167;
         honor$field = new int();
      }
      
      public function get hasHonor() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set honor(param1:int) : void
      {
         hasField$0 |= 128;
         honor$field = param1;
      }
      
      public function get honor() : int
      {
         return honor$field;
      }
      
      public function removeReviveCd() : void
      {
         hasField$0 &= 4294967039;
         reviveCd$field = new int();
      }
      
      public function get hasReviveCd() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set reviveCd(param1:int) : void
      {
         hasField$0 |= 256;
         reviveCd$field = param1;
      }
      
      public function get reviveCd() : int
      {
         return reviveCd$field;
      }
      
      public function removeRepelCount() : void
      {
         hasField$0 &= 4294966783;
         repelCount$field = new int();
      }
      
      public function get hasRepelCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set repelCount(param1:int) : void
      {
         hasField$0 |= 512;
         repelCount$field = param1;
      }
      
      public function get repelCount() : int
      {
         return repelCount$field;
      }
      
      public function removeRemainCount() : void
      {
         hasField$0 &= 4294966271;
         remainCount$field = new int();
      }
      
      public function get hasRemainCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set remainCount(param1:int) : void
      {
         hasField$0 |= 1024;
         remainCount$field = param1;
      }
      
      public function get remainCount() : int
      {
         return remainCount$field;
      }
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294965247;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 2048;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294963199;
         isReward$field = new Boolean();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isReward(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         isReward$field = param1;
      }
      
      public function get isReward() : Boolean
      {
         return isReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasIsViceHero)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isViceHero$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isVip$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasHonor)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,honor$field);
         }
         if(hasReviveCd)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,reviveCd$field);
         }
         if(hasRepelCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,repelCount$field);
         }
         if(hasRemainCount)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,remainCount$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,isReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc20_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.uuid cannot be set twice.");
                  }
                  _loc9_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.nickName cannot be set twice.");
                  }
                  _loc14_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.isViceHero cannot be set twice.");
                  }
                  _loc6_++;
                  isViceHero = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.isVip cannot be set twice.");
                  }
                  _loc7_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.team cannot be set twice.");
                  }
                  _loc20_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.state cannot be set twice.");
                  }
                  _loc17_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.score cannot be set twice.");
                  }
                  _loc19_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.honor cannot be set twice.");
                  }
                  _loc11_++;
                  honor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.reviveCd cannot be set twice.");
                  }
                  _loc12_++;
                  reviveCd = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.repelCount cannot be set twice.");
                  }
                  _loc3_++;
                  repelCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.remainCount cannot be set twice.");
                  }
                  _loc13_++;
                  remainCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.skills cannot be set twice.");
                  }
                  _loc8_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.order cannot be set twice.");
                  }
                  _loc15_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: DayLightUserInfoMsg.isReward cannot be set twice.");
                  }
                  _loc16_++;
                  isReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

