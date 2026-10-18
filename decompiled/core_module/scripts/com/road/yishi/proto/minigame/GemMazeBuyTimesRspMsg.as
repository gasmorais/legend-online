package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GemMazeBuyTimesRspMsg extends Message implements IExternalizable
   {
      
      private var moveTimesLeft$field:int;
      
      private var hasField$0:uint = 0;
      
      private var buyTimes$field:int;
      
      public function GemMazeBuyTimesRspMsg()
      {
         super();
      }
      
      public function removeMoveTimesLeft() : void
      {
         hasField$0 &= 4294967294;
         moveTimesLeft$field = new int();
      }
      
      public function get hasMoveTimesLeft() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set moveTimesLeft(param1:int) : void
      {
         hasField$0 |= 1;
         moveTimesLeft$field = param1;
      }
      
      public function get moveTimesLeft() : int
      {
         return moveTimesLeft$field;
      }
      
      public function removeBuyTimes() : void
      {
         hasField$0 &= 4294967293;
         buyTimes$field = new int();
      }
      
      public function get hasBuyTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buyTimes(param1:int) : void
      {
         hasField$0 |= 2;
         buyTimes$field = param1;
      }
      
      public function get buyTimes() : int
      {
         return buyTimes$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMoveTimesLeft)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,moveTimesLeft$field);
         }
         if(hasBuyTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,buyTimes$field);
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
                     throw new IOError("Bad data format: GemMazeBuyTimesRspMsg.moveTimesLeft cannot be set twice.");
                  }
                  _loc3_++;
                  moveTimesLeft = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GemMazeBuyTimesRspMsg.buyTimes cannot be set twice.");
                  }
                  _loc5_++;
                  buyTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

