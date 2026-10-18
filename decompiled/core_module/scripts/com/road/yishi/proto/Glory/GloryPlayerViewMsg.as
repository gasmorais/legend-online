package com.road.yishi.proto.Glory
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GloryPlayerViewMsg extends Message implements IExternalizable
   {
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var wing$field:String;
      
      private var hat$field:String;
      
      private var hideFashion$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var fashionArm$field:String;
      
      private var fashionCloth$field:String;
      
      private var isDragonTalker$field:Boolean;
      
      private var job$field:int;
      
      private var nickName$field:String;
      
      private var serverName$field:String;
      
      private var playerUid$field:int;
      
      private var fightCapacity$field:int;
      
      private var vipType$field:int;
      
      private var heroTempId$field:int;
      
      private var teamUid$field:String;
      
      public function GloryPlayerViewMsg()
      {
         super();
      }
      
      public function removeArm() : void
      {
         arm$field = null;
      }
      
      public function get hasArm() : Boolean
      {
         return arm$field != null;
      }
      
      public function set arm(param1:String) : void
      {
         arm$field = param1;
      }
      
      public function get arm() : String
      {
         return arm$field;
      }
      
      public function removeCloth() : void
      {
         cloth$field = null;
      }
      
      public function get hasCloth() : Boolean
      {
         return cloth$field != null;
      }
      
      public function set cloth(param1:String) : void
      {
         cloth$field = param1;
      }
      
      public function get cloth() : String
      {
         return cloth$field;
      }
      
      public function removeWing() : void
      {
         wing$field = null;
      }
      
      public function get hasWing() : Boolean
      {
         return wing$field != null;
      }
      
      public function set wing(param1:String) : void
      {
         wing$field = param1;
      }
      
      public function get wing() : String
      {
         return wing$field;
      }
      
      public function removeHat() : void
      {
         hat$field = null;
      }
      
      public function get hasHat() : Boolean
      {
         return hat$field != null;
      }
      
      public function set hat(param1:String) : void
      {
         hat$field = param1;
      }
      
      public function get hat() : String
      {
         return hat$field;
      }
      
      public function removeHideFashion() : void
      {
         hasField$0 &= 4294967294;
         hideFashion$field = new Boolean();
      }
      
      public function get hasHideFashion() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set hideFashion(param1:Boolean) : void
      {
         hasField$0 |= 1;
         hideFashion$field = param1;
      }
      
      public function get hideFashion() : Boolean
      {
         return hideFashion$field;
      }
      
      public function removeFashionArm() : void
      {
         fashionArm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashionArm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashionArm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashionArm$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashionCloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashionCloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashionCloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashionCloth$field;
      }
      
      public function removeIsDragonTalker() : void
      {
         hasField$0 &= 4294967293;
         isDragonTalker$field = new Boolean();
      }
      
      public function get hasIsDragonTalker() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isDragonTalker(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isDragonTalker$field = param1;
      }
      
      public function get isDragonTalker() : Boolean
      {
         return isDragonTalker$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967291;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 4;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
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
      
      public function removePlayerUid() : void
      {
         hasField$0 &= 4294967287;
         playerUid$field = new int();
      }
      
      public function get hasPlayerUid() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set playerUid(param1:int) : void
      {
         hasField$0 |= 8;
         playerUid$field = param1;
      }
      
      public function get playerUid() : int
      {
         return playerUid$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967279;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 16;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294967263;
         vipType$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 32;
         vipType$field = param1;
      }
      
      public function get vipType() : int
      {
         return vipType$field;
      }
      
      public function removeHeroTempId() : void
      {
         hasField$0 &= 4294967231;
         heroTempId$field = new int();
      }
      
      public function get hasHeroTempId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set heroTempId(param1:int) : void
      {
         hasField$0 |= 64;
         heroTempId$field = param1;
      }
      
      public function get heroTempId() : int
      {
         return heroTempId$field;
      }
      
      public function removeTeamUid() : void
      {
         teamUid$field = null;
      }
      
      public function get hasTeamUid() : Boolean
      {
         return teamUid$field != null;
      }
      
      public function set teamUid(param1:String) : void
      {
         teamUid$field = param1;
      }
      
      public function get teamUid() : String
      {
         return teamUid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasHideFashion)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,hideFashion$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasIsDragonTalker)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isDragonTalker$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasPlayerUid)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,playerUid$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,vipType$field);
         }
         if(hasHeroTempId)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,heroTempId$field);
         }
         if(hasTeamUid)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,teamUid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc13_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc18_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.arm cannot be set twice.");
                  }
                  _loc13_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.cloth cannot be set twice.");
                  }
                  _loc17_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.wing cannot be set twice.");
                  }
                  _loc14_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.hideFashion cannot be set twice.");
                  }
                  _loc15_++;
                  hideFashion = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.fashionArm cannot be set twice.");
                  }
                  _loc18_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.fashionCloth cannot be set twice.");
                  }
                  _loc4_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.isDragonTalker cannot be set twice.");
                  }
                  _loc8_++;
                  isDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.job cannot be set twice.");
                  }
                  _loc16_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.nickName cannot be set twice.");
                  }
                  _loc12_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.playerUid cannot be set twice.");
                  }
                  _loc7_++;
                  playerUid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.fightCapacity cannot be set twice.");
                  }
                  _loc6_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.vipType cannot be set twice.");
                  }
                  _loc11_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.heroTempId cannot be set twice.");
                  }
                  _loc9_++;
                  heroTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GloryPlayerViewMsg.teamUid cannot be set twice.");
                  }
                  _loc5_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

