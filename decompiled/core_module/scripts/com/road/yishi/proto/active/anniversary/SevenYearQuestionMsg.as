package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SevenYearQuestionMsg extends Message implements IExternalizable
   {
      
      private var questionId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var options:Array = [];
      
      private var myAnswer$field:int;
      
      private var rightAnswer$field:int;
      
      private var cdTime$field:int;
      
      public function SevenYearQuestionMsg()
      {
         super();
      }
      
      public function removeQuestionId() : void
      {
         hasField$0 &= 4294967294;
         questionId$field = new int();
      }
      
      public function get hasQuestionId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set questionId(param1:int) : void
      {
         hasField$0 |= 1;
         questionId$field = param1;
      }
      
      public function get questionId() : int
      {
         return questionId$field;
      }
      
      public function removeMyAnswer() : void
      {
         hasField$0 &= 4294967293;
         myAnswer$field = new int();
      }
      
      public function get hasMyAnswer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set myAnswer(param1:int) : void
      {
         hasField$0 |= 2;
         myAnswer$field = param1;
      }
      
      public function get myAnswer() : int
      {
         return myAnswer$field;
      }
      
      public function removeRightAnswer() : void
      {
         hasField$0 &= 4294967291;
         rightAnswer$field = new int();
      }
      
      public function get hasRightAnswer() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rightAnswer(param1:int) : void
      {
         hasField$0 |= 4;
         rightAnswer$field = param1;
      }
      
      public function get rightAnswer() : int
      {
         return rightAnswer$field;
      }
      
      public function removeCdTime() : void
      {
         hasField$0 &= 4294967287;
         cdTime$field = new int();
      }
      
      public function get hasCdTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set cdTime(param1:int) : void
      {
         hasField$0 |= 8;
         cdTime$field = param1;
      }
      
      public function get cdTime() : int
      {
         return cdTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasQuestionId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,questionId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < options.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,options[_loc2_]);
            _loc2_++;
         }
         if(hasMyAnswer)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,myAnswer$field);
         }
         if(hasRightAnswer)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rightAnswer$field);
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cdTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearQuestionMsg.questionId cannot be set twice.");
                  }
                  _loc3_++;
                  questionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,options);
                  }
                  else
                  {
                     options.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearQuestionMsg.myAnswer cannot be set twice.");
                  }
                  _loc5_++;
                  myAnswer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearQuestionMsg.rightAnswer cannot be set twice.");
                  }
                  _loc7_++;
                  rightAnswer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SevenYearQuestionMsg.cdTime cannot be set twice.");
                  }
                  _loc4_++;
                  cdTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

