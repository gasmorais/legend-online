package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class InfoRspMsg extends Message implements IExternalizable
   {
      
      private var info$field:SimplePlayerInfoMsg;
      
      private var from$field:int;
      
      private var hasField$0:uint = 0;
      
      public function InfoRspMsg()
      {
         super();
      }
      
      public function removeInfo() : void
      {
         info$field = null;
      }
      
      public function get hasInfo() : Boolean
      {
         return info$field != null;
      }
      
      public function set info(param1:SimplePlayerInfoMsg) : void
      {
         info$field = param1;
      }
      
      public function get info() : SimplePlayerInfoMsg
      {
         return info$field;
      }
      
      public function removeFrom() : void
      {
         hasField$0 &= 4294967294;
         from$field = new int();
      }
      
      public function get hasFrom() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set from(param1:int) : void
      {
         hasField$0 |= 1;
         from$field = param1;
      }
      
      public function get from() : int
      {
         return from$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info$field);
         }
         if(hasFrom)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,from$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: InfoRspMsg.info cannot be set twice.");
                  }
                  _loc3_++;
                  info = new SimplePlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,info);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: InfoRspMsg.from cannot be set twice.");
                  }
                  _loc5_++;
                  from = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

