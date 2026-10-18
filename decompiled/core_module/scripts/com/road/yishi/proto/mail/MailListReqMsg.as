package com.road.yishi.proto.mail
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MailListReqMsg extends Message implements IExternalizable
   {
      
      private var mail_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var req_type$field:int;
      
      public function MailListReqMsg()
      {
         super();
      }
      
      public function removeMailId() : void
      {
         hasField$0 &= 4294967294;
         mail_id$field = new int();
      }
      
      public function get hasMailId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mailId(param1:int) : void
      {
         hasField$0 |= 1;
         mail_id$field = param1;
      }
      
      public function get mailId() : int
      {
         return mail_id$field;
      }
      
      public function removeReqType() : void
      {
         hasField$0 &= 4294967293;
         req_type$field = new int();
      }
      
      public function get hasReqType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set reqType(param1:int) : void
      {
         hasField$0 |= 2;
         req_type$field = param1;
      }
      
      public function get reqType() : int
      {
         return req_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMailId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mail_id$field);
         }
         if(hasReqType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,req_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MailListReqMsg.mailId cannot be set twice.");
                  }
                  _loc3_++;
                  mailId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MailListReqMsg.reqType cannot be set twice.");
                  }
                  _loc4_++;
                  reqType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

