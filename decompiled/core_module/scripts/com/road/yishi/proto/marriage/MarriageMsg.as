package com.road.yishi.proto.marriage
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var template_id$field:int;
      
      private var marriage_time$field:String;
      
      private var speTemplate_id$field:int;
      
      private var quest_count$field:int;
      
      private var nick_name$field:String;
      
      private var over_time$field:int;
      
      private var answer_num$field:int;
      
      private var logout_days$field:int;
      
      private var is_back_player_first_married$field:Boolean;
      
      public function MarriageMsg()
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
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967291;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 4;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeMarriageTime() : void
      {
         marriage_time$field = null;
      }
      
      public function get hasMarriageTime() : Boolean
      {
         return marriage_time$field != null;
      }
      
      public function set marriageTime(param1:String) : void
      {
         marriage_time$field = param1;
      }
      
      public function get marriageTime() : String
      {
         return marriage_time$field;
      }
      
      public function removeSpeTemplateId() : void
      {
         hasField$0 &= 4294967287;
         speTemplate_id$field = new int();
      }
      
      public function get hasSpeTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set speTemplateId(param1:int) : void
      {
         hasField$0 |= 8;
         speTemplate_id$field = param1;
      }
      
      public function get speTemplateId() : int
      {
         return speTemplate_id$field;
      }
      
      public function removeQuestCount() : void
      {
         hasField$0 &= 4294967279;
         quest_count$field = new int();
      }
      
      public function get hasQuestCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set questCount(param1:int) : void
      {
         hasField$0 |= 16;
         quest_count$field = param1;
      }
      
      public function get questCount() : int
      {
         return quest_count$field;
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
      
      public function removeOverTime() : void
      {
         hasField$0 &= 4294967263;
         over_time$field = new int();
      }
      
      public function get hasOverTime() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set overTime(param1:int) : void
      {
         hasField$0 |= 32;
         over_time$field = param1;
      }
      
      public function get overTime() : int
      {
         return over_time$field;
      }
      
      public function removeAnswerNum() : void
      {
         hasField$0 &= 4294967231;
         answer_num$field = new int();
      }
      
      public function get hasAnswerNum() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set answerNum(param1:int) : void
      {
         hasField$0 |= 64;
         answer_num$field = param1;
      }
      
      public function get answerNum() : int
      {
         return answer_num$field;
      }
      
      public function removeLogoutDays() : void
      {
         hasField$0 &= 4294967167;
         logout_days$field = new int();
      }
      
      public function get hasLogoutDays() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set logoutDays(param1:int) : void
      {
         hasField$0 |= 128;
         logout_days$field = param1;
      }
      
      public function get logoutDays() : int
      {
         return logout_days$field;
      }
      
      public function removeIsBackPlayerFirstMarried() : void
      {
         hasField$0 &= 4294967039;
         is_back_player_first_married$field = new Boolean();
      }
      
      public function get hasIsBackPlayerFirstMarried() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isBackPlayerFirstMarried(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_back_player_first_married$field = param1;
      }
      
      public function get isBackPlayerFirstMarried() : Boolean
      {
         return is_back_player_first_married$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasMarriageTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,marriage_time$field);
         }
         if(hasSpeTemplateId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,speTemplate_id$field);
         }
         if(hasQuestCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,quest_count$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasOverTime)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,over_time$field);
         }
         if(hasAnswerNum)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,answer_num$field);
         }
         if(hasLogoutDays)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,logout_days$field);
         }
         if(hasIsBackPlayerFirstMarried)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,is_back_player_first_married$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.state cannot be set twice.");
                  }
                  _loc11_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.templateId cannot be set twice.");
                  }
                  _loc12_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.marriageTime cannot be set twice.");
                  }
                  _loc8_++;
                  marriageTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.speTemplateId cannot be set twice.");
                  }
                  _loc5_++;
                  speTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.questCount cannot be set twice.");
                  }
                  _loc3_++;
                  questCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.nickName cannot be set twice.");
                  }
                  _loc6_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.overTime cannot be set twice.");
                  }
                  _loc9_++;
                  overTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.answerNum cannot be set twice.");
                  }
                  _loc7_++;
                  answerNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.logoutDays cannot be set twice.");
                  }
                  _loc14_++;
                  logoutDays = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageMsg.isBackPlayerFirstMarried cannot be set twice.");
                  }
                  _loc4_++;
                  isBackPlayerFirstMarried = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

