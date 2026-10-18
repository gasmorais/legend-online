package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MountAvatarMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.campaign.AvatarInfoMsg")]
      public var avatarInfo:Array = [];
      
      private var soulScore$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      private var stamp$field:int;
      
      private var totalPage$field:int;
      
      public function MountAvatarMsg()
      {
         super();
      }
      
      public function removeSoulScore() : void
      {
         hasField$0 &= 4294967294;
         soulScore$field = new int();
      }
      
      public function get hasSoulScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set soulScore(param1:int) : void
      {
         hasField$0 |= 1;
         soulScore$field = param1;
      }
      
      public function get soulScore() : int
      {
         return soulScore$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeStamp() : void
      {
         hasField$0 &= 4294967291;
         stamp$field = new int();
      }
      
      public function get hasStamp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set stamp(param1:int) : void
      {
         hasField$0 |= 4;
         stamp$field = param1;
      }
      
      public function get stamp() : int
      {
         return stamp$field;
      }
      
      public function removeTotalPage() : void
      {
         hasField$0 &= 4294967287;
         totalPage$field = new int();
      }
      
      public function get hasTotalPage() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set totalPage(param1:int) : void
      {
         hasField$0 |= 8;
         totalPage$field = param1;
      }
      
      public function get totalPage() : int
      {
         return totalPage$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < avatarInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,avatarInfo[_loc2_]);
            _loc2_++;
         }
         if(hasSoulScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,soulScore$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasStamp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,stamp$field);
         }
         if(hasTotalPage)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,totalPage$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:AvatarInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new AvatarInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  avatarInfo.push(_loc7_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MountAvatarMsg.soulScore cannot be set twice.");
                  }
                  _loc3_++;
                  soulScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MountAvatarMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MountAvatarMsg.stamp cannot be set twice.");
                  }
                  _loc8_++;
                  stamp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MountAvatarMsg.totalPage cannot be set twice.");
                  }
                  _loc5_++;
                  totalPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

