package com.road.yishi.proto.reward
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardFreshRspMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var templateId:Array = [];
      
      private var reward_lastdate$field:String;
      
      [ArrayElementType("int")]
      public var isIsValid:Array = [];
      
      [ArrayElementType("int")]
      public var qualitys:Array = [];
      
      private var reward_times$field:int;
      
      private var hasField$0:uint = 0;
      
      private var free_times$field:int;
      
      private var is_button$field:Boolean;
      
      public function RewardFreshRspMsg()
      {
         super();
      }
      
      public function removeRewardLastdate() : void
      {
         reward_lastdate$field = null;
      }
      
      public function get hasRewardLastdate() : Boolean
      {
         return reward_lastdate$field != null;
      }
      
      public function set rewardLastdate(param1:String) : void
      {
         reward_lastdate$field = param1;
      }
      
      public function get rewardLastdate() : String
      {
         return reward_lastdate$field;
      }
      
      public function removeRewardTimes() : void
      {
         hasField$0 &= 4294967294;
         reward_times$field = new int();
      }
      
      public function get hasRewardTimes() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardTimes(param1:int) : void
      {
         hasField$0 |= 1;
         reward_times$field = param1;
      }
      
      public function get rewardTimes() : int
      {
         return reward_times$field;
      }
      
      public function removeFreeTimes() : void
      {
         hasField$0 &= 4294967293;
         free_times$field = new int();
      }
      
      public function get hasFreeTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set freeTimes(param1:int) : void
      {
         hasField$0 |= 2;
         free_times$field = param1;
      }
      
      public function get freeTimes() : int
      {
         return free_times$field;
      }
      
      public function removeIsButton() : void
      {
         hasField$0 &= 4294967291;
         is_button$field = new Boolean();
      }
      
      public function get hasIsButton() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isButton(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_button$field = param1;
      }
      
      public function get isButton() : Boolean
      {
         return is_button$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < templateId.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId[_loc4_]);
            _loc4_++;
         }
         if(hasRewardLastdate)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,reward_lastdate$field);
         }
         _loc3_ = 0;
         while(_loc3_ < isIsValid.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,isIsValid[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < qualitys.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,qualitys[_loc2_]);
            _loc2_++;
         }
         if(hasRewardTimes)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,reward_times$field);
         }
         if(hasFreeTimes)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,free_times$field);
         }
         if(hasIsButton)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,is_button$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,templateId);
                  }
                  else
                  {
                     templateId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RewardFreshRspMsg.rewardLastdate cannot be set twice.");
                  }
                  _loc7_++;
                  rewardLastdate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,isIsValid);
                  }
                  else
                  {
                     isIsValid.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  if((_loc6_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,qualitys);
                  }
                  else
                  {
                     qualitys.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RewardFreshRspMsg.rewardTimes cannot be set twice.");
                  }
                  _loc5_++;
                  rewardTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RewardFreshRspMsg.freeTimes cannot be set twice.");
                  }
                  _loc3_++;
                  freeTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RewardFreshRspMsg.isButton cannot be set twice.");
                  }
                  _loc4_++;
                  isButton = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

