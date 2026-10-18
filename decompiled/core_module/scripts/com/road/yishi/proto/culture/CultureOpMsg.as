package com.road.yishi.proto.culture
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CultureOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sonType$field:int;
      
      private var takeRewardType$field:int;
      
      private var takeRewardLevel$field:int;
      
      private var rankType$field:int;
      
      public function CultureOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967293;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 2;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removeTakeRewardType() : void
      {
         hasField$0 &= 4294967291;
         takeRewardType$field = new int();
      }
      
      public function get hasTakeRewardType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set takeRewardType(param1:int) : void
      {
         hasField$0 |= 4;
         takeRewardType$field = param1;
      }
      
      public function get takeRewardType() : int
      {
         return takeRewardType$field;
      }
      
      public function removeTakeRewardLevel() : void
      {
         hasField$0 &= 4294967287;
         takeRewardLevel$field = new int();
      }
      
      public function get hasTakeRewardLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set takeRewardLevel(param1:int) : void
      {
         hasField$0 |= 8;
         takeRewardLevel$field = param1;
      }
      
      public function get takeRewardLevel() : int
      {
         return takeRewardLevel$field;
      }
      
      public function removeRankType() : void
      {
         hasField$0 &= 4294967279;
         rankType$field = new int();
      }
      
      public function get hasRankType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rankType(param1:int) : void
      {
         hasField$0 |= 16;
         rankType$field = param1;
      }
      
      public function get rankType() : int
      {
         return rankType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasTakeRewardType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,takeRewardType$field);
         }
         if(hasTakeRewardLevel)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,takeRewardLevel$field);
         }
         if(hasRankType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rankType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOpMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOpMsg.sonType cannot be set twice.");
                  }
                  _loc3_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOpMsg.takeRewardType cannot be set twice.");
                  }
                  _loc6_++;
                  takeRewardType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOpMsg.takeRewardLevel cannot be set twice.");
                  }
                  _loc4_++;
                  takeRewardLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CultureOpMsg.rankType cannot be set twice.");
                  }
                  _loc5_++;
                  rankType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

