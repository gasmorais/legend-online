package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TeamPlayerMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var fight_power$field:int;
      
      private var grade$field:int;
      
      private var ready_state$field:int;
      
      private var team$field:int;
      
      private var pos$field:int;
      
      private var consortia_name$field:String;
      
      private var job$field:int;
      
      private var fight_pos$field:int;
      
      private var head_id$field:int;
      
      private var is_online$field:Boolean;
      
      private var templateid$field:int;
      
      private var isNoGet$field:Boolean;
      
      public function TeamPlayerMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967293;
         fight_power$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 2;
         fight_power$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fight_power$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967291;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 4;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeReadyState() : void
      {
         hasField$0 &= 4294967287;
         ready_state$field = new int();
      }
      
      public function get hasReadyState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set readyState(param1:int) : void
      {
         hasField$0 |= 8;
         ready_state$field = param1;
      }
      
      public function get readyState() : int
      {
         return ready_state$field;
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
      
      public function removePos() : void
      {
         hasField$0 &= 4294967263;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 32;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967231;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 64;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeFightPos() : void
      {
         hasField$0 &= 4294967167;
         fight_pos$field = new int();
      }
      
      public function get hasFightPos() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fightPos(param1:int) : void
      {
         hasField$0 |= 128;
         fight_pos$field = param1;
      }
      
      public function get fightPos() : int
      {
         return fight_pos$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967039;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 256;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeIsOnline() : void
      {
         hasField$0 &= 4294966783;
         is_online$field = new Boolean();
      }
      
      public function get hasIsOnline() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isOnline(param1:Boolean) : void
      {
         hasField$0 |= 512;
         is_online$field = param1;
      }
      
      public function get isOnline() : Boolean
      {
         return is_online$field;
      }
      
      public function removeTemplateid() : void
      {
         hasField$0 &= 4294966271;
         templateid$field = new int();
      }
      
      public function get hasTemplateid() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set templateid(param1:int) : void
      {
         hasField$0 |= 1024;
         templateid$field = param1;
      }
      
      public function get templateid() : int
      {
         return templateid$field;
      }
      
      public function removeIsNoGet() : void
      {
         hasField$0 &= 4294965247;
         isNoGet$field = new Boolean();
      }
      
      public function get hasIsNoGet() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isNoGet(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         isNoGet$field = param1;
      }
      
      public function get isNoGet() : Boolean
      {
         return isNoGet$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fight_power$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasReadyState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,ready_state$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,team$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasFightPos)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,fight_pos$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         if(hasIsOnline)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,is_online$field);
         }
         if(hasTemplateid)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,templateid$field);
         }
         if(hasIsNoGet)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,isNoGet$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.userId cannot be set twice.");
                  }
                  _loc13_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.fightPower cannot be set twice.");
                  }
                  _loc14_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.readyState cannot be set twice.");
                  }
                  _loc10_++;
                  readyState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.team cannot be set twice.");
                  }
                  _loc17_++;
                  team = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.pos cannot be set twice.");
                  }
                  _loc6_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.job cannot be set twice.");
                  }
                  _loc12_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.fightPos cannot be set twice.");
                  }
                  _loc9_++;
                  fightPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.headId cannot be set twice.");
                  }
                  _loc7_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.isOnline cannot be set twice.");
                  }
                  _loc11_++;
                  isOnline = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.templateid cannot be set twice.");
                  }
                  _loc8_++;
                  templateid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TeamPlayerMsg.isNoGet cannot be set twice.");
                  }
                  _loc16_++;
                  isNoGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

