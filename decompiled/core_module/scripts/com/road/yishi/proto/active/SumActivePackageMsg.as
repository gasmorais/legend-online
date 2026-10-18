package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SumActivePackageMsg extends Message implements IExternalizable
   {
      
      private var packageId$field:String;
      
      private var order$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.active.SumActiveItemInfoMsg")]
      public var items:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.PackageConditionMsg")]
      public var conditions:Array = [];
      
      public function SumActivePackageMsg()
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
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967294;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 1;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasPackageId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,packageId$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < conditions.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,conditions[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc7_:SumActiveItemInfoMsg = null;
         var _loc5_:PackageConditionMsg = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SumActivePackageMsg.packageId cannot be set twice.");
                  }
                  _loc6_++;
                  packageId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SumActivePackageMsg.order cannot be set twice.");
                  }
                  _loc3_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc7_ = new SumActiveItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  items.push(_loc7_);
                  break;
               case 3:
                  _loc5_ = new PackageConditionMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  conditions.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

