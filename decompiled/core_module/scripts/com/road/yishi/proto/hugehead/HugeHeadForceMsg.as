package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadForceMsg extends Message implements IExternalizable
   {
      
      private var force_index$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadGuildMsg")]
      public var guildList:Array = [];
      
      private var notice$field:String;
      
      private var remain_attack_count$field:int;
      
      public function HugeHeadForceMsg()
      {
         super();
      }
      
      public function removeForceIndex() : void
      {
         hasField$0 &= 4294967294;
         force_index$field = new int();
      }
      
      public function get hasForceIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set forceIndex(param1:int) : void
      {
         hasField$0 |= 1;
         force_index$field = param1;
      }
      
      public function get forceIndex() : int
      {
         return force_index$field;
      }
      
      public function removeNotice() : void
      {
         notice$field = null;
      }
      
      public function get hasNotice() : Boolean
      {
         return notice$field != null;
      }
      
      public function set notice(param1:String) : void
      {
         notice$field = param1;
      }
      
      public function get notice() : String
      {
         return notice$field;
      }
      
      public function removeRemainAttackCount() : void
      {
         hasField$0 &= 4294967293;
         remain_attack_count$field = new int();
      }
      
      public function get hasRemainAttackCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set remainAttackCount(param1:int) : void
      {
         hasField$0 |= 2;
         remain_attack_count$field = param1;
      }
      
      public function get remainAttackCount() : int
      {
         return remain_attack_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasForceIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,force_index$field);
         }
         _loc2_ = 0;
         while(_loc2_ < guildList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,guildList[_loc2_]);
            _loc2_++;
         }
         if(hasNotice)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,notice$field);
         }
         if(hasRemainAttackCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,remain_attack_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:HugeHeadGuildMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadForceMsg.forceIndex cannot be set twice.");
                  }
                  _loc7_++;
                  forceIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new HugeHeadGuildMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  guildList.push(_loc5_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadForceMsg.notice cannot be set twice.");
                  }
                  _loc4_++;
                  notice = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadForceMsg.remainAttackCount cannot be set twice.");
                  }
                  _loc3_++;
                  remainAttackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

