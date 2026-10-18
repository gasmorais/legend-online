package com.road.yishi.proto.warsoultower
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ResultRspMsg extends Message implements IExternalizable
   {
      
      private var isNewRecord$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var highestUnLockLevel$field:int;
      
      private var startLevel$field:int;
      
      private var endLevel$field:int;
      
      [ArrayElementType("com.road.yishi.proto.warsoultower.RewardRspMsg")]
      public var rewards:Array = [];
      
      public function ResultRspMsg()
      {
         super();
      }
      
      public function removeIsNewRecord() : void
      {
         hasField$0 &= 4294967294;
         isNewRecord$field = new Boolean();
      }
      
      public function get hasIsNewRecord() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isNewRecord(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isNewRecord$field = param1;
      }
      
      public function get isNewRecord() : Boolean
      {
         return isNewRecord$field;
      }
      
      public function removeHighestUnLockLevel() : void
      {
         hasField$0 &= 4294967293;
         highestUnLockLevel$field = new int();
      }
      
      public function get hasHighestUnLockLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set highestUnLockLevel(param1:int) : void
      {
         hasField$0 |= 2;
         highestUnLockLevel$field = param1;
      }
      
      public function get highestUnLockLevel() : int
      {
         return highestUnLockLevel$field;
      }
      
      public function removeStartLevel() : void
      {
         hasField$0 &= 4294967291;
         startLevel$field = new int();
      }
      
      public function get hasStartLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set startLevel(param1:int) : void
      {
         hasField$0 |= 4;
         startLevel$field = param1;
      }
      
      public function get startLevel() : int
      {
         return startLevel$field;
      }
      
      public function removeEndLevel() : void
      {
         hasField$0 &= 4294967287;
         endLevel$field = new int();
      }
      
      public function get hasEndLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endLevel(param1:int) : void
      {
         hasField$0 |= 8;
         endLevel$field = param1;
      }
      
      public function get endLevel() : int
      {
         return endLevel$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIsNewRecord)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isNewRecord$field);
         }
         if(hasHighestUnLockLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,highestUnLockLevel$field);
         }
         if(hasStartLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,startLevel$field);
         }
         if(hasEndLevel)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,endLevel$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewards.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rewards[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:RewardRspMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ResultRspMsg.isNewRecord cannot be set twice.");
                  }
                  _loc3_++;
                  isNewRecord = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ResultRspMsg.highestUnLockLevel cannot be set twice.");
                  }
                  _loc5_++;
                  highestUnLockLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ResultRspMsg.startLevel cannot be set twice.");
                  }
                  _loc4_++;
                  startLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ResultRspMsg.endLevel cannot be set twice.");
                  }
                  _loc8_++;
                  endLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc7_ = new RewardRspMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  rewards.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

