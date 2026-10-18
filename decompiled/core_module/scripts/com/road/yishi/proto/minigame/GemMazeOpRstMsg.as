package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GemMazeOpRstMsg extends Message implements IExternalizable
   {
      
      private var rstCode$field:int;
      
      private var hasField$0:uint = 0;
      
      public function GemMazeOpRstMsg()
      {
         super();
      }
      
      public function removeRstCode() : void
      {
         hasField$0 &= 4294967294;
         rstCode$field = new int();
      }
      
      public function get hasRstCode() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rstCode(param1:int) : void
      {
         hasField$0 |= 1;
         rstCode$field = param1;
      }
      
      public function get rstCode() : int
      {
         return rstCode$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRstCode)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rstCode$field);
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
                     throw new IOError("Bad data format: GemMazeOpRstMsg.rstCode cannot be set twice.");
                  }
                  _loc3_++;
                  rstCode = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

