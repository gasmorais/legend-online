package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WoundInfoMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var wound$field:Int64;
      
      private var woundAddation$field:Int64;
      
      private var job$field:int;
      
      public function WoundInfoMsg()
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
      
      public function removeWound() : void
      {
         wound$field = null;
      }
      
      public function get hasWound() : Boolean
      {
         return wound$field != null;
      }
      
      public function set wound(param1:Int64) : void
      {
         wound$field = param1;
      }
      
      public function get wound() : Int64
      {
         return wound$field;
      }
      
      public function removeWoundAddation() : void
      {
         woundAddation$field = null;
      }
      
      public function get hasWoundAddation() : Boolean
      {
         return woundAddation$field != null;
      }
      
      public function set woundAddation(param1:Int64) : void
      {
         woundAddation$field = param1;
      }
      
      public function get woundAddation() : Int64
      {
         return woundAddation$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967293;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 2;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasWound)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,wound$field);
         }
         if(hasWoundAddation)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,woundAddation$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WoundInfoMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WoundInfoMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WoundInfoMsg.wound cannot be set twice.");
                  }
                  _loc7_++;
                  wound = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WoundInfoMsg.woundAddation cannot be set twice.");
                  }
                  _loc3_++;
                  woundAddation = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WoundInfoMsg.job cannot be set twice.");
                  }
                  _loc5_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

