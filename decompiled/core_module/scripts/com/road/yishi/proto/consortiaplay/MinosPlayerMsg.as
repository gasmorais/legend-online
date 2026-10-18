package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MinosPlayerMsg extends Message implements IExternalizable
   {
      
      private var challengeCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var buyCount$field:int;
      
      private var levelRewardInfo$field:String;
      
      private var featRewardInfo$field:String;
      
      private var feat$field:int;
      
      public function MinosPlayerMsg()
      {
         super();
      }
      
      public function removeChallengeCount() : void
      {
         hasField$0 &= 4294967294;
         challengeCount$field = new int();
      }
      
      public function get hasChallengeCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set challengeCount(param1:int) : void
      {
         hasField$0 |= 1;
         challengeCount$field = param1;
      }
      
      public function get challengeCount() : int
      {
         return challengeCount$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967293;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 2;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeLevelRewardInfo() : void
      {
         levelRewardInfo$field = null;
      }
      
      public function get hasLevelRewardInfo() : Boolean
      {
         return levelRewardInfo$field != null;
      }
      
      public function set levelRewardInfo(param1:String) : void
      {
         levelRewardInfo$field = param1;
      }
      
      public function get levelRewardInfo() : String
      {
         return levelRewardInfo$field;
      }
      
      public function removeFeatRewardInfo() : void
      {
         featRewardInfo$field = null;
      }
      
      public function get hasFeatRewardInfo() : Boolean
      {
         return featRewardInfo$field != null;
      }
      
      public function set featRewardInfo(param1:String) : void
      {
         featRewardInfo$field = param1;
      }
      
      public function get featRewardInfo() : String
      {
         return featRewardInfo$field;
      }
      
      public function removeFeat() : void
      {
         hasField$0 &= 4294967291;
         feat$field = new int();
      }
      
      public function get hasFeat() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set feat(param1:int) : void
      {
         hasField$0 |= 4;
         feat$field = param1;
      }
      
      public function get feat() : int
      {
         return feat$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChallengeCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,challengeCount$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasLevelRewardInfo)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,levelRewardInfo$field);
         }
         if(hasFeatRewardInfo)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,featRewardInfo$field);
         }
         if(hasFeat)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,feat$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MinosPlayerMsg.challengeCount cannot be set twice.");
                  }
                  _loc4_++;
                  challengeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MinosPlayerMsg.buyCount cannot be set twice.");
                  }
                  _loc5_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MinosPlayerMsg.levelRewardInfo cannot be set twice.");
                  }
                  _loc6_++;
                  levelRewardInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MinosPlayerMsg.featRewardInfo cannot be set twice.");
                  }
                  _loc8_++;
                  featRewardInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MinosPlayerMsg.feat cannot be set twice.");
                  }
                  _loc3_++;
                  feat = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

