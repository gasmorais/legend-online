package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PrepareOverLivingMsg extends Message implements IExternalizable
   {
      
      private var calc_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var living_id$field:int;
      
      private var sp$field:int;
      
      public function PrepareOverLivingMsg()
      {
         super();
      }
      
      public function removeCalcType() : void
      {
         hasField$0 &= 4294967294;
         calc_type$field = new int();
      }
      
      public function get hasCalcType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set calcType(param1:int) : void
      {
         hasField$0 |= 1;
         calc_type$field = param1;
      }
      
      public function get calcType() : int
      {
         return calc_type$field;
      }
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967293;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 2;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeSp() : void
      {
         hasField$0 &= 4294967291;
         sp$field = new int();
      }
      
      public function get hasSp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sp(param1:int) : void
      {
         hasField$0 |= 4;
         sp$field = param1;
      }
      
      public function get sp() : int
      {
         return sp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCalcType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,calc_type$field);
         }
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasSp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PrepareOverLivingMsg.calcType cannot be set twice.");
                  }
                  _loc3_++;
                  calcType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PrepareOverLivingMsg.livingId cannot be set twice.");
                  }
                  _loc5_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PrepareOverLivingMsg.sp cannot be set twice.");
                  }
                  _loc6_++;
                  sp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

