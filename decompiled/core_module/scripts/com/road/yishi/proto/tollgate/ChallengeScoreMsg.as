package com.road.yishi.proto.tollgate
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChallengeScoreMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tollgate_id$field:int;
      
      private var score$field:int;
      
      private var order$field:int;
      
      private var is_lucky$field:Boolean;
      
      private var nick_name$field:String;
      
      private var is_vip$field:Boolean;
      
      private var grade$field:int;
      
      private var consortia_name$field:String;
      
      private var fight_capacity$field:int;
      
      public function ChallengeScoreMsg()
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
      
      public function removeTollgateId() : void
      {
         hasField$0 &= 4294967293;
         tollgate_id$field = new int();
      }
      
      public function get hasTollgateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tollgateId(param1:int) : void
      {
         hasField$0 |= 2;
         tollgate_id$field = param1;
      }
      
      public function get tollgateId() : int
      {
         return tollgate_id$field;
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
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967287;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 8;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeIsLucky() : void
      {
         hasField$0 &= 4294967279;
         is_lucky$field = new Boolean();
      }
      
      public function get hasIsLucky() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isLucky(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_lucky$field = param1;
      }
      
      public function get isLucky() : Boolean
      {
         return is_lucky$field;
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
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294967263;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 32;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967231;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 64;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
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
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967167;
         fight_capacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 128;
         fight_capacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fight_capacity$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasTollgateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tollgate_id$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasIsLucky)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_lucky$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.tollgateId cannot be set twice.");
                  }
                  _loc13_++;
                  tollgateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.score cannot be set twice.");
                  }
                  _loc11_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.order cannot be set twice.");
                  }
                  _loc7_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.isLucky cannot be set twice.");
                  }
                  _loc8_++;
                  isLucky = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.isVip cannot be set twice.");
                  }
                  _loc4_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.consortiaName cannot be set twice.");
                  }
                  _loc6_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeScoreMsg.fightCapacity cannot be set twice.");
                  }
                  _loc12_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

