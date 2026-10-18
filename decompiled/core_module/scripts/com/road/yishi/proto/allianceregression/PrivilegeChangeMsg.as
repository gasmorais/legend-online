package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PrivilegeChangeMsg extends Message implements IExternalizable
   {
      
      private var TimeVortexCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var EvilLandBossCount$field:int;
      
      private var ForbiddenBossCount$field:int;
      
      private var DemonRoadBuyCount$field:int;
      
      public function PrivilegeChangeMsg()
      {
         super();
      }
      
      public function removeTimeVortexCount() : void
      {
         hasField$0 &= 4294967294;
         TimeVortexCount$field = new int();
      }
      
      public function get hasTimeVortexCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set timeVortexCount(param1:int) : void
      {
         hasField$0 |= 1;
         TimeVortexCount$field = param1;
      }
      
      public function get timeVortexCount() : int
      {
         return TimeVortexCount$field;
      }
      
      public function removeEvilLandBossCount() : void
      {
         hasField$0 &= 4294967293;
         EvilLandBossCount$field = new int();
      }
      
      public function get hasEvilLandBossCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set evilLandBossCount(param1:int) : void
      {
         hasField$0 |= 2;
         EvilLandBossCount$field = param1;
      }
      
      public function get evilLandBossCount() : int
      {
         return EvilLandBossCount$field;
      }
      
      public function removeForbiddenBossCount() : void
      {
         hasField$0 &= 4294967291;
         ForbiddenBossCount$field = new int();
      }
      
      public function get hasForbiddenBossCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set forbiddenBossCount(param1:int) : void
      {
         hasField$0 |= 4;
         ForbiddenBossCount$field = param1;
      }
      
      public function get forbiddenBossCount() : int
      {
         return ForbiddenBossCount$field;
      }
      
      public function removeDemonRoadBuyCount() : void
      {
         hasField$0 &= 4294967287;
         DemonRoadBuyCount$field = new int();
      }
      
      public function get hasDemonRoadBuyCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set demonRoadBuyCount(param1:int) : void
      {
         hasField$0 |= 8;
         DemonRoadBuyCount$field = param1;
      }
      
      public function get demonRoadBuyCount() : int
      {
         return DemonRoadBuyCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTimeVortexCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,TimeVortexCount$field);
         }
         if(hasEvilLandBossCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,EvilLandBossCount$field);
         }
         if(hasForbiddenBossCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,ForbiddenBossCount$field);
         }
         if(hasDemonRoadBuyCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,DemonRoadBuyCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeChangeMsg.timeVortexCount cannot be set twice.");
                  }
                  _loc3_++;
                  timeVortexCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeChangeMsg.evilLandBossCount cannot be set twice.");
                  }
                  _loc7_++;
                  evilLandBossCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeChangeMsg.forbiddenBossCount cannot be set twice.");
                  }
                  _loc5_++;
                  forbiddenBossCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PrivilegeChangeMsg.demonRoadBuyCount cannot be set twice.");
                  }
                  _loc4_++;
                  demonRoadBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

