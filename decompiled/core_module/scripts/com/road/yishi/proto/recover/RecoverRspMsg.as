package com.road.yishi.proto.recover
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RecoverRspMsg extends Message implements IExternalizable
   {
      
      private var payPoint$field:int;
      
      private var hasField$0:uint = 0;
      
      private var recoverGP$field:int;
      
      public function RecoverRspMsg()
      {
         super();
      }
      
      public function removePayPoint() : void
      {
         hasField$0 &= 4294967294;
         payPoint$field = new int();
      }
      
      public function get hasPayPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set payPoint(param1:int) : void
      {
         hasField$0 |= 1;
         payPoint$field = param1;
      }
      
      public function get payPoint() : int
      {
         return payPoint$field;
      }
      
      public function removeRecoverGP() : void
      {
         hasField$0 &= 4294967293;
         recoverGP$field = new int();
      }
      
      public function get hasRecoverGP() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set recoverGP(param1:int) : void
      {
         hasField$0 |= 2;
         recoverGP$field = param1;
      }
      
      public function get recoverGP() : int
      {
         return recoverGP$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPayPoint)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,payPoint$field);
         }
         if(hasRecoverGP)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,recoverGP$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RecoverRspMsg.payPoint cannot be set twice.");
                  }
                  _loc3_++;
                  payPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RecoverRspMsg.recoverGP cannot be set twice.");
                  }
                  _loc4_++;
                  recoverGP = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

