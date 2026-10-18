package com.road.yishi.proto.mail
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PickupResult extends Message implements IExternalizable
   {
      
      private var mail_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attach_index$field:int;
      
      private var result$field:Boolean;
      
      public function PickupResult()
      {
         super();
      }
      
      public function removeMailId() : void
      {
         hasField$0 &= 4294967294;
         mail_id$field = new int();
      }
      
      public function get hasMailId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mailId(param1:int) : void
      {
         hasField$0 |= 1;
         mail_id$field = param1;
      }
      
      public function get mailId() : int
      {
         return mail_id$field;
      }
      
      public function removeAttachIndex() : void
      {
         hasField$0 &= 4294967293;
         attach_index$field = new int();
      }
      
      public function get hasAttachIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set attachIndex(param1:int) : void
      {
         hasField$0 |= 2;
         attach_index$field = param1;
      }
      
      public function get attachIndex() : int
      {
         return attach_index$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967291;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 4;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMailId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mail_id$field);
         }
         if(hasAttachIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,attach_index$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PickupResult.mailId cannot be set twice.");
                  }
                  _loc4_++;
                  mailId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PickupResult.attachIndex cannot be set twice.");
                  }
                  _loc3_++;
                  attachIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PickupResult.result cannot be set twice.");
                  }
                  _loc5_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

