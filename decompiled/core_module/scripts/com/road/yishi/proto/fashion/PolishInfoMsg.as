package com.road.yishi.proto.fashion
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PolishInfoMsg extends Message implements IExternalizable
   {
      
      private var sontype$field:int;
      
      private var hasField$0:uint = 0;
      
      private var level$field:int;
      
      private var exp$field:int;
      
      public function PolishInfoMsg()
      {
         super();
      }
      
      public function removeSontype() : void
      {
         hasField$0 &= 4294967294;
         sontype$field = new int();
      }
      
      public function get hasSontype() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set sontype(param1:int) : void
      {
         hasField$0 |= 1;
         sontype$field = param1;
      }
      
      public function get sontype() : int
      {
         return sontype$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967291;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 4;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSontype)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,sontype$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PolishInfoMsg.sontype cannot be set twice.");
                  }
                  _loc3_++;
                  sontype = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PolishInfoMsg.level cannot be set twice.");
                  }
                  _loc4_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PolishInfoMsg.exp cannot be set twice.");
                  }
                  _loc5_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

