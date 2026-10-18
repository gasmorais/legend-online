package com.road.yishi.proto.bottle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BottleMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.bottle.PlayerBottleMsg")]
      public var playerBottle:Array = [];
      
      private var total$field:int;
      
      private var hasField$0:uint = 0;
      
      public function BottleMsg()
      {
         super();
      }
      
      public function removeTotal() : void
      {
         hasField$0 &= 4294967294;
         total$field = new int();
      }
      
      public function get hasTotal() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set total(param1:int) : void
      {
         hasField$0 |= 1;
         total$field = param1;
      }
      
      public function get total() : int
      {
         return total$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < playerBottle.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,playerBottle[_loc2_]);
            _loc2_++;
         }
         if(hasTotal)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,total$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:PlayerBottleMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new PlayerBottleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  playerBottle.push(_loc3_);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BottleMsg.total cannot be set twice.");
                  }
                  _loc4_++;
                  total = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

