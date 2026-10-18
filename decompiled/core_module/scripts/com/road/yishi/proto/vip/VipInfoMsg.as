package com.road.yishi.proto.vip
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VipInfoMsg extends Message implements IExternalizable
   {
      
      private var is_vip$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var vip_gp$field:int;
      
      private var vip_grade$field:int;
      
      private var expirt_date$field:String;
      
      private var is_takeGift$field:Boolean;
      
      private var vip_type$field:int;
      
      private var is_expirt$field:Boolean;
      
      private var take_giftDate$field:String;
      
      public function VipInfoMsg()
      {
         super();
      }
      
      public function removeIsVip() : void
      {
         hasField$0 &= 4294967294;
         is_vip$field = new Boolean();
      }
      
      public function get hasIsVip() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isVip(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_vip$field = param1;
      }
      
      public function get isVip() : Boolean
      {
         return is_vip$field;
      }
      
      public function removeVipGp() : void
      {
         hasField$0 &= 4294967293;
         vip_gp$field = new int();
      }
      
      public function get hasVipGp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set vipGp(param1:int) : void
      {
         hasField$0 |= 2;
         vip_gp$field = param1;
      }
      
      public function get vipGp() : int
      {
         return vip_gp$field;
      }
      
      public function removeVipGrade() : void
      {
         hasField$0 &= 4294967291;
         vip_grade$field = new int();
      }
      
      public function get hasVipGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set vipGrade(param1:int) : void
      {
         hasField$0 |= 4;
         vip_grade$field = param1;
      }
      
      public function get vipGrade() : int
      {
         return vip_grade$field;
      }
      
      public function removeExpirtDate() : void
      {
         expirt_date$field = null;
      }
      
      public function get hasExpirtDate() : Boolean
      {
         return expirt_date$field != null;
      }
      
      public function set expirtDate(param1:String) : void
      {
         expirt_date$field = param1;
      }
      
      public function get expirtDate() : String
      {
         return expirt_date$field;
      }
      
      public function removeIsTakeGift() : void
      {
         hasField$0 &= 4294967287;
         is_takeGift$field = new Boolean();
      }
      
      public function get hasIsTakeGift() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isTakeGift(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_takeGift$field = param1;
      }
      
      public function get isTakeGift() : Boolean
      {
         return is_takeGift$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294967279;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 16;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      public function removeIsExpirt() : void
      {
         hasField$0 &= 4294967263;
         is_expirt$field = new Boolean();
      }
      
      public function get hasIsExpirt() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isExpirt(param1:Boolean) : void
      {
         hasField$0 |= 32;
         is_expirt$field = param1;
      }
      
      public function get isExpirt() : Boolean
      {
         return is_expirt$field;
      }
      
      public function removeTakeGiftDate() : void
      {
         take_giftDate$field = null;
      }
      
      public function get hasTakeGiftDate() : Boolean
      {
         return take_giftDate$field != null;
      }
      
      public function set takeGiftDate(param1:String) : void
      {
         take_giftDate$field = param1;
      }
      
      public function get takeGiftDate() : String
      {
         return take_giftDate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsVip)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_vip$field);
         }
         if(hasVipGp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,vip_gp$field);
         }
         if(hasVipGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,vip_grade$field);
         }
         if(hasExpirtDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,expirt_date$field);
         }
         if(hasIsTakeGift)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_takeGift$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
         if(hasIsExpirt)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,is_expirt$field);
         }
         if(hasTakeGiftDate)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,take_giftDate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.isVip cannot be set twice.");
                  }
                  _loc4_++;
                  isVip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.vipGp cannot be set twice.");
                  }
                  _loc6_++;
                  vipGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.vipGrade cannot be set twice.");
                  }
                  _loc3_++;
                  vipGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.expirtDate cannot be set twice.");
                  }
                  _loc7_++;
                  expirtDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.isTakeGift cannot be set twice.");
                  }
                  _loc8_++;
                  isTakeGift = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.vipType cannot be set twice.");
                  }
                  _loc9_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.isExpirt cannot be set twice.");
                  }
                  _loc5_++;
                  isExpirt = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: VipInfoMsg.takeGiftDate cannot be set twice.");
                  }
                  _loc10_++;
                  takeGiftDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

