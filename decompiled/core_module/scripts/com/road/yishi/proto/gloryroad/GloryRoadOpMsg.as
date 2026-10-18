package com.road.yishi.proto.gloryroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GloryRoadOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var layer$field:int;
      
      private var templateId$field:int;
      
      private var payType$field:int;
      
      private var value1$field:int;
      
      private var value2$field:int;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      public function GloryRoadOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeLayer() : void
      {
         hasField$0 &= 4294967291;
         layer$field = new int();
      }
      
      public function get hasLayer() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set layer(param1:int) : void
      {
         hasField$0 |= 4;
         layer$field = param1;
      }
      
      public function get layer() : int
      {
         return layer$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967287;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 8;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967279;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 16;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeValue1() : void
      {
         hasField$0 &= 4294967263;
         value1$field = new int();
      }
      
      public function get hasValue1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set value1(param1:int) : void
      {
         hasField$0 |= 32;
         value1$field = param1;
      }
      
      public function get value1() : int
      {
         return value1$field;
      }
      
      public function removeValue2() : void
      {
         hasField$0 &= 4294967231;
         value2$field = new int();
      }
      
      public function get hasValue2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set value2(param1:int) : void
      {
         hasField$0 |= 64;
         value2$field = param1;
      }
      
      public function get value2() : int
      {
         return value2$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasLayer)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,layer$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasValue1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,value1$field);
         }
         if(hasValue2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,value2$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.op cannot be set twice.");
                  }
                  _loc11_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.layer cannot be set twice.");
                  }
                  _loc4_++;
                  layer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.value1 cannot be set twice.");
                  }
                  _loc3_++;
                  value1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.value2 cannot be set twice.");
                  }
                  _loc10_++;
                  value2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.param1 cannot be set twice.");
                  }
                  _loc7_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadOpMsg.param2 cannot be set twice.");
                  }
                  _loc12_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

