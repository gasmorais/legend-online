package com.road.yishi.proto.answerquestion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class playeranswerquestionMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curOrder$field:int;
      
      private var currentScore$field:int;
      
      private var getEXP$field:int;
      
      private var playerAnswerSucCount$field:int;
      
      private var doubleBlessCount$field:int;
      
      private var wisdomHeartCount$field:int;
      
      private var choiceEyesCount$field:int;
      
      private var extraEXP$field:int;
      
      private var go_date$field:String;
      
      public function playeranswerquestionMsg()
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
      
      public function removeCurOrder() : void
      {
         hasField$0 &= 4294967293;
         curOrder$field = new int();
      }
      
      public function get hasCurOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curOrder(param1:int) : void
      {
         hasField$0 |= 2;
         curOrder$field = param1;
      }
      
      public function get curOrder() : int
      {
         return curOrder$field;
      }
      
      public function removeCurrentScore() : void
      {
         hasField$0 &= 4294967291;
         currentScore$field = new int();
      }
      
      public function get hasCurrentScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set currentScore(param1:int) : void
      {
         hasField$0 |= 4;
         currentScore$field = param1;
      }
      
      public function get currentScore() : int
      {
         return currentScore$field;
      }
      
      public function removeGetEXP() : void
      {
         hasField$0 &= 4294967287;
         getEXP$field = new int();
      }
      
      public function get hasGetEXP() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set getEXP(param1:int) : void
      {
         hasField$0 |= 8;
         getEXP$field = param1;
      }
      
      public function get getEXP() : int
      {
         return getEXP$field;
      }
      
      public function removePlayerAnswerSucCount() : void
      {
         hasField$0 &= 4294967279;
         playerAnswerSucCount$field = new int();
      }
      
      public function get hasPlayerAnswerSucCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set playerAnswerSucCount(param1:int) : void
      {
         hasField$0 |= 16;
         playerAnswerSucCount$field = param1;
      }
      
      public function get playerAnswerSucCount() : int
      {
         return playerAnswerSucCount$field;
      }
      
      public function removeDoubleBlessCount() : void
      {
         hasField$0 &= 4294967263;
         doubleBlessCount$field = new int();
      }
      
      public function get hasDoubleBlessCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set doubleBlessCount(param1:int) : void
      {
         hasField$0 |= 32;
         doubleBlessCount$field = param1;
      }
      
      public function get doubleBlessCount() : int
      {
         return doubleBlessCount$field;
      }
      
      public function removeWisdomHeartCount() : void
      {
         hasField$0 &= 4294967231;
         wisdomHeartCount$field = new int();
      }
      
      public function get hasWisdomHeartCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set wisdomHeartCount(param1:int) : void
      {
         hasField$0 |= 64;
         wisdomHeartCount$field = param1;
      }
      
      public function get wisdomHeartCount() : int
      {
         return wisdomHeartCount$field;
      }
      
      public function removeChoiceEyesCount() : void
      {
         hasField$0 &= 4294967167;
         choiceEyesCount$field = new int();
      }
      
      public function get hasChoiceEyesCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set choiceEyesCount(param1:int) : void
      {
         hasField$0 |= 128;
         choiceEyesCount$field = param1;
      }
      
      public function get choiceEyesCount() : int
      {
         return choiceEyesCount$field;
      }
      
      public function removeExtraEXP() : void
      {
         hasField$0 &= 4294967039;
         extraEXP$field = new int();
      }
      
      public function get hasExtraEXP() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set extraEXP(param1:int) : void
      {
         hasField$0 |= 256;
         extraEXP$field = param1;
      }
      
      public function get extraEXP() : int
      {
         return extraEXP$field;
      }
      
      public function removeGoDate() : void
      {
         go_date$field = null;
      }
      
      public function get hasGoDate() : Boolean
      {
         return go_date$field != null;
      }
      
      public function set goDate(param1:String) : void
      {
         go_date$field = param1;
      }
      
      public function get goDate() : String
      {
         return go_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasCurOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curOrder$field);
         }
         if(hasCurrentScore)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,currentScore$field);
         }
         if(hasGetEXP)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,getEXP$field);
         }
         if(hasPlayerAnswerSucCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,playerAnswerSucCount$field);
         }
         if(hasDoubleBlessCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,doubleBlessCount$field);
         }
         if(hasWisdomHeartCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,wisdomHeartCount$field);
         }
         if(hasChoiceEyesCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,choiceEyesCount$field);
         }
         if(hasExtraEXP)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,extraEXP$field);
         }
         if(hasGoDate)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,go_date$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.userId cannot be set twice.");
                  }
                  _loc11_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.curOrder cannot be set twice.");
                  }
                  _loc3_++;
                  curOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.currentScore cannot be set twice.");
                  }
                  _loc5_++;
                  currentScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.getEXP cannot be set twice.");
                  }
                  _loc7_++;
                  getEXP = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.playerAnswerSucCount cannot be set twice.");
                  }
                  _loc9_++;
                  playerAnswerSucCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.doubleBlessCount cannot be set twice.");
                  }
                  _loc10_++;
                  doubleBlessCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.wisdomHeartCount cannot be set twice.");
                  }
                  _loc6_++;
                  wisdomHeartCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.choiceEyesCount cannot be set twice.");
                  }
                  _loc4_++;
                  choiceEyesCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.extraEXP cannot be set twice.");
                  }
                  _loc8_++;
                  extraEXP = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: playeranswerquestionMsg.goDate cannot be set twice.");
                  }
                  _loc13_++;
                  goDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

