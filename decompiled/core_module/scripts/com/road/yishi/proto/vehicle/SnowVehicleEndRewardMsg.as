package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SnowVehicleEndRewardMsg extends Message implements IExternalizable
   {
      
      private var myRank$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isOnHook$field:Boolean;
      
      private var pickSkillNum$field:int;
      
      private var damage$field:int;
      
      private var eliminateNum$field:int;
      
      private var todayReward$field:int;
      
      public function SnowVehicleEndRewardMsg()
      {
         super();
      }
      
      public function removeMyRank() : void
      {
         hasField$0 &= 4294967294;
         myRank$field = new int();
      }
      
      public function get hasMyRank() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set myRank(param1:int) : void
      {
         hasField$0 |= 1;
         myRank$field = param1;
      }
      
      public function get myRank() : int
      {
         return myRank$field;
      }
      
      public function removeIsOnHook() : void
      {
         hasField$0 &= 4294967293;
         isOnHook$field = new Boolean();
      }
      
      public function get hasIsOnHook() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isOnHook(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isOnHook$field = param1;
      }
      
      public function get isOnHook() : Boolean
      {
         return isOnHook$field;
      }
      
      public function removePickSkillNum() : void
      {
         hasField$0 &= 4294967291;
         pickSkillNum$field = new int();
      }
      
      public function get hasPickSkillNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pickSkillNum(param1:int) : void
      {
         hasField$0 |= 4;
         pickSkillNum$field = param1;
      }
      
      public function get pickSkillNum() : int
      {
         return pickSkillNum$field;
      }
      
      public function removeDamage() : void
      {
         hasField$0 &= 4294967287;
         damage$field = new int();
      }
      
      public function get hasDamage() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set damage(param1:int) : void
      {
         hasField$0 |= 8;
         damage$field = param1;
      }
      
      public function get damage() : int
      {
         return damage$field;
      }
      
      public function removeEliminateNum() : void
      {
         hasField$0 &= 4294967279;
         eliminateNum$field = new int();
      }
      
      public function get hasEliminateNum() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set eliminateNum(param1:int) : void
      {
         hasField$0 |= 16;
         eliminateNum$field = param1;
      }
      
      public function get eliminateNum() : int
      {
         return eliminateNum$field;
      }
      
      public function removeTodayReward() : void
      {
         hasField$0 &= 4294967263;
         todayReward$field = new int();
      }
      
      public function get hasTodayReward() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set todayReward(param1:int) : void
      {
         hasField$0 |= 32;
         todayReward$field = param1;
      }
      
      public function get todayReward() : int
      {
         return todayReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMyRank)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,myRank$field);
         }
         if(hasIsOnHook)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isOnHook$field);
         }
         if(hasPickSkillNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pickSkillNum$field);
         }
         if(hasDamage)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,damage$field);
         }
         if(hasEliminateNum)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,eliminateNum$field);
         }
         if(hasTodayReward)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,todayReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleEndRewardMsg.myRank cannot be set twice.");
                  }
                  _loc3_++;
                  myRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleEndRewardMsg.isOnHook cannot be set twice.");
                  }
                  _loc4_++;
                  isOnHook = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleEndRewardMsg.pickSkillNum cannot be set twice.");
                  }
                  _loc9_++;
                  pickSkillNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleEndRewardMsg.damage cannot be set twice.");
                  }
                  _loc6_++;
                  damage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleEndRewardMsg.eliminateNum cannot be set twice.");
                  }
                  _loc5_++;
                  eliminateNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleEndRewardMsg.todayReward cannot be set twice.");
                  }
                  _loc7_++;
                  todayReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

