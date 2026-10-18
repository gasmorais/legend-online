package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardInfoMsg extends Message implements IExternalizable
   {
      
      private var packageId$field:String;
      
      [ArrayElementType("com.road.yishi.proto.active.ItemInfoMsg")]
      public var items:Array = [];
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param$field:int;
      
      private var statu$field:int;
      
      public function RewardInfoMsg()
      {
         super();
      }
      
      public function removePackageId() : void
      {
         packageId$field = null;
      }
      
      public function get hasPackageId() : Boolean
      {
         return packageId$field != null;
      }
      
      public function set packageId(param1:String) : void
      {
         packageId$field = param1;
      }
      
      public function get packageId() : String
      {
         return packageId$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeParam() : void
      {
         hasField$0 &= 4294967293;
         param$field = new int();
      }
      
      public function get hasParam() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param(param1:int) : void
      {
         hasField$0 |= 2;
         param$field = param1;
      }
      
      public function get param() : int
      {
         return param$field;
      }
      
      public function removeStatu() : void
      {
         hasField$0 &= 4294967291;
         statu$field = new int();
      }
      
      public function get hasStatu() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set statu(param1:int) : void
      {
         hasField$0 |= 4;
         statu$field = param1;
      }
      
      public function get statu() : int
      {
         return statu$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPackageId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,packageId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasParam)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,param$field);
         }
         if(hasStatu)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,statu$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:ItemInfoMsg = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfoMsg.packageId cannot be set twice.");
                  }
                  _loc7_++;
                  packageId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  _loc8_ = new ItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  items.push(_loc8_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfoMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfoMsg.param cannot be set twice.");
                  }
                  _loc3_++;
                  param = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfoMsg.statu cannot be set twice.");
                  }
                  _loc4_++;
                  statu = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

