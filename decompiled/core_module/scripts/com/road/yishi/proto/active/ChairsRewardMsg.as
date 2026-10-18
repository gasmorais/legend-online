package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChairsRewardMsg extends Message implements IExternalizable
   {
      
      private var cCCActiveUUID$field:String;
      
      private var uUID$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tokenChairs$field:String;
      
      private var rewardTypes$field:int;
      
      private var rewardState$field:int;
      
      private var serverName$field:String;
      
      public function ChairsRewardMsg()
      {
         super();
      }
      
      public function removeCCCActiveUUID() : void
      {
         cCCActiveUUID$field = null;
      }
      
      public function get hasCCCActiveUUID() : Boolean
      {
         return cCCActiveUUID$field != null;
      }
      
      public function set cCCActiveUUID(param1:String) : void
      {
         cCCActiveUUID$field = param1;
      }
      
      public function get cCCActiveUUID() : String
      {
         return cCCActiveUUID$field;
      }
      
      public function removeUUID() : void
      {
         uUID$field = null;
      }
      
      public function get hasUUID() : Boolean
      {
         return uUID$field != null;
      }
      
      public function set uUID(param1:String) : void
      {
         uUID$field = param1;
      }
      
      public function get uUID() : String
      {
         return uUID$field;
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
      
      public function removeTokenChairs() : void
      {
         tokenChairs$field = null;
      }
      
      public function get hasTokenChairs() : Boolean
      {
         return tokenChairs$field != null;
      }
      
      public function set tokenChairs(param1:String) : void
      {
         tokenChairs$field = param1;
      }
      
      public function get tokenChairs() : String
      {
         return tokenChairs$field;
      }
      
      public function removeRewardTypes() : void
      {
         hasField$0 &= 4294967293;
         rewardTypes$field = new int();
      }
      
      public function get hasRewardTypes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardTypes(param1:int) : void
      {
         hasField$0 |= 2;
         rewardTypes$field = param1;
      }
      
      public function get rewardTypes() : int
      {
         return rewardTypes$field;
      }
      
      public function removeRewardState() : void
      {
         hasField$0 &= 4294967291;
         rewardState$field = new int();
      }
      
      public function get hasRewardState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rewardState(param1:int) : void
      {
         hasField$0 |= 4;
         rewardState$field = param1;
      }
      
      public function get rewardState() : int
      {
         return rewardState$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCCCActiveUUID)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,cCCActiveUUID$field);
         }
         if(hasUUID)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,uUID$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasTokenChairs)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,tokenChairs$field);
         }
         if(hasRewardTypes)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rewardTypes$field);
         }
         if(hasRewardState)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rewardState$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsRewardMsg.cCCActiveUUID cannot be set twice.");
                  }
                  _loc9_++;
                  cCCActiveUUID = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsRewardMsg.uUID cannot be set twice.");
                  }
                  _loc6_++;
                  uUID = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsRewardMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsRewardMsg.tokenChairs cannot be set twice.");
                  }
                  _loc10_++;
                  tokenChairs = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsRewardMsg.rewardTypes cannot be set twice.");
                  }
                  _loc4_++;
                  rewardTypes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsRewardMsg.rewardState cannot be set twice.");
                  }
                  _loc5_++;
                  rewardState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChairsRewardMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

