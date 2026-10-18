package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PawnChangeMsg extends Message implements IExternalizable
   {
      
      private var cur_pawnTempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tar_pawnTempId$field:int;
      
      private var pay_type$field:int;
      
      public function PawnChangeMsg()
      {
         super();
      }
      
      public function removeCurPawnTempId() : void
      {
         hasField$0 &= 4294967294;
         cur_pawnTempId$field = new int();
      }
      
      public function get hasCurPawnTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curPawnTempId(param1:int) : void
      {
         hasField$0 |= 1;
         cur_pawnTempId$field = param1;
      }
      
      public function get curPawnTempId() : int
      {
         return cur_pawnTempId$field;
      }
      
      public function removeTarPawnTempId() : void
      {
         hasField$0 &= 4294967293;
         tar_pawnTempId$field = new int();
      }
      
      public function get hasTarPawnTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tarPawnTempId(param1:int) : void
      {
         hasField$0 |= 2;
         tar_pawnTempId$field = param1;
      }
      
      public function get tarPawnTempId() : int
      {
         return tar_pawnTempId$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967291;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 4;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCurPawnTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,cur_pawnTempId$field);
         }
         if(hasTarPawnTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tar_pawnTempId$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PawnChangeMsg.curPawnTempId cannot be set twice.");
                  }
                  _loc3_++;
                  curPawnTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PawnChangeMsg.tarPawnTempId cannot be set twice.");
                  }
                  _loc6_++;
                  tarPawnTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PawnChangeMsg.payType cannot be set twice.");
                  }
                  _loc5_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

