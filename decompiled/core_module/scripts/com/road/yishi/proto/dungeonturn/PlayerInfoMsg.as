package com.road.yishi.proto.dungeonturn
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var hpPercent$field:int;
      
      private var headId$field:int;
      
      public function PlayerInfoMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeHpPercent() : void
      {
         hasField$0 &= 4294967293;
         hpPercent$field = new int();
      }
      
      public function get hasHpPercent() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hpPercent(param1:int) : void
      {
         hasField$0 |= 2;
         hpPercent$field = param1;
      }
      
      public function get hpPercent() : int
      {
         return hpPercent$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967291;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 4;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasHpPercent)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,hpPercent$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoMsg.hpPercent cannot be set twice.");
                  }
                  _loc3_++;
                  hpPercent = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoMsg.headId cannot be set twice.");
                  }
                  _loc5_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

