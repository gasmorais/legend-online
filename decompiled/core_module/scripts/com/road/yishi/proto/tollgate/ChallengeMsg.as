package com.road.yishi.proto.tollgate
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChallengeMsg extends Message implements IExternalizable
   {
      
      private var tollgate_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attack_userid$field:int;
      
      private var attack_name$field:String;
      
      private var attack_time$field:String;
      
      private var remain_time$field:int;
      
      private var last_hp$field:int;
      
      public function ChallengeMsg()
      {
         super();
      }
      
      public function removeTollgateId() : void
      {
         hasField$0 &= 4294967294;
         tollgate_id$field = new int();
      }
      
      public function get hasTollgateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tollgateId(param1:int) : void
      {
         hasField$0 |= 1;
         tollgate_id$field = param1;
      }
      
      public function get tollgateId() : int
      {
         return tollgate_id$field;
      }
      
      public function removeAttackUserid() : void
      {
         hasField$0 &= 4294967293;
         attack_userid$field = new int();
      }
      
      public function get hasAttackUserid() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set attackUserid(param1:int) : void
      {
         hasField$0 |= 2;
         attack_userid$field = param1;
      }
      
      public function get attackUserid() : int
      {
         return attack_userid$field;
      }
      
      public function removeAttackName() : void
      {
         attack_name$field = null;
      }
      
      public function get hasAttackName() : Boolean
      {
         return attack_name$field != null;
      }
      
      public function set attackName(param1:String) : void
      {
         attack_name$field = param1;
      }
      
      public function get attackName() : String
      {
         return attack_name$field;
      }
      
      public function removeAttackTime() : void
      {
         attack_time$field = null;
      }
      
      public function get hasAttackTime() : Boolean
      {
         return attack_time$field != null;
      }
      
      public function set attackTime(param1:String) : void
      {
         attack_time$field = param1;
      }
      
      public function get attackTime() : String
      {
         return attack_time$field;
      }
      
      public function removeRemainTime() : void
      {
         hasField$0 &= 4294967291;
         remain_time$field = new int();
      }
      
      public function get hasRemainTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set remainTime(param1:int) : void
      {
         hasField$0 |= 4;
         remain_time$field = param1;
      }
      
      public function get remainTime() : int
      {
         return remain_time$field;
      }
      
      public function removeLastHp() : void
      {
         hasField$0 &= 4294967287;
         last_hp$field = new int();
      }
      
      public function get hasLastHp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set lastHp(param1:int) : void
      {
         hasField$0 |= 8;
         last_hp$field = param1;
      }
      
      public function get lastHp() : int
      {
         return last_hp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTollgateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tollgate_id$field);
         }
         if(hasAttackUserid)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,attack_userid$field);
         }
         if(hasAttackName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,attack_name$field);
         }
         if(hasAttackTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,attack_time$field);
         }
         if(hasRemainTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,remain_time$field);
         }
         if(hasLastHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,last_hp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.tollgateId cannot be set twice.");
                  }
                  _loc9_++;
                  tollgateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.attackUserid cannot be set twice.");
                  }
                  _loc8_++;
                  attackUserid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.attackName cannot be set twice.");
                  }
                  _loc3_++;
                  attackName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.attackTime cannot be set twice.");
                  }
                  _loc5_++;
                  attackTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.remainTime cannot be set twice.");
                  }
                  _loc6_++;
                  remainTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.lastHp cannot be set twice.");
                  }
                  _loc4_++;
                  lastHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

