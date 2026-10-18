package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EggTempMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tempId$field:int;
      
      private var count$field:int;
      
      private var profile$field:int;
      
      private var isShow$field:Boolean;
      
      private var types$field:int;
      
      private var rewardScore$field:int;
      
      public function EggTempMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967293;
         tempId$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 2;
         tempId$field = param1;
      }
      
      public function get tempId() : int
      {
         return tempId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeProfile() : void
      {
         hasField$0 &= 4294967287;
         profile$field = new int();
      }
      
      public function get hasProfile() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set profile(param1:int) : void
      {
         hasField$0 |= 8;
         profile$field = param1;
      }
      
      public function get profile() : int
      {
         return profile$field;
      }
      
      public function removeIsShow() : void
      {
         hasField$0 &= 4294967279;
         isShow$field = new Boolean();
      }
      
      public function get hasIsShow() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isShow$field = param1;
      }
      
      public function get isShow() : Boolean
      {
         return isShow$field;
      }
      
      public function removeTypes() : void
      {
         hasField$0 &= 4294967263;
         types$field = new int();
      }
      
      public function get hasTypes() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set types(param1:int) : void
      {
         hasField$0 |= 32;
         types$field = param1;
      }
      
      public function get types() : int
      {
         return types$field;
      }
      
      public function removeRewardScore() : void
      {
         hasField$0 &= 4294967231;
         rewardScore$field = new int();
      }
      
      public function get hasRewardScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set rewardScore(param1:int) : void
      {
         hasField$0 |= 64;
         rewardScore$field = param1;
      }
      
      public function get rewardScore() : int
      {
         return rewardScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tempId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasProfile)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,profile$field);
         }
         if(hasIsShow)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isShow$field);
         }
         if(hasTypes)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,types$field);
         }
         if(hasRewardScore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,rewardScore$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EggTempMsg.id cannot be set twice.");
                  }
                  _loc8_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EggTempMsg.tempId cannot be set twice.");
                  }
                  _loc5_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EggTempMsg.count cannot be set twice.");
                  }
                  _loc6_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EggTempMsg.profile cannot be set twice.");
                  }
                  _loc4_++;
                  profile = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EggTempMsg.isShow cannot be set twice.");
                  }
                  _loc3_++;
                  isShow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EggTempMsg.types cannot be set twice.");
                  }
                  _loc7_++;
                  types = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: EggTempMsg.rewardScore cannot be set twice.");
                  }
                  _loc10_++;
                  rewardScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

