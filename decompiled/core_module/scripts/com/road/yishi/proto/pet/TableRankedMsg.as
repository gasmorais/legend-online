package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TableRankedMsg extends Message implements IExternalizable
   {
      
      private var value$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.pet.TablePlayerMsg")]
      public var player:Array = [];
      
      public function TableRankedMsg()
      {
         super();
      }
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967294;
         value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 1;
         value$field = param1;
      }
      
      public function get value() : int
      {
         return value$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,value$field);
         }
         _loc2_ = 0;
         while(_loc2_ < player.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,player[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc5_:TablePlayerMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TableRankedMsg.value cannot be set twice.");
                  }
                  _loc4_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new TablePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  player.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

