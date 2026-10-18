package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RuneResolveReqMsg extends Message implements IExternalizable
   {
      
      private var pos$field:String;
      
      public function RuneResolveReqMsg()
      {
         super();
      }
      
      public function removePos() : void
      {
         pos$field = null;
      }
      
      public function get hasPos() : Boolean
      {
         return pos$field != null;
      }
      
      public function set pos(param1:String) : void
      {
         pos$field = param1;
      }
      
      public function get pos() : String
      {
         return pos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPos)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,pos$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RuneResolveReqMsg.pos cannot be set twice.");
                  }
                  _loc3_++;
                  pos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

