package com.road.yishi.proto.remotepet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendPetMsg extends Message implements IExternalizable
   {
      
      private var friendId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var petId$field:int;
      
      private var petFight$field:int;
      
      private var petQuality$field:int;
      
      private var petType$field:int;
      
      private var petName$field:String;
      
      private var friendName$field:String;
      
      public function FriendPetMsg()
      {
         super();
      }
      
      public function removeFriendId() : void
      {
         hasField$0 &= 4294967294;
         friendId$field = new int();
      }
      
      public function get hasFriendId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set friendId(param1:int) : void
      {
         hasField$0 |= 1;
         friendId$field = param1;
      }
      
      public function get friendId() : int
      {
         return friendId$field;
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967293;
         petId$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 2;
         petId$field = param1;
      }
      
      public function get petId() : int
      {
         return petId$field;
      }
      
      public function removePetFight() : void
      {
         hasField$0 &= 4294967291;
         petFight$field = new int();
      }
      
      public function get hasPetFight() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set petFight(param1:int) : void
      {
         hasField$0 |= 4;
         petFight$field = param1;
      }
      
      public function get petFight() : int
      {
         return petFight$field;
      }
      
      public function removePetQuality() : void
      {
         hasField$0 &= 4294967287;
         petQuality$field = new int();
      }
      
      public function get hasPetQuality() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set petQuality(param1:int) : void
      {
         hasField$0 |= 8;
         petQuality$field = param1;
      }
      
      public function get petQuality() : int
      {
         return petQuality$field;
      }
      
      public function removePetType() : void
      {
         hasField$0 &= 4294967279;
         petType$field = new int();
      }
      
      public function get hasPetType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set petType(param1:int) : void
      {
         hasField$0 |= 16;
         petType$field = param1;
      }
      
      public function get petType() : int
      {
         return petType$field;
      }
      
      public function removePetName() : void
      {
         petName$field = null;
      }
      
      public function get hasPetName() : Boolean
      {
         return petName$field != null;
      }
      
      public function set petName(param1:String) : void
      {
         petName$field = param1;
      }
      
      public function get petName() : String
      {
         return petName$field;
      }
      
      public function removeFriendName() : void
      {
         friendName$field = null;
      }
      
      public function get hasFriendName() : Boolean
      {
         return friendName$field != null;
      }
      
      public function set friendName(param1:String) : void
      {
         friendName$field = param1;
      }
      
      public function get friendName() : String
      {
         return friendName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFriendId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,friendId$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,petId$field);
         }
         if(hasPetFight)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,petFight$field);
         }
         if(hasPetQuality)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,petQuality$field);
         }
         if(hasPetType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,petType$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,petName$field);
         }
         if(hasFriendName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,friendName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPetMsg.friendId cannot be set twice.");
                  }
                  _loc7_++;
                  friendId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPetMsg.petId cannot be set twice.");
                  }
                  _loc4_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPetMsg.petFight cannot be set twice.");
                  }
                  _loc3_++;
                  petFight = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPetMsg.petQuality cannot be set twice.");
                  }
                  _loc8_++;
                  petQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPetMsg.petType cannot be set twice.");
                  }
                  _loc10_++;
                  petType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPetMsg.petName cannot be set twice.");
                  }
                  _loc6_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendPetMsg.friendName cannot be set twice.");
                  }
                  _loc5_++;
                  friendName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

