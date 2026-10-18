package com.road.yishi.proto.answerquestion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class singleranswerquestionMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var question$field:String;
      
      private var option1$field:String;
      
      private var option2$field:String;
      
      private var option3$field:String;
      
      private var option4$field:String;
      
      private var answer$field:int;
      
      public function singleranswerquestionMsg()
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
      
      public function removeOption3() : void
      {
         option3$field = null;
      }
      
      public function get hasOption3() : Boolean
      {
         return option3$field != null;
      }
      
      public function set option3(param1:String) : void
      {
         option3$field = param1;
      }
      
      public function get option3() : String
      {
         return option3$field;
      }
      
      public function removeOption4() : void
      {
         option4$field = null;
      }
      
      public function get hasOption4() : Boolean
      {
         return option4$field != null;
      }
      
      public function set option4(param1:String) : void
      {
         option4$field = param1;
      }
      
      public function get option4() : String
      {
         return option4$field;
      }
      
      public function removeAnswer() : void
      {
         hasField$0 &= 4294967293;
         answer$field = new int();
      }
      
      public function get hasAnswer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set answer(param1:int) : void
      {
         hasField$0 |= 2;
         answer$field = param1;
      }
      
      public function get answer() : int
      {
         return answer$field;
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
         if(hasOption3)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,option3$field);
         }
         if(hasOption4)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,option4$field);
         }
         if(hasAnswer)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,answer$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: singleranswerquestionMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: singleranswerquestionMsg.question cannot be set twice.");
                  }
                  _loc6_++;
                  question = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: singleranswerquestionMsg.option1 cannot be set twice.");
                  }
                  _loc7_++;
                  option1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: singleranswerquestionMsg.option2 cannot be set twice.");
                  }
                  _loc8_++;
                  option2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: singleranswerquestionMsg.option3 cannot be set twice.");
                  }
                  _loc3_++;
                  option3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: singleranswerquestionMsg.option4 cannot be set twice.");
                  }
                  _loc4_++;
                  option4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: singleranswerquestionMsg.answer cannot be set twice.");
                  }
                  _loc10_++;
                  answer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

