package com.road.yishi.proto.treasuremap
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerTreasureMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var join_count$field:int;
      
      private var reward_count$field:int;
      
      private var index$field:int;
      
      [ArrayElementType("int")]
      public var templateIds:Array = [];
      
      private var op_type$field:int;
      
      private var pay_type$field:int;
      
      private var refresh_type$field:Boolean;
      
      private var is_reward$field:Boolean;
      
      private var is_firstQuest$field:Boolean;
      
      private var is_firstGet$field:Boolean;
      
      private var is_firstUse$field:Boolean;
      
      public function PlayerTreasureMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeJoinCount() : void
      {
         hasField$0 &= 4294967293;
         join_count$field = new int();
      }
      
      public function get hasJoinCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set joinCount(param1:int) : void
      {
         hasField$0 |= 2;
         join_count$field = param1;
      }
      
      public function get joinCount() : int
      {
         return join_count$field;
      }
      
      public function removeRewardCount() : void
      {
         hasField$0 &= 4294967291;
         reward_count$field = new int();
      }
      
      public function get hasRewardCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rewardCount(param1:int) : void
      {
         hasField$0 |= 4;
         reward_count$field = param1;
      }
      
      public function get rewardCount() : int
      {
         return reward_count$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967287;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 8;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967279;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 16;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967263;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 32;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeRefreshType() : void
      {
         hasField$0 &= 4294967231;
         refresh_type$field = new Boolean();
      }
      
      public function get hasRefreshType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set refreshType(param1:Boolean) : void
      {
         hasField$0 |= 64;
         refresh_type$field = param1;
      }
      
      public function get refreshType() : Boolean
      {
         return refresh_type$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294967167;
         is_reward$field = new Boolean();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isReward(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_reward$field = param1;
      }
      
      public function get isReward() : Boolean
      {
         return is_reward$field;
      }
      
      public function removeIsFirstQuest() : void
      {
         hasField$0 &= 4294967039;
         is_firstQuest$field = new Boolean();
      }
      
      public function get hasIsFirstQuest() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isFirstQuest(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_firstQuest$field = param1;
      }
      
      public function get isFirstQuest() : Boolean
      {
         return is_firstQuest$field;
      }
      
      public function removeIsFirstGet() : void
      {
         hasField$0 &= 4294966783;
         is_firstGet$field = new Boolean();
      }
      
      public function get hasIsFirstGet() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isFirstGet(param1:Boolean) : void
      {
         hasField$0 |= 512;
         is_firstGet$field = param1;
      }
      
      public function get isFirstGet() : Boolean
      {
         return is_firstGet$field;
      }
      
      public function removeIsFirstUse() : void
      {
         hasField$0 &= 4294966271;
         is_firstUse$field = new Boolean();
      }
      
      public function get hasIsFirstUse() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isFirstUse(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         is_firstUse$field = param1;
      }
      
      public function get isFirstUse() : Boolean
      {
         return is_firstUse$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasJoinCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,join_count$field);
         }
         if(hasRewardCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,reward_count$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         _loc2_ = 0;
         while(_loc2_ < templateIds.length)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,templateIds[_loc2_]);
            _loc2_++;
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasRefreshType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,refresh_type$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,is_reward$field);
         }
         if(hasIsFirstQuest)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,is_firstQuest$field);
         }
         if(hasIsFirstGet)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,is_firstGet$field);
         }
         if(hasIsFirstUse)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,is_firstUse$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.userId cannot be set twice.");
                  }
                  _loc11_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.joinCount cannot be set twice.");
                  }
                  _loc9_++;
                  joinCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.rewardCount cannot be set twice.");
                  }
                  _loc5_++;
                  rewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.index cannot be set twice.");
                  }
                  _loc6_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if((_loc12_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,templateIds);
                  }
                  else
                  {
                     templateIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.opType cannot be set twice.");
                  }
                  _loc10_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.payType cannot be set twice.");
                  }
                  _loc4_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.refreshType cannot be set twice.");
                  }
                  _loc3_++;
                  refreshType = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.isReward cannot be set twice.");
                  }
                  _loc13_++;
                  isReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.isFirstQuest cannot be set twice.");
                  }
                  _loc14_++;
                  isFirstQuest = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.isFirstGet cannot be set twice.");
                  }
                  _loc7_++;
                  isFirstGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerTreasureMsg.isFirstUse cannot be set twice.");
                  }
                  _loc8_++;
                  isFirstUse = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

