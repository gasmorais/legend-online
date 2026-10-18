package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PackageData extends Message implements IExternalizable
   {
      
      private var packId$field:String;
      
      private var status$field:int;
      
      private var hasField$0:uint = 0;
      
      private var countDown$field:int;
      
      private var is_show$field:Boolean;
      
      private var param1$field:String;
      
      private var finish_value$field:int;
      
      private var get_count$field:int;
      
      public function PackageData()
      {
         super();
      }
      
      public function removePackId() : void
      {
         packId$field = null;
      }
      
      public function get hasPackId() : Boolean
      {
         return packId$field != null;
      }
      
      public function set packId(param1:String) : void
      {
         packId$field = param1;
      }
      
      public function get packId() : String
      {
         return packId$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967294;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 1;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967293;
         countDown$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 2;
         countDown$field = param1;
      }
      
      public function get countDown() : int
      {
         return countDown$field;
      }
      
      public function removeIsShow() : void
      {
         hasField$0 &= 4294967291;
         is_show$field = new Boolean();
      }
      
      public function get hasIsShow() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_show$field = param1;
      }
      
      public function get isShow() : Boolean
      {
         return is_show$field;
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
      
      public function removeFinishValue() : void
      {
         hasField$0 &= 4294967287;
         finish_value$field = new int();
      }
      
      public function get hasFinishValue() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set finishValue(param1:int) : void
      {
         hasField$0 |= 8;
         finish_value$field = param1;
      }
      
      public function get finishValue() : int
      {
         return finish_value$field;
      }
      
      public function removeGetCount() : void
      {
         hasField$0 &= 4294967279;
         get_count$field = new int();
      }
      
      public function get hasGetCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set getCount(param1:int) : void
      {
         hasField$0 |= 16;
         get_count$field = param1;
      }
      
      public function get getCount() : int
      {
         return get_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPackId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,packId$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,countDown$field);
         }
         if(hasIsShow)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,is_show$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasFinishValue)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,finish_value$field);
         }
         if(hasGetCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,get_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PackageData.packId cannot be set twice.");
                  }
                  _loc4_++;
                  packId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PackageData.status cannot be set twice.");
                  }
                  _loc10_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PackageData.countDown cannot be set twice.");
                  }
                  _loc5_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PackageData.isShow cannot be set twice.");
                  }
                  _loc8_++;
                  isShow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PackageData.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PackageData.finishValue cannot be set twice.");
                  }
                  _loc3_++;
                  finishValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PackageData.getCount cannot be set twice.");
                  }
                  _loc9_++;
                  getCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

