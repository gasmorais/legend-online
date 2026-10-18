package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DropInfoMsg extends Message implements IExternalizable
   {
      
      private var drop_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var drop_count$field:int;
      
      [ArrayElementType("int")]
      public var winnerIds:Array = [];
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      public function DropInfoMsg()
      {
         super();
      }
      
      public function removeDropId() : void
      {
         hasField$0 &= 4294967294;
         drop_id$field = new int();
      }
      
      public function get hasDropId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dropId(param1:int) : void
      {
         hasField$0 |= 1;
         drop_id$field = param1;
      }
      
      public function get dropId() : int
      {
         return drop_id$field;
      }
      
      public function removeDropCount() : void
      {
         hasField$0 &= 4294967293;
         drop_count$field = new int();
      }
      
      public function get hasDropCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set dropCount(param1:int) : void
      {
         hasField$0 |= 2;
         drop_count$field = param1;
      }
      
      public function get dropCount() : int
      {
         return drop_count$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967291;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 4;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967287;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 8;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDropId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,drop_id$field);
         }
         if(hasDropCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,drop_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < winnerIds.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,winnerIds[_loc2_]);
            _loc2_++;
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DropInfoMsg.dropId cannot be set twice.");
                  }
                  _loc6_++;
                  dropId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DropInfoMsg.dropCount cannot be set twice.");
                  }
                  _loc4_++;
                  dropCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,winnerIds);
                  }
                  else
                  {
                     winnerIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DropInfoMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DropInfoMsg.param2 cannot be set twice.");
                  }
                  _loc7_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

