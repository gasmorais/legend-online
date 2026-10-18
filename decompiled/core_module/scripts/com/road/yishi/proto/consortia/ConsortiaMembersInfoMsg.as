package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaMembersInfoMsg extends Message implements IExternalizable
   {
      
      private var job$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var level$field:int;
      
      private var fight_capacity$field:int;
      
      private var user_id$field:int;
      
      private var count$field:int;
      
      private var is_received$field:Boolean;
      
      private var trans_grade$field:int;
      
      public function ConsortiaMembersInfoMsg()
      {
         super();
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967294;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 1;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967293;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 2;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967291;
         fight_capacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 4;
         fight_capacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fight_capacity$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967287;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 8;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeIsReceived() : void
      {
         hasField$0 &= 4294967263;
         is_received$field = new Boolean();
      }
      
      public function get hasIsReceived() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isReceived(param1:Boolean) : void
      {
         hasField$0 |= 32;
         is_received$field = param1;
      }
      
      public function get isReceived() : Boolean
      {
         return is_received$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 4294967231;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 64;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fight_capacity$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasIsReceived)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,is_received$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.job cannot be set twice.");
                  }
                  _loc7_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.fightCapacity cannot be set twice.");
                  }
                  _loc11_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.userId cannot be set twice.");
                  }
                  _loc8_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.isReceived cannot be set twice.");
                  }
                  _loc9_++;
                  isReceived = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaMembersInfoMsg.transGrade cannot be set twice.");
                  }
                  _loc6_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

