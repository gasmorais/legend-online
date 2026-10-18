package com.road.yishi.proto.friend
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GlobalImMsg extends Message implements IExternalizable
   {
      
      private var from$field:SimpleGlobalPlayerMsg;
      
      private var from_channel$field:int;
      
      private var hasField$0:uint = 0;
      
      private var target$field:String;
      
      private var msg$field:String;
      
      private var send_date$field:Int64;
      
      public function GlobalImMsg()
      {
         super();
      }
      
      public function removeFrom() : void
      {
         from$field = null;
      }
      
      public function get hasFrom() : Boolean
      {
         return from$field != null;
      }
      
      public function set from(param1:SimpleGlobalPlayerMsg) : void
      {
         from$field = param1;
      }
      
      public function get from() : SimpleGlobalPlayerMsg
      {
         return from$field;
      }
      
      public function removeFromChannel() : void
      {
         hasField$0 &= 4294967294;
         from_channel$field = new int();
      }
      
      public function get hasFromChannel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fromChannel(param1:int) : void
      {
         hasField$0 |= 1;
         from_channel$field = param1;
      }
      
      public function get fromChannel() : int
      {
         return from_channel$field;
      }
      
      public function removeTarget() : void
      {
         target$field = null;
      }
      
      public function get hasTarget() : Boolean
      {
         return target$field != null;
      }
      
      public function set target(param1:String) : void
      {
         target$field = param1;
      }
      
      public function get target() : String
      {
         return target$field;
      }
      
      public function removeMsg() : void
      {
         msg$field = null;
      }
      
      public function get hasMsg() : Boolean
      {
         return msg$field != null;
      }
      
      public function set msg(param1:String) : void
      {
         msg$field = param1;
      }
      
      public function get msg() : String
      {
         return msg$field;
      }
      
      public function removeSendDate() : void
      {
         send_date$field = null;
      }
      
      public function get hasSendDate() : Boolean
      {
         return send_date$field != null;
      }
      
      public function set sendDate(param1:Int64) : void
      {
         send_date$field = param1;
      }
      
      public function get sendDate() : Int64
      {
         return send_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFrom)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,from$field);
         }
         if(hasFromChannel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_ENUM(param1,from_channel$field);
         }
         if(hasTarget)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,target$field);
         }
         if(hasMsg)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,msg$field);
         }
         if(hasSendDate)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,send_date$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GlobalImMsg.from cannot be set twice.");
                  }
                  _loc6_++;
                  from = new SimpleGlobalPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,from);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GlobalImMsg.fromChannel cannot be set twice.");
                  }
                  _loc4_++;
                  fromChannel = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GlobalImMsg.target cannot be set twice.");
                  }
                  _loc8_++;
                  target = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GlobalImMsg.msg cannot be set twice.");
                  }
                  _loc7_++;
                  msg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GlobalImMsg.sendDate cannot be set twice.");
                  }
                  _loc3_++;
                  sendDate = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

