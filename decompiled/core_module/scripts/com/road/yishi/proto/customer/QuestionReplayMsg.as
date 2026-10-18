package com.road.yishi.proto.customer
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class QuestionReplayMsg extends Message implements IExternalizable
   {
      
      private var question_id$field:String;
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var title$field:String;
      
      private var content$field:String;
      
      private var replay_content$field:String;
      
      private var commit_time$field:ByteArray;
      
      private var replay_user_name$field:String;
      
      private var employ$field:int;
      
      private var stop_reply$field:int;
      
      public function QuestionReplayMsg()
      {
         super();
      }
      
      public function removeQuestionId() : void
      {
         question_id$field = null;
      }
      
      public function get hasQuestionId() : Boolean
      {
         return question_id$field != null;
      }
      
      public function set questionId(param1:String) : void
      {
         question_id$field = param1;
      }
      
      public function get questionId() : String
      {
         return question_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeTitle() : void
      {
         title$field = null;
      }
      
      public function get hasTitle() : Boolean
      {
         return title$field != null;
      }
      
      public function set title(param1:String) : void
      {
         title$field = param1;
      }
      
      public function get title() : String
      {
         return title$field;
      }
      
      public function removeContent() : void
      {
         content$field = null;
      }
      
      public function get hasContent() : Boolean
      {
         return content$field != null;
      }
      
      public function set content(param1:String) : void
      {
         content$field = param1;
      }
      
      public function get content() : String
      {
         return content$field;
      }
      
      public function removeReplayContent() : void
      {
         replay_content$field = null;
      }
      
      public function get hasReplayContent() : Boolean
      {
         return replay_content$field != null;
      }
      
      public function set replayContent(param1:String) : void
      {
         replay_content$field = param1;
      }
      
      public function get replayContent() : String
      {
         return replay_content$field;
      }
      
      public function removeCommitTime() : void
      {
         commit_time$field = null;
      }
      
      public function get hasCommitTime() : Boolean
      {
         return commit_time$field != null;
      }
      
      public function set commitTime(param1:ByteArray) : void
      {
         commit_time$field = param1;
      }
      
      public function get commitTime() : ByteArray
      {
         return commit_time$field;
      }
      
      public function removeReplayUserName() : void
      {
         replay_user_name$field = null;
      }
      
      public function get hasReplayUserName() : Boolean
      {
         return replay_user_name$field != null;
      }
      
      public function set replayUserName(param1:String) : void
      {
         replay_user_name$field = param1;
      }
      
      public function get replayUserName() : String
      {
         return replay_user_name$field;
      }
      
      public function removeEmploy() : void
      {
         hasField$0 &= 4294967291;
         employ$field = new int();
      }
      
      public function get hasEmploy() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set employ(param1:int) : void
      {
         hasField$0 |= 4;
         employ$field = param1;
      }
      
      public function get employ() : int
      {
         return employ$field;
      }
      
      public function removeStopReply() : void
      {
         hasField$0 &= 4294967287;
         stop_reply$field = new int();
      }
      
      public function get hasStopReply() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set stopReply(param1:int) : void
      {
         hasField$0 |= 8;
         stop_reply$field = param1;
      }
      
      public function get stopReply() : int
      {
         return stop_reply$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasQuestionId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,question_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasTitle)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,title$field);
         }
         if(hasContent)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,content$field);
         }
         if(hasReplayContent)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,replay_content$field);
         }
         if(hasCommitTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_BYTES(param1,commit_time$field);
         }
         if(hasReplayUserName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,replay_user_name$field);
         }
         if(hasEmploy)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,employ$field);
         }
         if(hasStopReply)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,stop_reply$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.questionId cannot be set twice.");
                  }
                  _loc6_++;
                  questionId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.title cannot be set twice.");
                  }
                  _loc7_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.content cannot be set twice.");
                  }
                  _loc3_++;
                  content = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.replayContent cannot be set twice.");
                  }
                  _loc11_++;
                  replayContent = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.commitTime cannot be set twice.");
                  }
                  _loc4_++;
                  commitTime = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.replayUserName cannot be set twice.");
                  }
                  _loc8_++;
                  replayUserName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.employ cannot be set twice.");
                  }
                  _loc10_++;
                  employ = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: QuestionReplayMsg.stopReply cannot be set twice.");
                  }
                  _loc13_++;
                  stopReply = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

