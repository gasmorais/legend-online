package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LockScreenRspMsg extends Message implements IExternalizable
   {
      
      private var screen$field:String;
      
      private var frame$field:int;
      
      private var hasField$0:uint = 0;
      
      public function LockScreenRspMsg()
      {
         super();
      }
      
      public function removeScreen() : void
      {
         screen$field = null;
      }
      
      public function get hasScreen() : Boolean
      {
         return screen$field != null;
      }
      
      public function set screen(param1:String) : void
      {
         screen$field = param1;
      }
      
      public function get screen() : String
      {
         return screen$field;
      }
      
      public function removeFrame() : void
      {
         hasField$0 &= 4294967294;
         frame$field = new int();
      }
      
      public function get hasFrame() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set frame(param1:int) : void
      {
         hasField$0 |= 1;
         frame$field = param1;
      }
      
      public function get frame() : int
      {
         return frame$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasScreen)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,screen$field);
         }
         if(hasFrame)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,frame$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LockScreenRspMsg.screen cannot be set twice.");
                  }
                  _loc4_++;
                  screen = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LockScreenRspMsg.frame cannot be set twice.");
                  }
                  _loc3_++;
                  frame = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

