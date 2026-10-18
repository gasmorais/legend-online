package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NoteInfo extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var content$field:String;
      
      private var praiseNmuber$field:int;
      
      public function NoteInfo()
      {
         super();
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
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
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
      
      public function removePraiseNmuber() : void
      {
         hasField$0 &= 4294967293;
         praiseNmuber$field = new int();
      }
      
      public function get hasPraiseNmuber() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set praiseNmuber(param1:int) : void
      {
         hasField$0 |= 2;
         praiseNmuber$field = param1;
      }
      
      public function get praiseNmuber() : int
      {
         return praiseNmuber$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasContent)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,content$field);
         }
         if(hasPraiseNmuber)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,praiseNmuber$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: NoteInfo.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NoteInfo.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NoteInfo.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NoteInfo.content cannot be set twice.");
                  }
                  _loc4_++;
                  content = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NoteInfo.praiseNmuber cannot be set twice.");
                  }
                  _loc6_++;
                  praiseNmuber = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

