package com.road.yishi.proto.christmas
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChristmasAnswersMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var topicId$field:int;
      
      private var surplusSeconds$field:int;
      
      private var choiceNum$field:int;
      
      private var choiceRightNum$field:int;
      
      private var optionANum$field:int;
      
      private var optionBNum$field:int;
      
      private var myOption$field:int;
      
      private var rewardInfo$field:String;
      
      private var answerCorrectNum$field:int;
      
      public function ChristmasAnswersMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeTopicId() : void
      {
         hasField$0 &= 4294967293;
         topicId$field = new int();
      }
      
      public function get hasTopicId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set topicId(param1:int) : void
      {
         hasField$0 |= 2;
         topicId$field = param1;
      }
      
      public function get topicId() : int
      {
         return topicId$field;
      }
      
      public function removeSurplusSeconds() : void
      {
         hasField$0 &= 4294967291;
         surplusSeconds$field = new int();
      }
      
      public function get hasSurplusSeconds() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set surplusSeconds(param1:int) : void
      {
         hasField$0 |= 4;
         surplusSeconds$field = param1;
      }
      
      public function get surplusSeconds() : int
      {
         return surplusSeconds$field;
      }
      
      public function removeChoiceNum() : void
      {
         hasField$0 &= 4294967287;
         choiceNum$field = new int();
      }
      
      public function get hasChoiceNum() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set choiceNum(param1:int) : void
      {
         hasField$0 |= 8;
         choiceNum$field = param1;
      }
      
      public function get choiceNum() : int
      {
         return choiceNum$field;
      }
      
      public function removeChoiceRightNum() : void
      {
         hasField$0 &= 4294967279;
         choiceRightNum$field = new int();
      }
      
      public function get hasChoiceRightNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set choiceRightNum(param1:int) : void
      {
         hasField$0 |= 16;
         choiceRightNum$field = param1;
      }
      
      public function get choiceRightNum() : int
      {
         return choiceRightNum$field;
      }
      
      public function removeOptionANum() : void
      {
         hasField$0 &= 4294967263;
         optionANum$field = new int();
      }
      
      public function get hasOptionANum() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set optionANum(param1:int) : void
      {
         hasField$0 |= 32;
         optionANum$field = param1;
      }
      
      public function get optionANum() : int
      {
         return optionANum$field;
      }
      
      public function removeOptionBNum() : void
      {
         hasField$0 &= 4294967231;
         optionBNum$field = new int();
      }
      
      public function get hasOptionBNum() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set optionBNum(param1:int) : void
      {
         hasField$0 |= 64;
         optionBNum$field = param1;
      }
      
      public function get optionBNum() : int
      {
         return optionBNum$field;
      }
      
      public function removeMyOption() : void
      {
         hasField$0 &= 4294967167;
         myOption$field = new int();
      }
      
      public function get hasMyOption() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set myOption(param1:int) : void
      {
         hasField$0 |= 128;
         myOption$field = param1;
      }
      
      public function get myOption() : int
      {
         return myOption$field;
      }
      
      public function removeRewardInfo() : void
      {
         rewardInfo$field = null;
      }
      
      public function get hasRewardInfo() : Boolean
      {
         return rewardInfo$field != null;
      }
      
      public function set rewardInfo(param1:String) : void
      {
         rewardInfo$field = param1;
      }
      
      public function get rewardInfo() : String
      {
         return rewardInfo$field;
      }
      
      public function removeAnswerCorrectNum() : void
      {
         hasField$0 &= 4294967039;
         answerCorrectNum$field = new int();
      }
      
      public function get hasAnswerCorrectNum() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set answerCorrectNum(param1:int) : void
      {
         hasField$0 |= 256;
         answerCorrectNum$field = param1;
      }
      
      public function get answerCorrectNum() : int
      {
         return answerCorrectNum$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasTopicId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,topicId$field);
         }
         if(hasSurplusSeconds)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,surplusSeconds$field);
         }
         if(hasChoiceNum)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,choiceNum$field);
         }
         if(hasChoiceRightNum)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,choiceRightNum$field);
         }
         if(hasOptionANum)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,optionANum$field);
         }
         if(hasOptionBNum)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,optionBNum$field);
         }
         if(hasMyOption)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,myOption$field);
         }
         if(hasRewardInfo)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,rewardInfo$field);
         }
         if(hasAnswerCorrectNum)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,answerCorrectNum$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.opType cannot be set twice.");
                  }
                  _loc9_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.topicId cannot be set twice.");
                  }
                  _loc7_++;
                  topicId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.surplusSeconds cannot be set twice.");
                  }
                  _loc3_++;
                  surplusSeconds = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.choiceNum cannot be set twice.");
                  }
                  _loc11_++;
                  choiceNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.choiceRightNum cannot be set twice.");
                  }
                  _loc6_++;
                  choiceRightNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.optionANum cannot be set twice.");
                  }
                  _loc5_++;
                  optionANum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.optionBNum cannot be set twice.");
                  }
                  _loc8_++;
                  optionBNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.myOption cannot be set twice.");
                  }
                  _loc10_++;
                  myOption = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.rewardInfo cannot be set twice.");
                  }
                  _loc4_++;
                  rewardInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChristmasAnswersMsg.answerCorrectNum cannot be set twice.");
                  }
                  _loc13_++;
                  answerCorrectNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

