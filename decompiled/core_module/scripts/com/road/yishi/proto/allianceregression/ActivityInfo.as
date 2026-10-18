package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActivityInfo extends Message implements IExternalizable
   {
      
      private var isOpen$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var isShopOpen$field:Boolean;
      
      private var startDate$field:String;
      
      private var stopDate$field:String;
      
      public function ActivityInfo()
      {
         super();
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967294;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeIsShopOpen() : void
      {
         hasField$0 &= 4294967293;
         isShopOpen$field = new Boolean();
      }
      
      public function get hasIsShopOpen() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isShopOpen(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isShopOpen$field = param1;
      }
      
      public function get isShopOpen() : Boolean
      {
         return isShopOpen$field;
      }
      
      public function removeStartDate() : void
      {
         startDate$field = null;
      }
      
      public function get hasStartDate() : Boolean
      {
         return startDate$field != null;
      }
      
      public function set startDate(param1:String) : void
      {
         startDate$field = param1;
      }
      
      public function get startDate() : String
      {
         return startDate$field;
      }
      
      public function removeStopDate() : void
      {
         stopDate$field = null;
      }
      
      public function get hasStopDate() : Boolean
      {
         return stopDate$field != null;
      }
      
      public function set stopDate(param1:String) : void
      {
         stopDate$field = param1;
      }
      
      public function get stopDate() : String
      {
         return stopDate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasIsShopOpen)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isShopOpen$field);
         }
         if(hasStartDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,startDate$field);
         }
         if(hasStopDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,stopDate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityInfo.isOpen cannot be set twice.");
                  }
                  _loc3_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityInfo.isShopOpen cannot be set twice.");
                  }
                  _loc5_++;
                  isShopOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityInfo.startDate cannot be set twice.");
                  }
                  _loc7_++;
                  startDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityInfo.stopDate cannot be set twice.");
                  }
                  _loc4_++;
                  stopDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

