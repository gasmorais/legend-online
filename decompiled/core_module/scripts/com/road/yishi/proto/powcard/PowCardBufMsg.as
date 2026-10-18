package com.road.yishi.proto.powcard
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PowCardBufMsg extends Message implements IExternalizable
   {
      
      private var sonType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bufId$field:int;
      
      private var fixValue$field:int;
      
      private var percent$field:int;
      
      public function PowCardBufMsg()
      {
         super();
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967294;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 1;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removeBufId() : void
      {
         hasField$0 &= 4294967293;
         bufId$field = new int();
      }
      
      public function get hasBufId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bufId(param1:int) : void
      {
         hasField$0 |= 2;
         bufId$field = param1;
      }
      
      public function get bufId() : int
      {
         return bufId$field;
      }
      
      public function removeFixValue() : void
      {
         hasField$0 &= 4294967291;
         fixValue$field = new int();
      }
      
      public function get hasFixValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fixValue(param1:int) : void
      {
         hasField$0 |= 4;
         fixValue$field = param1;
      }
      
      public function get fixValue() : int
      {
         return fixValue$field;
      }
      
      public function removePercent() : void
      {
         hasField$0 &= 4294967287;
         percent$field = new int();
      }
      
      public function get hasPercent() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set percent(param1:int) : void
      {
         hasField$0 |= 8;
         percent$field = param1;
      }
      
      public function get percent() : int
      {
         return percent$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasBufId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bufId$field);
         }
         if(hasFixValue)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fixValue$field);
         }
         if(hasPercent)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,percent$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardBufMsg.sonType cannot be set twice.");
                  }
                  _loc3_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardBufMsg.bufId cannot be set twice.");
                  }
                  _loc5_++;
                  bufId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardBufMsg.fixValue cannot be set twice.");
                  }
                  _loc6_++;
                  fixValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PowCardBufMsg.percent cannot be set twice.");
                  }
                  _loc4_++;
                  percent = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

