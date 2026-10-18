package com.road.yishi.proto.children
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HomeMsg extends Message implements IExternalizable
   {
      
      private var home_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId_a$field:int;
      
      private var userId_b$field:int;
      
      private var courtyardGarde$field:int;
      
      private var houseGrade$field:int;
      
      private var state$field:int;
      
      [ArrayElementType("com.road.yishi.proto.children.FurnitureMsg")]
      public var furniture:Array = [];
      
      private var random_id$field:int;
      
      private var cour_userid$field:int;
      
      private var cour_nickname$field:String;
      
      private var house_userid$field:int;
      
      private var house_nickname$field:String;
      
      private var tar_user_id$field:int;
      
      private var is_refresh$field:Boolean;
      
      [ArrayElementType("com.road.yishi.proto.children.FurnitureMsg")]
      public var courFurniture:Array = [];
      
      private var is_get$field:Boolean;
      
      private var is_big_bonfire$field:Boolean;
      
      private var cleanness$field:int;
      
      private var maidExpireDate$field:String;
      
      private var today_bonfire_count$field:int;
      
      [ArrayElementType("com.road.yishi.proto.children.ShowMountMsg")]
      public var showMount:Array = [];
      
      private var leftTime$field:int;
      
      private var beginLeftTime$field:int;
      
      public function HomeMsg()
      {
         super();
      }
      
      public function removeHomeId() : void
      {
         hasField$0 &= 4294967294;
         home_id$field = new int();
      }
      
      public function get hasHomeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set homeId(param1:int) : void
      {
         hasField$0 |= 1;
         home_id$field = param1;
      }
      
      public function get homeId() : int
      {
         return home_id$field;
      }
      
      public function removeUserIdA() : void
      {
         hasField$0 &= 4294967293;
         userId_a$field = new int();
      }
      
      public function get hasUserIdA() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userIdA(param1:int) : void
      {
         hasField$0 |= 2;
         userId_a$field = param1;
      }
      
      public function get userIdA() : int
      {
         return userId_a$field;
      }
      
      public function removeUserIdB() : void
      {
         hasField$0 &= 4294967291;
         userId_b$field = new int();
      }
      
      public function get hasUserIdB() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userIdB(param1:int) : void
      {
         hasField$0 |= 4;
         userId_b$field = param1;
      }
      
      public function get userIdB() : int
      {
         return userId_b$field;
      }
      
      public function removeCourtyardGarde() : void
      {
         hasField$0 &= 4294967287;
         courtyardGarde$field = new int();
      }
      
      public function get hasCourtyardGarde() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set courtyardGarde(param1:int) : void
      {
         hasField$0 |= 8;
         courtyardGarde$field = param1;
      }
      
      public function get courtyardGarde() : int
      {
         return courtyardGarde$field;
      }
      
      public function removeHouseGrade() : void
      {
         hasField$0 &= 4294967279;
         houseGrade$field = new int();
      }
      
      public function get hasHouseGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set houseGrade(param1:int) : void
      {
         hasField$0 |= 16;
         houseGrade$field = param1;
      }
      
      public function get houseGrade() : int
      {
         return houseGrade$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967263;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 32;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeRandomId() : void
      {
         hasField$0 &= 4294967231;
         random_id$field = new int();
      }
      
      public function get hasRandomId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set randomId(param1:int) : void
      {
         hasField$0 |= 64;
         random_id$field = param1;
      }
      
      public function get randomId() : int
      {
         return random_id$field;
      }
      
      public function removeCourUserid() : void
      {
         hasField$0 &= 4294967167;
         cour_userid$field = new int();
      }
      
      public function get hasCourUserid() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set courUserid(param1:int) : void
      {
         hasField$0 |= 128;
         cour_userid$field = param1;
      }
      
      public function get courUserid() : int
      {
         return cour_userid$field;
      }
      
      public function removeCourNickname() : void
      {
         cour_nickname$field = null;
      }
      
      public function get hasCourNickname() : Boolean
      {
         return cour_nickname$field != null;
      }
      
      public function set courNickname(param1:String) : void
      {
         cour_nickname$field = param1;
      }
      
      public function get courNickname() : String
      {
         return cour_nickname$field;
      }
      
      public function removeHouseUserid() : void
      {
         hasField$0 &= 4294967039;
         house_userid$field = new int();
      }
      
      public function get hasHouseUserid() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set houseUserid(param1:int) : void
      {
         hasField$0 |= 256;
         house_userid$field = param1;
      }
      
      public function get houseUserid() : int
      {
         return house_userid$field;
      }
      
      public function removeHouseNickname() : void
      {
         house_nickname$field = null;
      }
      
      public function get hasHouseNickname() : Boolean
      {
         return house_nickname$field != null;
      }
      
      public function set houseNickname(param1:String) : void
      {
         house_nickname$field = param1;
      }
      
      public function get houseNickname() : String
      {
         return house_nickname$field;
      }
      
      public function removeTarUserId() : void
      {
         hasField$0 &= 4294966783;
         tar_user_id$field = new int();
      }
      
      public function get hasTarUserId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set tarUserId(param1:int) : void
      {
         hasField$0 |= 512;
         tar_user_id$field = param1;
      }
      
      public function get tarUserId() : int
      {
         return tar_user_id$field;
      }
      
      public function removeIsRefresh() : void
      {
         hasField$0 &= 4294966271;
         is_refresh$field = new Boolean();
      }
      
      public function get hasIsRefresh() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isRefresh(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         is_refresh$field = param1;
      }
      
      public function get isRefresh() : Boolean
      {
         return is_refresh$field;
      }
      
      public function removeIsGet() : void
      {
         hasField$0 &= 4294965247;
         is_get$field = new Boolean();
      }
      
      public function get hasIsGet() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isGet(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         is_get$field = param1;
      }
      
      public function get isGet() : Boolean
      {
         return is_get$field;
      }
      
      public function removeIsBigBonfire() : void
      {
         hasField$0 &= 4294963199;
         is_big_bonfire$field = new Boolean();
      }
      
      public function get hasIsBigBonfire() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isBigBonfire(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         is_big_bonfire$field = param1;
      }
      
      public function get isBigBonfire() : Boolean
      {
         return is_big_bonfire$field;
      }
      
      public function removeCleanness() : void
      {
         hasField$0 &= 4294959103;
         cleanness$field = new int();
      }
      
      public function get hasCleanness() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set cleanness(param1:int) : void
      {
         hasField$0 |= 8192;
         cleanness$field = param1;
      }
      
      public function get cleanness() : int
      {
         return cleanness$field;
      }
      
      public function removeMaidExpireDate() : void
      {
         maidExpireDate$field = null;
      }
      
      public function get hasMaidExpireDate() : Boolean
      {
         return maidExpireDate$field != null;
      }
      
      public function set maidExpireDate(param1:String) : void
      {
         maidExpireDate$field = param1;
      }
      
      public function get maidExpireDate() : String
      {
         return maidExpireDate$field;
      }
      
      public function removeTodayBonfireCount() : void
      {
         hasField$0 &= 4294950911;
         today_bonfire_count$field = new int();
      }
      
      public function get hasTodayBonfireCount() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set todayBonfireCount(param1:int) : void
      {
         hasField$0 |= 16384;
         today_bonfire_count$field = param1;
      }
      
      public function get todayBonfireCount() : int
      {
         return today_bonfire_count$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294934527;
         leftTime$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 32768;
         leftTime$field = param1;
      }
      
      public function get leftTime() : int
      {
         return leftTime$field;
      }
      
      public function removeBeginLeftTime() : void
      {
         hasField$0 &= 4294901759;
         beginLeftTime$field = new int();
      }
      
      public function get hasBeginLeftTime() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set beginLeftTime(param1:int) : void
      {
         hasField$0 |= 65536;
         beginLeftTime$field = param1;
      }
      
      public function get beginLeftTime() : int
      {
         return beginLeftTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         if(hasHomeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,home_id$field);
         }
         if(hasUserIdA)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId_a$field);
         }
         if(hasUserIdB)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId_b$field);
         }
         if(hasCourtyardGarde)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,courtyardGarde$field);
         }
         if(hasHouseGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,houseGrade$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         _loc3_ = 0;
         while(_loc3_ < furniture.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,furniture[_loc3_]);
            _loc3_++;
         }
         if(hasRandomId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,random_id$field);
         }
         if(hasCourUserid)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,cour_userid$field);
         }
         if(hasCourNickname)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,cour_nickname$field);
         }
         if(hasHouseUserid)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,house_userid$field);
         }
         if(hasHouseNickname)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,house_nickname$field);
         }
         if(hasTarUserId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,tar_user_id$field);
         }
         if(hasIsRefresh)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,is_refresh$field);
         }
         _loc4_ = 0;
         while(_loc4_ < courFurniture.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,courFurniture[_loc4_]);
            _loc4_++;
         }
         if(hasIsGet)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,is_get$field);
         }
         if(hasIsBigBonfire)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,is_big_bonfire$field);
         }
         if(hasCleanness)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,cleanness$field);
         }
         if(hasMaidExpireDate)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_STRING(param1,maidExpireDate$field);
         }
         if(hasTodayBonfireCount)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,today_bonfire_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < showMount.length)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_MESSAGE(param1,showMount[_loc2_]);
            _loc2_++;
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,leftTime$field);
         }
         if(hasBeginLeftTime)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,beginLeftTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc13_:FurnitureMsg = null;
         var _loc6_:FurnitureMsg = null;
         var _loc14_:ShowMountMsg = null;
         var _loc4_:uint = 0;
         var _loc20_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc22_:uint = 0;
         var _loc16_:uint = 0;
         var _loc21_:uint = 0;
         var _loc18_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc25_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc24_:uint = 0;
         var _loc19_:uint = 0;
         var _loc23_:uint = 0;
         var _loc12_:uint = 0;
         var _loc26_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.homeId cannot be set twice.");
                  }
                  _loc4_++;
                  homeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.userIdA cannot be set twice.");
                  }
                  _loc20_++;
                  userIdA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.userIdB cannot be set twice.");
                  }
                  _loc11_++;
                  userIdB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.courtyardGarde cannot be set twice.");
                  }
                  _loc5_++;
                  courtyardGarde = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.houseGrade cannot be set twice.");
                  }
                  _loc22_++;
                  houseGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.state cannot be set twice.");
                  }
                  _loc16_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc13_ = new FurnitureMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  furniture.push(_loc13_);
                  break;
               case 8:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.randomId cannot be set twice.");
                  }
                  _loc21_++;
                  randomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.courUserid cannot be set twice.");
                  }
                  _loc18_++;
                  courUserid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.courNickname cannot be set twice.");
                  }
                  _loc7_++;
                  courNickname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.houseUserid cannot be set twice.");
                  }
                  _loc15_++;
                  houseUserid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.houseNickname cannot be set twice.");
                  }
                  _loc25_++;
                  houseNickname = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.tarUserId cannot be set twice.");
                  }
                  _loc3_++;
                  tarUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.isRefresh cannot be set twice.");
                  }
                  _loc8_++;
                  isRefresh = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  _loc6_ = new FurnitureMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  courFurniture.push(_loc6_);
                  break;
               case 16:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.isGet cannot be set twice.");
                  }
                  _loc10_++;
                  isGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.isBigBonfire cannot be set twice.");
                  }
                  _loc24_++;
                  isBigBonfire = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.cleanness cannot be set twice.");
                  }
                  _loc19_++;
                  cleanness = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.maidExpireDate cannot be set twice.");
                  }
                  _loc23_++;
                  maidExpireDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 20:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.todayBonfireCount cannot be set twice.");
                  }
                  _loc12_++;
                  todayBonfireCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  _loc14_ = new ShowMountMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  showMount.push(_loc14_);
                  break;
               case 22:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.leftTime cannot be set twice.");
                  }
                  _loc26_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HomeMsg.beginLeftTime cannot be set twice.");
                  }
                  _loc9_++;
                  beginLeftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

