package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MultiPlayerHpSyncMsg extends Message implements IExternalizable
   {
      
      private var armyId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curHp$field:int;
      
      private var totalHp$field:int;
      
      public function MultiPlayerHpSyncMsg()
      {
         super();
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967294;
         armyId$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 1;
         armyId$field = param1;
      }
      
      public function get armyId() : int
      {
         return armyId$field;
      }
      
      public function removeCurHp() : void
      {
         hasField$0 &= 4294967293;
         curHp$field = new int();
      }
      
      public function get hasCurHp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curHp(param1:int) : void
      {
         hasField$0 |= 2;
         curHp$field = param1;
      }
      
      public function get curHp() : int
      {
         return curHp$field;
      }
      
      public function removeTotalHp() : void
      {
         hasField$0 &= 4294967291;
         totalHp$field = new int();
      }
      
      public function get hasTotalHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalHp(param1:int) : void
      {
         hasField$0 |= 4;
         totalHp$field = param1;
      }
      
      public function get totalHp() : int
      {
         return totalHp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,armyId$field);
         }
         if(hasCurHp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curHp$field);
         }
         if(hasTotalHp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,totalHp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MultiPlayerHpSyncMsg.armyId cannot be set twice.");
                  }
                  _loc5_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MultiPlayerHpSyncMsg.curHp cannot be set twice.");
                  }
                  _loc6_++;
                  curHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MultiPlayerHpSyncMsg.totalHp cannot be set twice.");
                  }
                  _loc3_++;
                  totalHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

