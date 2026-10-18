package com.road.yishi.proto.tattoo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TattooHoleReqMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var lock_pay_type$field:int;
      
      private var material_pay_type$field:int;
      
      private var refresh_lock_add$field:Boolean;
      
      private var refresh_lock_minus$field:Boolean;
      
      private var auto_buy$field:Boolean;
      
      public function TattooHoleReqMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967293;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 2;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967291;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 4;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeLockPayType() : void
      {
         hasField$0 &= 4294967287;
         lock_pay_type$field = new int();
      }
      
      public function get hasLockPayType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set lockPayType(param1:int) : void
      {
         hasField$0 |= 8;
         lock_pay_type$field = param1;
      }
      
      public function get lockPayType() : int
      {
         return lock_pay_type$field;
      }
      
      public function removeMaterialPayType() : void
      {
         hasField$0 &= 4294967279;
         material_pay_type$field = new int();
      }
      
      public function get hasMaterialPayType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set materialPayType(param1:int) : void
      {
         hasField$0 |= 16;
         material_pay_type$field = param1;
      }
      
      public function get materialPayType() : int
      {
         return material_pay_type$field;
      }
      
      public function removeRefreshLockAdd() : void
      {
         hasField$0 &= 4294967263;
         refresh_lock_add$field = new Boolean();
      }
      
      public function get hasRefreshLockAdd() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set refreshLockAdd(param1:Boolean) : void
      {
         hasField$0 |= 32;
         refresh_lock_add$field = param1;
      }
      
      public function get refreshLockAdd() : Boolean
      {
         return refresh_lock_add$field;
      }
      
      public function removeRefreshLockMinus() : void
      {
         hasField$0 &= 4294967231;
         refresh_lock_minus$field = new Boolean();
      }
      
      public function get hasRefreshLockMinus() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set refreshLockMinus(param1:Boolean) : void
      {
         hasField$0 |= 64;
         refresh_lock_minus$field = param1;
      }
      
      public function get refreshLockMinus() : Boolean
      {
         return refresh_lock_minus$field;
      }
      
      public function removeAutoBuy() : void
      {
         hasField$0 &= 4294967167;
         auto_buy$field = new Boolean();
      }
      
      public function get hasAutoBuy() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set autoBuy(param1:Boolean) : void
      {
         hasField$0 |= 128;
         auto_buy$field = param1;
      }
      
      public function get autoBuy() : Boolean
      {
         return auto_buy$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasLockPayType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,lock_pay_type$field);
         }
         if(hasMaterialPayType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,material_pay_type$field);
         }
         if(hasRefreshLockAdd)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,refresh_lock_add$field);
         }
         if(hasRefreshLockMinus)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,refresh_lock_minus$field);
         }
         if(hasAutoBuy)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,auto_buy$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.param1 cannot be set twice.");
                  }
                  _loc5_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.param2 cannot be set twice.");
                  }
                  _loc11_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.lockPayType cannot be set twice.");
                  }
                  _loc6_++;
                  lockPayType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.materialPayType cannot be set twice.");
                  }
                  _loc7_++;
                  materialPayType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.refreshLockAdd cannot be set twice.");
                  }
                  _loc10_++;
                  refreshLockAdd = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.refreshLockMinus cannot be set twice.");
                  }
                  _loc4_++;
                  refreshLockMinus = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TattooHoleReqMsg.autoBuy cannot be set twice.");
                  }
                  _loc8_++;
                  autoBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

