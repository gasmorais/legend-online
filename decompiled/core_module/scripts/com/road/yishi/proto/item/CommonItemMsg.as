package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CommonItemMsg extends Message implements IExternalizable
   {
      
      private var begin_bag_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var begin_obj_id$field:int;
      
      private var begin_pos$field:int;
      
      private var end_bag_type$field:int;
      
      private var end_obj_id$field:int;
      
      private var end_pos$field:int;
      
      private var count$field:int;
      
      private var object_id$field:int;
      
      private var compose_id$field:int;
      
      private var compose_num$field:int;
      
      private var auto_buy$field:Boolean;
      
      private var op_type$field:int;
      
      private var hole_pos$field:int;
      
      private var operate$field:Boolean;
      
      private var payType$field:int;
      
      [ArrayElementType("Boolean")]
      public var lock:Array = [];
      
      private var bind_type$field:int;
      
      private var property1$field:int;
      
      [ArrayElementType("com.road.yishi.proto.item.SellItemMsg")]
      public var sellItem:Array = [];
      
      private var material_pay_type$field:int;
      
      public function CommonItemMsg()
      {
         super();
      }
      
      public function removeBeginBagType() : void
      {
         hasField$0 &= 4294967294;
         begin_bag_type$field = new int();
      }
      
      public function get hasBeginBagType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set beginBagType(param1:int) : void
      {
         hasField$0 |= 1;
         begin_bag_type$field = param1;
      }
      
      public function get beginBagType() : int
      {
         return begin_bag_type$field;
      }
      
      public function removeBeginObjId() : void
      {
         hasField$0 &= 4294967293;
         begin_obj_id$field = new int();
      }
      
      public function get hasBeginObjId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set beginObjId(param1:int) : void
      {
         hasField$0 |= 2;
         begin_obj_id$field = param1;
      }
      
      public function get beginObjId() : int
      {
         return begin_obj_id$field;
      }
      
      public function removeBeginPos() : void
      {
         hasField$0 &= 4294967291;
         begin_pos$field = new int();
      }
      
      public function get hasBeginPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set beginPos(param1:int) : void
      {
         hasField$0 |= 4;
         begin_pos$field = param1;
      }
      
      public function get beginPos() : int
      {
         return begin_pos$field;
      }
      
      public function removeEndBagType() : void
      {
         hasField$0 &= 4294967287;
         end_bag_type$field = new int();
      }
      
      public function get hasEndBagType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endBagType(param1:int) : void
      {
         hasField$0 |= 8;
         end_bag_type$field = param1;
      }
      
      public function get endBagType() : int
      {
         return end_bag_type$field;
      }
      
      public function removeEndObjId() : void
      {
         hasField$0 &= 4294967279;
         end_obj_id$field = new int();
      }
      
      public function get hasEndObjId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set endObjId(param1:int) : void
      {
         hasField$0 |= 16;
         end_obj_id$field = param1;
      }
      
      public function get endObjId() : int
      {
         return end_obj_id$field;
      }
      
      public function removeEndPos() : void
      {
         hasField$0 &= 4294967263;
         end_pos$field = new int();
      }
      
      public function get hasEndPos() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set endPos(param1:int) : void
      {
         hasField$0 |= 32;
         end_pos$field = param1;
      }
      
      public function get endPos() : int
      {
         return end_pos$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967231;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 64;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeObjectId() : void
      {
         hasField$0 &= 4294967167;
         object_id$field = new int();
      }
      
      public function get hasObjectId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set objectId(param1:int) : void
      {
         hasField$0 |= 128;
         object_id$field = param1;
      }
      
      public function get objectId() : int
      {
         return object_id$field;
      }
      
      public function removeComposeId() : void
      {
         hasField$0 &= 4294967039;
         compose_id$field = new int();
      }
      
      public function get hasComposeId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set composeId(param1:int) : void
      {
         hasField$0 |= 256;
         compose_id$field = param1;
      }
      
      public function get composeId() : int
      {
         return compose_id$field;
      }
      
      public function removeComposeNum() : void
      {
         hasField$0 &= 4294966783;
         compose_num$field = new int();
      }
      
      public function get hasComposeNum() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set composeNum(param1:int) : void
      {
         hasField$0 |= 512;
         compose_num$field = param1;
      }
      
      public function get composeNum() : int
      {
         return compose_num$field;
      }
      
      public function removeAutoBuy() : void
      {
         hasField$0 &= 4294966271;
         auto_buy$field = new Boolean();
      }
      
      public function get hasAutoBuy() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set autoBuy(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         auto_buy$field = param1;
      }
      
      public function get autoBuy() : Boolean
      {
         return auto_buy$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294965247;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 2048;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeHolePos() : void
      {
         hasField$0 &= 4294963199;
         hole_pos$field = new int();
      }
      
      public function get hasHolePos() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set holePos(param1:int) : void
      {
         hasField$0 |= 4096;
         hole_pos$field = param1;
      }
      
      public function get holePos() : int
      {
         return hole_pos$field;
      }
      
      public function removeOperate() : void
      {
         hasField$0 &= 4294959103;
         operate$field = new Boolean();
      }
      
      public function get hasOperate() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set operate(param1:Boolean) : void
      {
         hasField$0 |= 8192;
         operate$field = param1;
      }
      
      public function get operate() : Boolean
      {
         return operate$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294950911;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 16384;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeBindType() : void
      {
         hasField$0 &= 4294934527;
         bind_type$field = new int();
      }
      
      public function get hasBindType() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set bindType(param1:int) : void
      {
         hasField$0 |= 32768;
         bind_type$field = param1;
      }
      
      public function get bindType() : int
      {
         return bind_type$field;
      }
      
      public function removeProperty1() : void
      {
         hasField$0 &= 4294901759;
         property1$field = new int();
      }
      
      public function get hasProperty1() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set property1(param1:int) : void
      {
         hasField$0 |= 65536;
         property1$field = param1;
      }
      
      public function get property1() : int
      {
         return property1$field;
      }
      
      public function removeMaterialPayType() : void
      {
         hasField$0 &= 4294836223;
         material_pay_type$field = new int();
      }
      
      public function get hasMaterialPayType() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set materialPayType(param1:int) : void
      {
         hasField$0 |= 131072;
         material_pay_type$field = param1;
      }
      
      public function get materialPayType() : int
      {
         return material_pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasBeginBagType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,begin_bag_type$field);
         }
         if(hasBeginObjId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,begin_obj_id$field);
         }
         if(hasBeginPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,begin_pos$field);
         }
         if(hasEndBagType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,end_bag_type$field);
         }
         if(hasEndObjId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,end_obj_id$field);
         }
         if(hasEndPos)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,end_pos$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasObjectId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,object_id$field);
         }
         if(hasComposeId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,compose_id$field);
         }
         if(hasComposeNum)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,compose_num$field);
         }
         if(hasAutoBuy)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,auto_buy$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasHolePos)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,hole_pos$field);
         }
         if(hasOperate)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,operate$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         _loc3_ = 0;
         while(_loc3_ < lock.length)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,lock[_loc3_]);
            _loc3_++;
         }
         if(hasBindType)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,bind_type$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,property1$field);
         }
         _loc2_ = 0;
         while(_loc2_ < sellItem.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,sellItem[_loc2_]);
            _loc2_++;
         }
         if(hasMaterialPayType)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,material_pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc21_:SellItemMsg = null;
         var _loc4_:uint = 0;
         var _loc22_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         var _loc20_:uint = 0;
         var _loc10_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.beginBagType cannot be set twice.");
                  }
                  _loc4_++;
                  beginBagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.beginObjId cannot be set twice.");
                  }
                  _loc22_++;
                  beginObjId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.beginPos cannot be set twice.");
                  }
                  _loc7_++;
                  beginPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.endBagType cannot be set twice.");
                  }
                  _loc5_++;
                  endBagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.endObjId cannot be set twice.");
                  }
                  _loc6_++;
                  endObjId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.endPos cannot be set twice.");
                  }
                  _loc8_++;
                  endPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.objectId cannot be set twice.");
                  }
                  _loc17_++;
                  objectId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.composeId cannot be set twice.");
                  }
                  _loc20_++;
                  composeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.composeNum cannot be set twice.");
                  }
                  _loc10_++;
                  composeNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.autoBuy cannot be set twice.");
                  }
                  _loc18_++;
                  autoBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.opType cannot be set twice.");
                  }
                  _loc12_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.holePos cannot be set twice.");
                  }
                  _loc9_++;
                  holePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.operate cannot be set twice.");
                  }
                  _loc14_++;
                  operate = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.payType cannot be set twice.");
                  }
                  _loc13_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if((_loc19_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_BOOL,lock);
                  }
                  else
                  {
                     lock.push(ReadUtils.read$TYPE_BOOL(param1));
                  }
                  break;
               case 17:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.bindType cannot be set twice.");
                  }
                  _loc11_++;
                  bindType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.property1 cannot be set twice.");
                  }
                  _loc15_++;
                  property1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  _loc21_ = new SellItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc21_);
                  sellItem.push(_loc21_);
                  break;
               case 20:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CommonItemMsg.materialPayType cannot be set twice.");
                  }
                  _loc16_++;
                  materialPayType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

