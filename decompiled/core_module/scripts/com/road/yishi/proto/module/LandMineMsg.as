package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LandMineMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var state$field:int;
      
      private var isWin$field:Boolean;
      
      private var reward_count$field:int;
      
      [ArrayElementType("com.road.yishi.proto.module.SapperMsg")]
      public var sappers:Array = [];
      
      public function LandMineMsg()
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967291;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 4;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967287;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 8;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeIsWin() : void
      {
         hasField$0 &= 4294967263;
         isWin$field = new Boolean();
      }
      
      public function get hasIsWin() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isWin(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isWin$field = param1;
      }
      
      public function get isWin() : Boolean
      {
         return isWin$field;
      }
      
      public function removeRewardCount() : void
      {
         hasField$0 &= 4294967231;
         reward_count$field = new int();
      }
      
      public function get hasRewardCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set rewardCount(param1:int) : void
      {
         hasField$0 |= 64;
         reward_count$field = param1;
      }
      
      public function get rewardCount() : int
      {
         return reward_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasIsWin)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isWin$field);
         }
         if(hasRewardCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,reward_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < sappers.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,sappers[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc11_:SapperMsg = null;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LandMineMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LandMineMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LandMineMsg.posX cannot be set twice.");
                  }
                  _loc8_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LandMineMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LandMineMsg.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LandMineMsg.isWin cannot be set twice.");
                  }
                  _loc4_++;
                  isWin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LandMineMsg.rewardCount cannot be set twice.");
                  }
                  _loc10_++;
                  rewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc11_ = new SapperMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  sappers.push(_loc11_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

