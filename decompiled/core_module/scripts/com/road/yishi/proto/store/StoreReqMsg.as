package com.road.yishi.proto.store
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StoreReqMsg extends Message implements IExternalizable
   {
      
      private var hole_pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var operate$field:Boolean;
      
      private var bag_type$field:int;
      
      private var bag_pos$field:int;
      
      private var mount_pos$field:int;
      
      private var compose_id$field:int;
      
      private var compose_num$field:int;
      
      private var auto_buy$field:Boolean;
      
      private var src_itemid$field:int;
      
      private var des_itemid$field:int;
      
      private var count$field:int;
      
      private var pay_type$field:int;
      
      private var opType$field:int;
      
      public function StoreReqMsg()
      {
         super();
      }
      
      public function removeHolePos() : void
      {
         hasField$0 &= 4294967294;
         hole_pos$field = new int();
      }
      
      public function get hasHolePos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set holePos(param1:int) : void
      {
         hasField$0 |= 1;
         hole_pos$field = param1;
      }
      
      public function get holePos() : int
      {
         return hole_pos$field;
      }
      
      public function removeOperate() : void
      {
         hasField$0 &= 4294967293;
         operate$field = new Boolean();
      }
      
      public function get hasOperate() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set operate(param1:Boolean) : void
      {
         hasField$0 |= 2;
         operate$field = param1;
      }
      
      public function get operate() : Boolean
      {
         return operate$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967291;
         bag_type$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 4;
         bag_type$field = param1;
      }
      
      public function get bagType() : int
      {
         return bag_type$field;
      }
      
      public function removeBagPos() : void
      {
         hasField$0 &= 4294967287;
         bag_pos$field = new int();
      }
      
      public function get hasBagPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bagPos(param1:int) : void
      {
         hasField$0 |= 8;
         bag_pos$field = param1;
      }
      
      public function get bagPos() : int
      {
         return bag_pos$field;
      }
      
      public function removeMountPos() : void
      {
         hasField$0 &= 4294967279;
         mount_pos$field = new int();
      }
      
      public function get hasMountPos() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set mountPos(param1:int) : void
      {
         hasField$0 |= 16;
         mount_pos$field = param1;
      }
      
      public function get mountPos() : int
      {
         return mount_pos$field;
      }
      
      public function removeComposeId() : void
      {
         hasField$0 &= 4294967263;
         compose_id$field = new int();
      }
      
      public function get hasComposeId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set composeId(param1:int) : void
      {
         hasField$0 |= 32;
         compose_id$field = param1;
      }
      
      public function get composeId() : int
      {
         return compose_id$field;
      }
      
      public function removeComposeNum() : void
      {
         hasField$0 &= 4294967231;
         compose_num$field = new int();
      }
      
      public function get hasComposeNum() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set composeNum(param1:int) : void
      {
         hasField$0 |= 64;
         compose_num$field = param1;
      }
      
      public function get composeNum() : int
      {
         return compose_num$field;
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
      
      public function removeSrcItemid() : void
      {
         hasField$0 &= 4294967039;
         src_itemid$field = new int();
      }
      
      public function get hasSrcItemid() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set srcItemid(param1:int) : void
      {
         hasField$0 |= 256;
         src_itemid$field = param1;
      }
      
      public function get srcItemid() : int
      {
         return src_itemid$field;
      }
      
      public function removeDesItemid() : void
      {
         hasField$0 &= 4294966783;
         des_itemid$field = new int();
      }
      
      public function get hasDesItemid() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set desItemid(param1:int) : void
      {
         hasField$0 |= 512;
         des_itemid$field = param1;
      }
      
      public function get desItemid() : int
      {
         return des_itemid$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294966271;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 1024;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294965247;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2048;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294963199;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 4096;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHolePos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,hole_pos$field);
         }
         if(hasOperate)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,operate$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,bag_type$field);
         }
         if(hasBagPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,bag_pos$field);
         }
         if(hasMountPos)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,mount_pos$field);
         }
         if(hasComposeId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,compose_id$field);
         }
         if(hasComposeNum)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,compose_num$field);
         }
         if(hasAutoBuy)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,auto_buy$field);
         }
         if(hasSrcItemid)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,src_itemid$field);
         }
         if(hasDesItemid)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,des_itemid$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.holePos cannot be set twice.");
                  }
                  _loc5_++;
                  holePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.operate cannot be set twice.");
                  }
                  _loc11_++;
                  operate = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.bagType cannot be set twice.");
                  }
                  _loc7_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.bagPos cannot be set twice.");
                  }
                  _loc13_++;
                  bagPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.mountPos cannot be set twice.");
                  }
                  _loc15_++;
                  mountPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.composeId cannot be set twice.");
                  }
                  _loc16_++;
                  composeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.composeNum cannot be set twice.");
                  }
                  _loc8_++;
                  composeNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.autoBuy cannot be set twice.");
                  }
                  _loc12_++;
                  autoBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.srcItemid cannot be set twice.");
                  }
                  _loc9_++;
                  srcItemid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.desItemid cannot be set twice.");
                  }
                  _loc3_++;
                  desItemid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: StoreReqMsg.opType cannot be set twice.");
                  }
                  _loc10_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

