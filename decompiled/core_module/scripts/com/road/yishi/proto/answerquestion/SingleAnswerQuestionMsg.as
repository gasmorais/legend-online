package com.road.yishi.proto.answerquestion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SingleAnswerQuestionMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var question$field:String;
      
      private var option1$field:String;
      
      private var option2$field:String;
      
      private var result$field:int;
      
      private var time$field:String;
      
      public function SingleAnswerQuestionMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeQuestion() : void
      {
         question$field = null;
      }
      
      public function get hasQuestion() : Boolean
      {
         return question$field != null;
      }
      
      public function set question(param1:String) : void
      {
         question$field = param1;
      }
      
      public function get question() : String
      {
         return question$field;
      }
      
      public function removeOption1() : void
      {
         option1$field = null;
      }
      
      public function get hasOption1() : Boolean
      {
         return option1$field != null;
      }
      
      public function set option1(param1:String) : void
      {
         option1$field = param1;
      }
      
      public function get option1() : String
      {
         return option1$field;
      }
      
      public function removeOption2() : void
      {
         option2$field = null;
      }
      
      public function get hasOption2() : Boolean
      {
         return option2$field != null;
      }
      
      public function set option2(param1:String) : void
      {
         option2$field = param1;
      }
      
      public function get option2() : String
      {
         return option2$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967293;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 2;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeTime() : void
      {
         time$field = null;
      }
      
      public function get hasTime() : Boolean
      {
         return time$field != null;
      }
      
      public function set time(param1:String) : void
      {
         time$field = param1;
      }
      
      public function get time() : String
      {
         return time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasQuestion)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,question$field);
         }
         if(hasOption1)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,option1$field);
         }
         if(hasOption2)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,option2$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SingleAnswerQuestionMsg.id cannot be set twice.");
                  }
                  _loc3_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SingleAnswerQuestionMsg.question cannot be set twice.");
                  }
                  _loc4_++;
                  question = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SingleAnswerQuestionMsg.option1 cannot be set twice.");
                  }
                  _loc5_++;
                  option1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SingleAnswerQuestionMsg.option2 cannot be set twice.");
                  }
                  _loc7_++;
                  option2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SingleAnswerQuestionMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SingleAnswerQuestionMsg.time cannot be set twice.");
                  }
                  _loc9_++;
                  time = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

