package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BottlePassMsg extends Message implements IExternalizable
   {
      
      private var pass_type$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("String")]
      public var infos:Array = [];
      
      private var count$field:int;
      
      private var dropId$field:int;
      
      public function BottlePassMsg()
      {
         super();
      }
      
      public function removePassType() : void
      {
         hasField$0 &= 4294967294;
         pass_type$field = new int();
      }
      
      public function get hasPassType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set passType(param1:int) : void
      {
         hasField$0 |= 1;
         pass_type$field = param1;
      }
      
      public function get passType() : int
      {
         return pass_type$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeDropId() : void
      {
         hasField$0 &= 4294967291;
         dropId$field = new int();
      }
      
      public function get hasDropId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set dropId(param1:int) : void
      {
         hasField$0 |= 4;
         dropId$field = param1;
      }
      
      public function get dropId() : int
      {
         return dropId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPassType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pass_type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < infos.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,infos[_loc2_]);
            _loc2_++;
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasDropId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dropId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BottlePassMsg.passType cannot be set twice.");
                  }
                  _loc6_++;
                  passType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  infos.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BottlePassMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BottlePassMsg.dropId cannot be set twice.");
                  }
                  _loc4_++;
                  dropId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

