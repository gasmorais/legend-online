package com.road.yishi.proto.mail
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MailSendReqMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var receiverUserId:Array = [];
      
      private var title$field:String;
      
      private var contents$field:String;
      
      private var send_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      public function MailSendReqMsg()
      {
         super();
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
      
      public function removeContents() : void
      {
         contents$field = null;
      }
      
      public function get hasContents() : Boolean
      {
         return contents$field != null;
      }
      
      public function set contents(param1:String) : void
      {
         contents$field = param1;
      }
      
      public function get contents() : String
      {
         return contents$field;
      }
      
      public function removeSendType() : void
      {
         hasField$0 &= 4294967294;
         send_type$field = new int();
      }
      
      public function get hasSendType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set sendType(param1:int) : void
      {
         hasField$0 |= 1;
         send_type$field = param1;
      }
      
      public function get sendType() : int
      {
         return send_type$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < receiverUserId.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,receiverUserId[_loc2_]);
            _loc2_++;
         }
         if(hasTitle)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,title$field);
         }
         if(hasContents)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,contents$field);
         }
         if(hasSendType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,send_type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,receiverUserId);
                  }
                  else
                  {
                     receiverUserId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MailSendReqMsg.title cannot be set twice.");
                  }
                  _loc7_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MailSendReqMsg.contents cannot be set twice.");
                  }
                  _loc3_++;
                  contents = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MailSendReqMsg.sendType cannot be set twice.");
                  }
                  _loc4_++;
                  sendType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MailSendReqMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

