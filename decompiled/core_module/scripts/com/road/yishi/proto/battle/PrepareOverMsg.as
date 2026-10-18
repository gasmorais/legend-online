package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PrepareOverMsg extends Message implements IExternalizable
   {
      
      private var frame$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.battle.PrepareOverLivingMsg")]
      public var prepareOverLivings:Array = [];
      
      public function PrepareOverMsg()
      {
         super();
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
         var _loc2_:* = 0;
         if(hasFrame)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,frame$field);
         }
         _loc2_ = 0;
         while(_loc2_ < prepareOverLivings.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,prepareOverLivings[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:PrepareOverLivingMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PrepareOverMsg.frame cannot be set twice.");
                  }
                  _loc3_++;
                  frame = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new PrepareOverLivingMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  prepareOverLivings.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

