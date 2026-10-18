package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RankRewardMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var status$field:int;
      
      private var rank$field:int;
      
      private var opType$field:int;
      
      public function RankRewardMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967293;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 2;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967291;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 4;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967287;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 8;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RankRewardProto.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RankRewardProto.status cannot be set twice.");
                  }
                  _loc7_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RankRewardProto.rank cannot be set twice.");
                  }
                  _loc3_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RankRewardProto.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

