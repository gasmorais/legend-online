package com.road.yishi.proto.store
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SmithFreshReqMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("Boolean")]
      public var lock:Array = [];
      
      private var bind_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      private var material_pay_type$field:int;
      
      public function SmithFreshReqMsg()
      {
         super();
      }
      
      public function removeBindType() : void
      {
         hasField$0 &= 4294967294;
         bind_type$field = new int();
      }
      
      public function get hasBindType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bindType(param1:int) : void
      {
         hasField$0 |= 1;
         bind_type$field = param1;
      }
      
      public function get bindType() : int
      {
         return bind_type$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeMaterialPayType() : void
      {
         hasField$0 &= 4294967291;
         material_pay_type$field = new int();
      }
      
      public function get hasMaterialPayType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set materialPayType(param1:int) : void
      {
         hasField$0 |= 4;
         material_pay_type$field = param1;
      }
      
      public function get materialPayType() : int
      {
         return material_pay_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < lock.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,lock[_loc2_]);
            _loc2_++;
         }
         if(hasBindType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bind_type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasMaterialPayType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,material_pay_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_BOOL,lock);
                  }
                  else
                  {
                     lock.push(ReadUtils.read$TYPE_BOOL(param1));
                  }
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SmithFreshReqMsg.bindType cannot be set twice.");
                  }
                  _loc3_++;
                  bindType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SmithFreshReqMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SmithFreshReqMsg.materialPayType cannot be set twice.");
                  }
                  _loc4_++;
                  materialPayType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

