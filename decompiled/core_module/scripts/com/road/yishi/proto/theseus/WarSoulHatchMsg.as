package com.road.yishi.proto.theseus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarSoulHatchMsg extends Message implements IExternalizable
   {
      
      private var hatchNum$field:int;
      
      private var hasField$0:uint = 0;
      
      private var useItem$field:int;
      
      private var startDate$field:String;
      
      private var stopDate$field:String;
      
      public function WarSoulHatchMsg()
      {
         super();
      }
      
      public function removeHatchNum() : void
      {
         hasField$0 &= 4294967294;
         hatchNum$field = new int();
      }
      
      public function get hasHatchNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set hatchNum(param1:int) : void
      {
         hasField$0 |= 1;
         hatchNum$field = param1;
      }
      
      public function get hatchNum() : int
      {
         return hatchNum$field;
      }
      
      public function removeUseItem() : void
      {
         hasField$0 &= 4294967293;
         useItem$field = new int();
      }
      
      public function get hasUseItem() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set useItem(param1:int) : void
      {
         hasField$0 |= 2;
         useItem$field = param1;
      }
      
      public function get useItem() : int
      {
         return useItem$field;
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
         if(hasHatchNum)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,hatchNum$field);
         }
         if(hasUseItem)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,useItem$field);
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
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulHatchMsg.hatchNum cannot be set twice.");
                  }
                  _loc4_++;
                  hatchNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulHatchMsg.useItem cannot be set twice.");
                  }
                  _loc5_++;
                  useItem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulHatchMsg.startDate cannot be set twice.");
                  }
                  _loc7_++;
                  startDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulHatchMsg.stopDate cannot be set twice.");
                  }
                  _loc3_++;
                  stopDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

