package com.road.yishi.proto.storehouse
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StoreHouseUseMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      private var passChapter$field:int;
      
      private var firstReward$field:String;
      
      public function StoreHouseUseMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
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
      
      public function removePassChapter() : void
      {
         hasField$0 &= 4294967291;
         passChapter$field = new int();
      }
      
      public function get hasPassChapter() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set passChapter(param1:int) : void
      {
         hasField$0 |= 4;
         passChapter$field = param1;
      }
      
      public function get passChapter() : int
      {
         return passChapter$field;
      }
      
      public function removeFirstReward() : void
      {
         firstReward$field = null;
      }
      
      public function get hasFirstReward() : Boolean
      {
         return firstReward$field != null;
      }
      
      public function set firstReward(param1:String) : void
      {
         firstReward$field = param1;
      }
      
      public function get firstReward() : String
      {
         return firstReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasPassChapter)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,passChapter$field);
         }
         if(hasFirstReward)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,firstReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseUseMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseUseMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseUseMsg.passChapter cannot be set twice.");
                  }
                  _loc5_++;
                  passChapter = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseUseMsg.firstReward cannot be set twice.");
                  }
                  _loc7_++;
                  firstReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

