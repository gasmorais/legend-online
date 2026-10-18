package com.road.yishi.proto.gods
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GodsPlayerInfoMsg extends Message implements IExternalizable
   {
      
      private var game_key$field:String;
      
      private var server_name$field:String;
      
      private var nick_name$field:String;
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var slotAvata$field:String;
      
      private var clothAvate$field:String;
      
      private var hatAvata$field:String;
      
      private var wingAvata$field:String;
      
      private var fashionArmAvata$field:String;
      
      private var fashionClothAvata$field:String;
      
      private var team_id$field:int;
      
      private var id$field:int;
      
      private var readyScore$field:int;
      
      private var readyOrder$field:int;
      
      private var finalScore$field:int;
      
      private var finalOrder$field:int;
      
      private var rank$field:int;
      
      private var uuid$field:String;
      
      private var fight_power$field:int;
      
      private var user_id$field:int;
      
      private var head_id$field:int;
      
      public function GodsPlayerInfoMsg()
      {
         super();
      }
      
      public function removeGameKey() : void
      {
         game_key$field = null;
      }
      
      public function get hasGameKey() : Boolean
      {
         return game_key$field != null;
      }
      
      public function set gameKey(param1:String) : void
      {
         game_key$field = param1;
      }
      
      public function get gameKey() : String
      {
         return game_key$field;
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
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeSlotAvata() : void
      {
         slotAvata$field = null;
      }
      
      public function get hasSlotAvata() : Boolean
      {
         return slotAvata$field != null;
      }
      
      public function set slotAvata(param1:String) : void
      {
         slotAvata$field = param1;
      }
      
      public function get slotAvata() : String
      {
         return slotAvata$field;
      }
      
      public function removeClothAvate() : void
      {
         clothAvate$field = null;
      }
      
      public function get hasClothAvate() : Boolean
      {
         return clothAvate$field != null;
      }
      
      public function set clothAvate(param1:String) : void
      {
         clothAvate$field = param1;
      }
      
      public function get clothAvate() : String
      {
         return clothAvate$field;
      }
      
      public function removeHatAvata() : void
      {
         hatAvata$field = null;
      }
      
      public function get hasHatAvata() : Boolean
      {
         return hatAvata$field != null;
      }
      
      public function set hatAvata(param1:String) : void
      {
         hatAvata$field = param1;
      }
      
      public function get hatAvata() : String
      {
         return hatAvata$field;
      }
      
      public function removeWingAvata() : void
      {
         wingAvata$field = null;
      }
      
      public function get hasWingAvata() : Boolean
      {
         return wingAvata$field != null;
      }
      
      public function set wingAvata(param1:String) : void
      {
         wingAvata$field = param1;
      }
      
      public function get wingAvata() : String
      {
         return wingAvata$field;
      }
      
      public function removeFashionArmAvata() : void
      {
         fashionArmAvata$field = null;
      }
      
      public function get hasFashionArmAvata() : Boolean
      {
         return fashionArmAvata$field != null;
      }
      
      public function set fashionArmAvata(param1:String) : void
      {
         fashionArmAvata$field = param1;
      }
      
      public function get fashionArmAvata() : String
      {
         return fashionArmAvata$field;
      }
      
      public function removeFashionClothAvata() : void
      {
         fashionClothAvata$field = null;
      }
      
      public function get hasFashionClothAvata() : Boolean
      {
         return fashionClothAvata$field != null;
      }
      
      public function set fashionClothAvata(param1:String) : void
      {
         fashionClothAvata$field = param1;
      }
      
      public function get fashionClothAvata() : String
      {
         return fashionClothAvata$field;
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967293;
         team_id$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 2;
         team_id$field = param1;
      }
      
      public function get teamId() : int
      {
         return team_id$field;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967291;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 4;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeReadyScore() : void
      {
         hasField$0 &= 4294967287;
         readyScore$field = new int();
      }
      
      public function get hasReadyScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set readyScore(param1:int) : void
      {
         hasField$0 |= 8;
         readyScore$field = param1;
      }
      
      public function get readyScore() : int
      {
         return readyScore$field;
      }
      
      public function removeReadyOrder() : void
      {
         hasField$0 &= 4294967279;
         readyOrder$field = new int();
      }
      
      public function get hasReadyOrder() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set readyOrder(param1:int) : void
      {
         hasField$0 |= 16;
         readyOrder$field = param1;
      }
      
      public function get readyOrder() : int
      {
         return readyOrder$field;
      }
      
      public function removeFinalScore() : void
      {
         hasField$0 &= 4294967263;
         finalScore$field = new int();
      }
      
      public function get hasFinalScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set finalScore(param1:int) : void
      {
         hasField$0 |= 32;
         finalScore$field = param1;
      }
      
      public function get finalScore() : int
      {
         return finalScore$field;
      }
      
      public function removeFinalOrder() : void
      {
         hasField$0 &= 4294967231;
         finalOrder$field = new int();
      }
      
      public function get hasFinalOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set finalOrder(param1:int) : void
      {
         hasField$0 |= 64;
         finalOrder$field = param1;
      }
      
      public function get finalOrder() : int
      {
         return finalOrder$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967167;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 128;
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
         hasField$0 &= 4294967039;
         fight_power$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 256;
         fight_power$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fight_power$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294966783;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 512;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294966271;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 1024;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGameKey)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,game_key$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasSlotAvata)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,slotAvata$field);
         }
         if(hasClothAvate)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,clothAvate$field);
         }
         if(hasHatAvata)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,hatAvata$field);
         }
         if(hasWingAvata)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,wingAvata$field);
         }
         if(hasFashionArmAvata)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,fashionArmAvata$field);
         }
         if(hasFashionClothAvata)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,fashionClothAvata$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasReadyScore)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,readyScore$field);
         }
         if(hasReadyOrder)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,readyOrder$field);
         }
         if(hasFinalScore)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,finalScore$field);
         }
         if(hasFinalOrder)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,finalOrder$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,fight_power$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc23_:* = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc21_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         var _loc22_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc24_:uint = 0;
         var _loc14_:uint = 0;
         var _loc18_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc23_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.gameKey cannot be set twice.");
                  }
                  _loc6_++;
                  gameKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.serverName cannot be set twice.");
                  }
                  _loc13_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.templateId cannot be set twice.");
                  }
                  _loc21_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.slotAvata cannot be set twice.");
                  }
                  _loc3_++;
                  slotAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.clothAvate cannot be set twice.");
                  }
                  _loc17_++;
                  clothAvate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.hatAvata cannot be set twice.");
                  }
                  _loc22_++;
                  hatAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.wingAvata cannot be set twice.");
                  }
                  _loc10_++;
                  wingAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.fashionArmAvata cannot be set twice.");
                  }
                  _loc8_++;
                  fashionArmAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.fashionClothAvata cannot be set twice.");
                  }
                  _loc11_++;
                  fashionClothAvata = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.teamId cannot be set twice.");
                  }
                  _loc15_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.id cannot be set twice.");
                  }
                  _loc9_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.readyScore cannot be set twice.");
                  }
                  _loc7_++;
                  readyScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.readyOrder cannot be set twice.");
                  }
                  _loc24_++;
                  readyOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.finalScore cannot be set twice.");
                  }
                  _loc14_++;
                  finalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.finalOrder cannot be set twice.");
                  }
                  _loc18_++;
                  finalOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.rank cannot be set twice.");
                  }
                  _loc5_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.uuid cannot be set twice.");
                  }
                  _loc16_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc19_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.userId cannot be set twice.");
                  }
                  _loc20_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GodsPlayerInfoMsg.headId cannot be set twice.");
                  }
                  _loc12_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc23_ & 7);
            }
         }
      }
   }
}

