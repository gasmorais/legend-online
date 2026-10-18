package com.road.yishi.proto.stargazing
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StargazingInfoMsg extends Message implements IExternalizable
   {
      
      private var starDebris$field:int;
      
      private var hasField$0:uint = 0;
      
      private var starDesire$field:int;
      
      private var nomalRewardCount$field:int;
      
      private var seniorRewardCount$field:int;
      
      private var totalProperty$field:PropertyMsg;
      
      [ArrayElementType("com.road.yishi.proto.stargazing.ZodiacSignInfoMsg")]
      public var zodiacSign:Array = [];
      
      public function StargazingInfoMsg()
      {
         super();
      }
      
      public function removeStarDebris() : void
      {
         hasField$0 &= 4294967294;
         starDebris$field = new int();
      }
      
      public function get hasStarDebris() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set starDebris(param1:int) : void
      {
         hasField$0 |= 1;
         starDebris$field = param1;
      }
      
      public function get starDebris() : int
      {
         return starDebris$field;
      }
      
      public function removeStarDesire() : void
      {
         hasField$0 &= 4294967293;
         starDesire$field = new int();
      }
      
      public function get hasStarDesire() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set starDesire(param1:int) : void
      {
         hasField$0 |= 2;
         starDesire$field = param1;
      }
      
      public function get starDesire() : int
      {
         return starDesire$field;
      }
      
      public function removeNomalRewardCount() : void
      {
         hasField$0 &= 4294967291;
         nomalRewardCount$field = new int();
      }
      
      public function get hasNomalRewardCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nomalRewardCount(param1:int) : void
      {
         hasField$0 |= 4;
         nomalRewardCount$field = param1;
      }
      
      public function get nomalRewardCount() : int
      {
         return nomalRewardCount$field;
      }
      
      public function removeSeniorRewardCount() : void
      {
         hasField$0 &= 4294967287;
         seniorRewardCount$field = new int();
      }
      
      public function get hasSeniorRewardCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set seniorRewardCount(param1:int) : void
      {
         hasField$0 |= 8;
         seniorRewardCount$field = param1;
      }
      
      public function get seniorRewardCount() : int
      {
         return seniorRewardCount$field;
      }
      
      public function removeTotalProperty() : void
      {
         totalProperty$field = null;
      }
      
      public function get hasTotalProperty() : Boolean
      {
         return totalProperty$field != null;
      }
      
      public function set totalProperty(param1:PropertyMsg) : void
      {
         totalProperty$field = param1;
      }
      
      public function get totalProperty() : PropertyMsg
      {
         return totalProperty$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasStarDebris)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,starDebris$field);
         }
         if(hasStarDesire)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,starDesire$field);
         }
         if(hasNomalRewardCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,nomalRewardCount$field);
         }
         if(hasSeniorRewardCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,seniorRewardCount$field);
         }
         if(hasTotalProperty)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,totalProperty$field);
         }
         _loc2_ = 0;
         while(_loc2_ < zodiacSign.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,zodiacSign[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:ZodiacSignInfoMsg = null;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingInfoMsg.starDebris cannot be set twice.");
                  }
                  _loc8_++;
                  starDebris = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingInfoMsg.starDesire cannot be set twice.");
                  }
                  _loc5_++;
                  starDesire = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingInfoMsg.nomalRewardCount cannot be set twice.");
                  }
                  _loc9_++;
                  nomalRewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingInfoMsg.seniorRewardCount cannot be set twice.");
                  }
                  _loc3_++;
                  seniorRewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StargazingInfoMsg.totalProperty cannot be set twice.");
                  }
                  _loc6_++;
                  totalProperty = new PropertyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,totalProperty);
                  break;
               case 5:
                  _loc4_ = new ZodiacSignInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  zodiacSign.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

