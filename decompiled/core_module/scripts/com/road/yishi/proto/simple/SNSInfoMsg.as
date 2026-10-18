package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SNSInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_id$field:int;
      
      private var nickname$field:String;
      
      private var sign_desc$field:String;
      
      private var sex$field:int;
      
      private var birthday_type$field:int;
      
      private var birth_year$field:int;
      
      private var birth_month$field:int;
      
      private var birth_day$field:int;
      
      private var star_id$field:int;
      
      private var blood_type$field:int;
      
      private var country$field:int;
      
      private var province$field:int;
      
      private var city$field:int;
      
      private var head_id$field:int;
      
      private var job$field:int;
      
      public function SNSInfoMsg()
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeNickname() : void
      {
         nickname$field = null;
      }
      
      public function get hasNickname() : Boolean
      {
         return nickname$field != null;
      }
      
      public function set nickname(param1:String) : void
      {
         nickname$field = param1;
      }
      
      public function get nickname() : String
      {
         return nickname$field;
      }
      
      public function removeSignDesc() : void
      {
         sign_desc$field = null;
      }
      
      public function get hasSignDesc() : Boolean
      {
         return sign_desc$field != null;
      }
      
      public function set signDesc(param1:String) : void
      {
         sign_desc$field = param1;
      }
      
      public function get signDesc() : String
      {
         return sign_desc$field;
      }
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967291;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 4;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeBirthdayType() : void
      {
         hasField$0 &= 4294967287;
         birthday_type$field = new int();
      }
      
      public function get hasBirthdayType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set birthdayType(param1:int) : void
      {
         hasField$0 |= 8;
         birthday_type$field = param1;
      }
      
      public function get birthdayType() : int
      {
         return birthday_type$field;
      }
      
      public function removeBirthYear() : void
      {
         hasField$0 &= 4294967279;
         birth_year$field = new int();
      }
      
      public function get hasBirthYear() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set birthYear(param1:int) : void
      {
         hasField$0 |= 16;
         birth_year$field = param1;
      }
      
      public function get birthYear() : int
      {
         return birth_year$field;
      }
      
      public function removeBirthMonth() : void
      {
         hasField$0 &= 4294967263;
         birth_month$field = new int();
      }
      
      public function get hasBirthMonth() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set birthMonth(param1:int) : void
      {
         hasField$0 |= 32;
         birth_month$field = param1;
      }
      
      public function get birthMonth() : int
      {
         return birth_month$field;
      }
      
      public function removeBirthDay() : void
      {
         hasField$0 &= 4294967231;
         birth_day$field = new int();
      }
      
      public function get hasBirthDay() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set birthDay(param1:int) : void
      {
         hasField$0 |= 64;
         birth_day$field = param1;
      }
      
      public function get birthDay() : int
      {
         return birth_day$field;
      }
      
      public function removeStarId() : void
      {
         hasField$0 &= 4294967167;
         star_id$field = new int();
      }
      
      public function get hasStarId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set starId(param1:int) : void
      {
         hasField$0 |= 128;
         star_id$field = param1;
      }
      
      public function get starId() : int
      {
         return star_id$field;
      }
      
      public function removeBloodType() : void
      {
         hasField$0 &= 4294967039;
         blood_type$field = new int();
      }
      
      public function get hasBloodType() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set bloodType(param1:int) : void
      {
         hasField$0 |= 256;
         blood_type$field = param1;
      }
      
      public function get bloodType() : int
      {
         return blood_type$field;
      }
      
      public function removeCountry() : void
      {
         hasField$0 &= 4294966783;
         country$field = new int();
      }
      
      public function get hasCountry() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set country(param1:int) : void
      {
         hasField$0 |= 512;
         country$field = param1;
      }
      
      public function get country() : int
      {
         return country$field;
      }
      
      public function removeProvince() : void
      {
         hasField$0 &= 4294966271;
         province$field = new int();
      }
      
      public function get hasProvince() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set province(param1:int) : void
      {
         hasField$0 |= 1024;
         province$field = param1;
      }
      
      public function get province() : int
      {
         return province$field;
      }
      
      public function removeCity() : void
      {
         hasField$0 &= 4294965247;
         city$field = new int();
      }
      
      public function get hasCity() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set city(param1:int) : void
      {
         hasField$0 |= 2048;
         city$field = param1;
      }
      
      public function get city() : int
      {
         return city$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294963199;
         head_id$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 4096;
         head_id$field = param1;
      }
      
      public function get headId() : int
      {
         return head_id$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294959103;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 8192;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickname)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nickname$field);
         }
         if(hasSignDesc)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,sign_desc$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasBirthdayType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,birthday_type$field);
         }
         if(hasBirthYear)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,birth_year$field);
         }
         if(hasBirthMonth)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,birth_month$field);
         }
         if(hasBirthDay)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,birth_day$field);
         }
         if(hasStarId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,star_id$field);
         }
         if(hasBloodType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,blood_type$field);
         }
         if(hasCountry)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,country$field);
         }
         if(hasProvince)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,province$field);
         }
         if(hasCity)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,city$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,head_id$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc18_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc16_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc19_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.userId cannot be set twice.");
                  }
                  _loc15_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.nickname cannot be set twice.");
                  }
                  _loc3_++;
                  nickname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.signDesc cannot be set twice.");
                  }
                  _loc11_++;
                  signDesc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.sex cannot be set twice.");
                  }
                  _loc6_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.birthdayType cannot be set twice.");
                  }
                  _loc18_++;
                  birthdayType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.birthYear cannot be set twice.");
                  }
                  _loc9_++;
                  birthYear = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.birthMonth cannot be set twice.");
                  }
                  _loc12_++;
                  birthMonth = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.birthDay cannot be set twice.");
                  }
                  _loc7_++;
                  birthDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.starId cannot be set twice.");
                  }
                  _loc10_++;
                  starId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.bloodType cannot be set twice.");
                  }
                  _loc16_++;
                  bloodType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.country cannot be set twice.");
                  }
                  _loc13_++;
                  country = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.province cannot be set twice.");
                  }
                  _loc4_++;
                  province = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.city cannot be set twice.");
                  }
                  _loc19_++;
                  city = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.headId cannot be set twice.");
                  }
                  _loc8_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SNSInfoMsg.job cannot be set twice.");
                  }
                  _loc14_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

