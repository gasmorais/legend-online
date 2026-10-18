package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AvatarInfoMsg extends Message implements IExternalizable
   {
      
      private var mount_tempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var is_exist$field:Boolean;
      
      private var expair_date$field:String;
      
      private var active_date$field:String;
      
      private var validity$field:int;
      
      private var star_level$field:int;
      
      private var blessing$field:int;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var is_buy_fly$field:Boolean;
      
      public function AvatarInfoMsg()
      {
         super();
      }
      
      public function removeMountTempId() : void
      {
         hasField$0 &= 4294967294;
         mount_tempId$field = new int();
      }
      
      public function get hasMountTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mountTempId(param1:int) : void
      {
         hasField$0 |= 1;
         mount_tempId$field = param1;
      }
      
      public function get mountTempId() : int
      {
         return mount_tempId$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967293;
         is_exist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_exist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return is_exist$field;
      }
      
      public function removeExpairDate() : void
      {
         expair_date$field = null;
      }
      
      public function get hasExpairDate() : Boolean
      {
         return expair_date$field != null;
      }
      
      public function set expairDate(param1:String) : void
      {
         expair_date$field = param1;
      }
      
      public function get expairDate() : String
      {
         return expair_date$field;
      }
      
      public function removeActiveDate() : void
      {
         active_date$field = null;
      }
      
      public function get hasActiveDate() : Boolean
      {
         return active_date$field != null;
      }
      
      public function set activeDate(param1:String) : void
      {
         active_date$field = param1;
      }
      
      public function get activeDate() : String
      {
         return active_date$field;
      }
      
      public function removeValidity() : void
      {
         hasField$0 &= 4294967291;
         validity$field = new int();
      }
      
      public function get hasValidity() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set validity(param1:int) : void
      {
         hasField$0 |= 4;
         validity$field = param1;
      }
      
      public function get validity() : int
      {
         return validity$field;
      }
      
      public function removeStarLevel() : void
      {
         hasField$0 &= 4294967287;
         star_level$field = new int();
      }
      
      public function get hasStarLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set starLevel(param1:int) : void
      {
         hasField$0 |= 8;
         star_level$field = param1;
      }
      
      public function get starLevel() : int
      {
         return star_level$field;
      }
      
      public function removeBlessing() : void
      {
         hasField$0 &= 4294967279;
         blessing$field = new int();
      }
      
      public function get hasBlessing() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set blessing(param1:int) : void
      {
         hasField$0 |= 16;
         blessing$field = param1;
      }
      
      public function get blessing() : int
      {
         return blessing$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967263;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 32;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967231;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 64;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeIsBuyFly() : void
      {
         hasField$0 &= 4294967167;
         is_buy_fly$field = new Boolean();
      }
      
      public function get hasIsBuyFly() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isBuyFly(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_buy_fly$field = param1;
      }
      
      public function get isBuyFly() : Boolean
      {
         return is_buy_fly$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMountTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mount_tempId$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,is_exist$field);
         }
         if(hasExpairDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,expair_date$field);
         }
         if(hasActiveDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,active_date$field);
         }
         if(hasValidity)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,validity$field);
         }
         if(hasStarLevel)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,star_level$field);
         }
         if(hasBlessing)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,blessing$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasIsBuyFly)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,is_buy_fly$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.mountTempId cannot be set twice.");
                  }
                  _loc12_++;
                  mountTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.isExist cannot be set twice.");
                  }
                  _loc4_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.expairDate cannot be set twice.");
                  }
                  _loc11_++;
                  expairDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.activeDate cannot be set twice.");
                  }
                  _loc6_++;
                  activeDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.validity cannot be set twice.");
                  }
                  _loc7_++;
                  validity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.starLevel cannot be set twice.");
                  }
                  _loc8_++;
                  starLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.blessing cannot be set twice.");
                  }
                  _loc9_++;
                  blessing = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.param2 cannot be set twice.");
                  }
                  _loc13_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AvatarInfoMsg.isBuyFly cannot be set twice.");
                  }
                  _loc3_++;
                  isBuyFly = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

