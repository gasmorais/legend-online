package com.road.yishi.proto.giftparty
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TeamMemberInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var fragQuality$field:int;
      
      private var fragLevel$field:int;
      
      private var placeState$field:int;
      
      public function TeamMemberInfoMsg()
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
      
      public function removeFragQuality() : void
      {
         hasField$0 &= 4294967293;
         fragQuality$field = new int();
      }
      
      public function get hasFragQuality() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fragQuality(param1:int) : void
      {
         hasField$0 |= 2;
         fragQuality$field = param1;
      }
      
      public function get fragQuality() : int
      {
         return fragQuality$field;
      }
      
      public function removeFragLevel() : void
      {
         hasField$0 &= 4294967291;
         fragLevel$field = new int();
      }
      
      public function get hasFragLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fragLevel(param1:int) : void
      {
         hasField$0 |= 4;
         fragLevel$field = param1;
      }
      
      public function get fragLevel() : int
      {
         return fragLevel$field;
      }
      
      public function removePlaceState() : void
      {
         hasField$0 &= 4294967287;
         placeState$field = new int();
      }
      
      public function get hasPlaceState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set placeState(param1:int) : void
      {
         hasField$0 |= 8;
         placeState$field = param1;
      }
      
      public function get placeState() : int
      {
         return placeState$field;
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
         if(hasFragQuality)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fragQuality$field);
         }
         if(hasFragLevel)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fragLevel$field);
         }
         if(hasPlaceState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,placeState$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TeamMemberInfoMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TeamMemberInfoMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TeamMemberInfoMsg.fragQuality cannot be set twice.");
                  }
                  _loc4_++;
                  fragQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TeamMemberInfoMsg.fragLevel cannot be set twice.");
                  }
                  _loc6_++;
                  fragLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TeamMemberInfoMsg.placeState cannot be set twice.");
                  }
                  _loc8_++;
                  placeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

