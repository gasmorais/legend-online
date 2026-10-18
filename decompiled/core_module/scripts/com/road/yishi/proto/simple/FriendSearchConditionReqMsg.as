package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendSearchConditionReqMsg extends Message implements IExternalizable
   {
      
      private var page_index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sex$field:int;
      
      private var birth_month$field:int;
      
      private var birth_day$field:int;
      
      private var star_id$field:int;
      
      private var blood_type$field:int;
      
      private var country$field:int;
      
      private var province$field:int;
      
      private var city$field:int;
      
      public function FriendSearchConditionReqMsg()
      {
         super();
      }
      
      public function removePageIndex() : void
      {
         hasField$0 &= 4294967294;
         page_index$field = new int();
      }
      
      public function get hasPageIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set pageIndex(param1:int) : void
      {
         hasField$0 |= 1;
         page_index$field = param1;
      }
      
      public function get pageIndex() : int
      {
         return page_index$field;
      }
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967293;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 2;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeBirthMonth() : void
      {
         hasField$0 &= 4294967291;
         birth_month$field = new int();
      }
      
      public function get hasBirthMonth() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set birthMonth(param1:int) : void
      {
         hasField$0 |= 4;
         birth_month$field = param1;
      }
      
      public function get birthMonth() : int
      {
         return birth_month$field;
      }
      
      public function removeBirthDay() : void
      {
         hasField$0 &= 4294967287;
         birth_day$field = new int();
      }
      
      public function get hasBirthDay() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set birthDay(param1:int) : void
      {
         hasField$0 |= 8;
         birth_day$field = param1;
      }
      
      public function get birthDay() : int
      {
         return birth_day$field;
      }
      
      public function removeStarId() : void
      {
         hasField$0 &= 4294967279;
         star_id$field = new int();
      }
      
      public function get hasStarId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set starId(param1:int) : void
      {
         hasField$0 |= 16;
         star_id$field = param1;
      }
      
      public function get starId() : int
      {
         return star_id$field;
      }
      
      public function removeBloodType() : void
      {
         hasField$0 &= 4294967263;
         blood_type$field = new int();
      }
      
      public function get hasBloodType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bloodType(param1:int) : void
      {
         hasField$0 |= 32;
         blood_type$field = param1;
      }
      
      public function get bloodType() : int
      {
         return blood_type$field;
      }
      
      public function removeCountry() : void
      {
         hasField$0 &= 4294967231;
         country$field = new int();
      }
      
      public function get hasCountry() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set country(param1:int) : void
      {
         hasField$0 |= 64;
         country$field = param1;
      }
      
      public function get country() : int
      {
         return country$field;
      }
      
      public function removeProvince() : void
      {
         hasField$0 &= 4294967167;
         province$field = new int();
      }
      
      public function get hasProvince() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set province(param1:int) : void
      {
         hasField$0 |= 128;
         province$field = param1;
      }
      
      public function get province() : int
      {
         return province$field;
      }
      
      public function removeCity() : void
      {
         hasField$0 &= 4294967039;
         city$field = new int();
      }
      
      public function get hasCity() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set city(param1:int) : void
      {
         hasField$0 |= 256;
         city$field = param1;
      }
      
      public function get city() : int
      {
         return city$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPageIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,page_index$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasBirthMonth)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,birth_month$field);
         }
         if(hasBirthDay)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,birth_day$field);
         }
         if(hasStarId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,star_id$field);
         }
         if(hasBloodType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,blood_type$field);
         }
         if(hasCountry)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,country$field);
         }
         if(hasProvince)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,province$field);
         }
         if(hasCity)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,city$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.pageIndex cannot be set twice.");
                  }
                  _loc3_++;
                  pageIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.sex cannot be set twice.");
                  }
                  _loc5_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.birthMonth cannot be set twice.");
                  }
                  _loc6_++;
                  birthMonth = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.birthDay cannot be set twice.");
                  }
                  _loc9_++;
                  birthDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.starId cannot be set twice.");
                  }
                  _loc12_++;
                  starId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.bloodType cannot be set twice.");
                  }
                  _loc8_++;
                  bloodType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.country cannot be set twice.");
                  }
                  _loc7_++;
                  country = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.province cannot be set twice.");
                  }
                  _loc4_++;
                  province = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FriendSearchConditionReqMsg.city cannot be set twice.");
                  }
                  _loc11_++;
                  city = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

