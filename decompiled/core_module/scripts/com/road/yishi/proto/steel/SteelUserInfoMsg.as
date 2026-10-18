package com.road.yishi.proto.steel
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SteelUserInfoMsg extends Message implements IExternalizable
   {
      
      private var teamUid$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var grades$field:int;
      
      private var job$field:int;
      
      private var fightPower$field:int;
      
      private var hostPlayer$field:int;
      
      private var isEnter$field:int;
      
      private var isExist$field:Boolean;
      
      private var property1$field:String;
      
      private var property2$field:String;
      
      private var isOnline$field:Boolean;
      
      public function SteelUserInfoMsg()
      {
         super();
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
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967293;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 2;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
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
      
      public function removeHostPlayer() : void
      {
         hasField$0 &= 4294967279;
         hostPlayer$field = new int();
      }
      
      public function get hasHostPlayer() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set hostPlayer(param1:int) : void
      {
         hasField$0 |= 16;
         hostPlayer$field = param1;
      }
      
      public function get hostPlayer() : int
      {
         return hostPlayer$field;
      }
      
      public function removeIsEnter() : void
      {
         hasField$0 &= 4294967263;
         isEnter$field = new int();
      }
      
      public function get hasIsEnter() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isEnter(param1:int) : void
      {
         hasField$0 |= 32;
         isEnter$field = param1;
      }
      
      public function get isEnter() : int
      {
         return isEnter$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967231;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
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
      
      public function removeIsOnline() : void
      {
         hasField$0 &= 4294967167;
         isOnline$field = new Boolean();
      }
      
      public function get hasIsOnline() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isOnline(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isOnline$field = param1;
      }
      
      public function get isOnline() : Boolean
      {
         return isOnline$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeamUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,teamUid$field);
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
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasHostPlayer)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,hostPlayer$field);
         }
         if(hasIsEnter)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,isEnter$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         if(hasIsOnline)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isOnline$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.teamUid cannot be set twice.");
                  }
                  _loc3_++;
                  teamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.nickName cannot be set twice.");
                  }
                  _loc10_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.grades cannot be set twice.");
                  }
                  _loc14_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.job cannot be set twice.");
                  }
                  _loc12_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.hostPlayer cannot be set twice.");
                  }
                  _loc9_++;
                  hostPlayer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.isEnter cannot be set twice.");
                  }
                  _loc7_++;
                  isEnter = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.isExist cannot be set twice.");
                  }
                  _loc5_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.property1 cannot be set twice.");
                  }
                  _loc11_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.property2 cannot be set twice.");
                  }
                  _loc15_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SteelUserInfoMsg.isOnline cannot be set twice.");
                  }
                  _loc8_++;
                  isOnline = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

