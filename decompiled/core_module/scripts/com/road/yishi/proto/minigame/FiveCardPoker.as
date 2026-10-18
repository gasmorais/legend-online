package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FiveCardPoker extends Message implements IExternalizable
   {
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var color$field:int;
      
      private var number$field:int;
      
      public function FiveCardPoker()
      {
         super();
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
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
      
      public function removeNumber() : void
      {
         hasField$0 &= 4294967291;
         number$field = new int();
      }
      
      public function get hasNumber() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set number(param1:int) : void
      {
         hasField$0 |= 4;
         number$field = param1;
      }
      
      public function get number() : int
      {
         return number$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasColor)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,color$field);
         }
         if(hasNumber)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,number$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FiveCardPoker.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FiveCardPoker.color cannot be set twice.");
                  }
                  _loc5_++;
                  color = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FiveCardPoker.number cannot be set twice.");
                  }
                  _loc3_++;
                  number = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

