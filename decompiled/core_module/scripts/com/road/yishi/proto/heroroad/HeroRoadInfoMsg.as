package com.road.yishi.proto.heroroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroRoadInfoMsg extends Message implements IExternalizable
   {
      
      private var taskTempId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var takeItemsState$field:int;
      
      private var buysItemsState$field:int;
      
      private var takeNumbers$field:int;
      
      private var masterType$field:int;
      
      private var index$field:int;
      
      public function HeroRoadInfoMsg()
      {
         super();
      }
      
      public function removeTaskTempId() : void
      {
         hasField$0 &= 4294967294;
         taskTempId$field = new int();
      }
      
      public function get hasTaskTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set taskTempId(param1:int) : void
      {
         hasField$0 |= 1;
         taskTempId$field = param1;
      }
      
      public function get taskTempId() : int
      {
         return taskTempId$field;
      }
      
      public function removeTakeItemsState() : void
      {
         hasField$0 &= 4294967293;
         takeItemsState$field = new int();
      }
      
      public function get hasTakeItemsState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set takeItemsState(param1:int) : void
      {
         hasField$0 |= 2;
         takeItemsState$field = param1;
      }
      
      public function get takeItemsState() : int
      {
         return takeItemsState$field;
      }
      
      public function removeBuysItemsState() : void
      {
         hasField$0 &= 4294967291;
         buysItemsState$field = new int();
      }
      
      public function get hasBuysItemsState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buysItemsState(param1:int) : void
      {
         hasField$0 |= 4;
         buysItemsState$field = param1;
      }
      
      public function get buysItemsState() : int
      {
         return buysItemsState$field;
      }
      
      public function removeTakeNumbers() : void
      {
         hasField$0 &= 4294967287;
         takeNumbers$field = new int();
      }
      
      public function get hasTakeNumbers() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set takeNumbers(param1:int) : void
      {
         hasField$0 |= 8;
         takeNumbers$field = param1;
      }
      
      public function get takeNumbers() : int
      {
         return takeNumbers$field;
      }
      
      public function removeMasterType() : void
      {
         hasField$0 &= 4294967279;
         masterType$field = new int();
      }
      
      public function get hasMasterType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set masterType(param1:int) : void
      {
         hasField$0 |= 16;
         masterType$field = param1;
      }
      
      public function get masterType() : int
      {
         return masterType$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967263;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 32;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTaskTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,taskTempId$field);
         }
         if(hasTakeItemsState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,takeItemsState$field);
         }
         if(hasBuysItemsState)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buysItemsState$field);
         }
         if(hasTakeNumbers)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,takeNumbers$field);
         }
         if(hasMasterType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,masterType$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadInfoMsg.taskTempId cannot be set twice.");
                  }
                  _loc4_++;
                  taskTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadInfoMsg.takeItemsState cannot be set twice.");
                  }
                  _loc9_++;
                  takeItemsState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadInfoMsg.buysItemsState cannot be set twice.");
                  }
                  _loc5_++;
                  buysItemsState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadInfoMsg.takeNumbers cannot be set twice.");
                  }
                  _loc7_++;
                  takeNumbers = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadInfoMsg.masterType cannot be set twice.");
                  }
                  _loc6_++;
                  masterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRoadInfoMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

