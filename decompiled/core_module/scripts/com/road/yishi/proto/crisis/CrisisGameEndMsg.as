package com.road.yishi.proto.crisis
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrisisGameEndMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.crisis.CrisisPlayerInfo")]
      public var players:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.crisis.CrisisItemMsg")]
      public var items:Array = [];
      
      private var crystalCount$field:int;
      
      private var hasField$0:uint = 0;
      
      public function CrisisGameEndMsg()
      {
         super();
      }
      
      public function removeCrystalCount() : void
      {
         hasField$0 &= 4294967294;
         crystalCount$field = new int();
      }
      
      public function get hasCrystalCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set crystalCount(param1:int) : void
      {
         hasField$0 |= 1;
         crystalCount$field = param1;
      }
      
      public function get crystalCount() : int
      {
         return crystalCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,players[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < items.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc3_]);
            _loc3_++;
         }
         if(hasCrystalCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,crystalCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:CrisisPlayerInfo = null;
         var _loc6_:CrisisItemMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new CrisisPlayerInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  players.push(_loc4_);
                  break;
               case 1:
                  _loc6_ = new CrisisItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  items.push(_loc6_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisGameEndMsg.crystalCount cannot be set twice.");
                  }
                  _loc5_++;
                  crystalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

