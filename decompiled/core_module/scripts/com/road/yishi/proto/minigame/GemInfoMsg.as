package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GemInfoMsg extends Message implements IExternalizable
   {
      
      private var mark$field:int;
      
      private var hasField$0:uint = 0;
      
      private var color$field:int;
      
      public function GemInfoMsg()
      {
         super();
      }
      
      public function removeMark() : void
      {
         hasField$0 &= 4294967294;
         mark$field = new int();
      }
      
      public function get hasMark() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mark(param1:int) : void
      {
         hasField$0 |= 1;
         mark$field = param1;
      }
      
      public function get mark() : int
      {
         return mark$field;
      }
      
      public function removeColor() : void
      {
         hasField$0 &= 4294967293;
         color$field = new int();
      }
      
      public function get hasColor() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set color(param1:int) : void
      {
         hasField$0 |= 2;
         color$field = param1;
      }
      
      public function get color() : int
      {
         return color$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMark)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mark$field);
         }
         if(hasColor)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,color$field);
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
                     throw new IOError("Bad data format: GemInfoMsg.mark cannot be set twice.");
                  }
                  _loc3_++;
                  mark = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GemInfoMsg.color cannot be set twice.");
                  }
                  _loc4_++;
                  color = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

