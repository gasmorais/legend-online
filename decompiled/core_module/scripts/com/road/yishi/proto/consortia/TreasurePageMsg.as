package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TreasurePageMsg extends Message implements IExternalizable
   {
      
      private var leftCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var freeTime$field:String;
      
      private var freeTemplateSecond$field:int;
      
      private var refreshTimes$field:int;
      
      [ArrayElementType("com.road.yishi.proto.consortia.TreasuresMsg")]
      public var treasures:Array = [];
      
      public function TreasurePageMsg()
      {
         super();
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967294;
         leftCount$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 1;
         leftCount$field = param1;
      }
      
      public function get leftCount() : int
      {
         return leftCount$field;
      }
      
      public function removeFreeTime() : void
      {
         freeTime$field = null;
      }
      
      public function get hasFreeTime() : Boolean
      {
         return freeTime$field != null;
      }
      
      public function set freeTime(param1:String) : void
      {
         freeTime$field = param1;
      }
      
      public function get freeTime() : String
      {
         return freeTime$field;
      }
      
      public function removeFreeTemplateSecond() : void
      {
         hasField$0 &= 4294967293;
         freeTemplateSecond$field = new int();
      }
      
      public function get hasFreeTemplateSecond() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set freeTemplateSecond(param1:int) : void
      {
         hasField$0 |= 2;
         freeTemplateSecond$field = param1;
      }
      
      public function get freeTemplateSecond() : int
      {
         return freeTemplateSecond$field;
      }
      
      public function removeRefreshTimes() : void
      {
         hasField$0 &= 4294967291;
         refreshTimes$field = new int();
      }
      
      public function get hasRefreshTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set refreshTimes(param1:int) : void
      {
         hasField$0 |= 4;
         refreshTimes$field = param1;
      }
      
      public function get refreshTimes() : int
      {
         return refreshTimes$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,leftCount$field);
         }
         if(hasFreeTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,freeTime$field);
         }
         if(hasFreeTemplateSecond)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,freeTemplateSecond$field);
         }
         if(hasRefreshTimes)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,refreshTimes$field);
         }
         _loc2_ = 0;
         while(_loc2_ < treasures.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,treasures[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:TreasuresMsg = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TreasurePageMsg.leftCount cannot be set twice.");
                  }
                  _loc5_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TreasurePageMsg.freeTime cannot be set twice.");
                  }
                  _loc4_++;
                  freeTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TreasurePageMsg.freeTemplateSecond cannot be set twice.");
                  }
                  _loc8_++;
                  freeTemplateSecond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TreasurePageMsg.refreshTimes cannot be set twice.");
                  }
                  _loc6_++;
                  refreshTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc3_ = new TreasuresMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  treasures.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

