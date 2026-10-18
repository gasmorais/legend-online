package com.road.yishi.proto.crisis
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrisisGameStartMsg extends Message implements IExternalizable
   {
      
      private var mapId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var difficulty$field:int;
      
      [ArrayElementType("com.road.yishi.proto.crisis.CrisisPlayerMsg")]
      public var players:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.crisis.CrisisEventCountMsg")]
      public var eventCountInfos:Array = [];
      
      private var needCrystal$field:int;
      
      public function CrisisGameStartMsg()
      {
         super();
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967294;
         mapId$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 1;
         mapId$field = param1;
      }
      
      public function get mapId() : int
      {
         return mapId$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967293;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 2;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeNeedCrystal() : void
      {
         hasField$0 &= 4294967291;
         needCrystal$field = new int();
      }
      
      public function get hasNeedCrystal() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set needCrystal(param1:int) : void
      {
         hasField$0 |= 4;
         needCrystal$field = param1;
      }
      
      public function get needCrystal() : int
      {
         return needCrystal$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mapId$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,players[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < eventCountInfos.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,eventCountInfos[_loc3_]);
            _loc3_++;
         }
         if(hasNeedCrystal)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,needCrystal$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:CrisisPlayerMsg = null;
         var _loc3_:CrisisEventCountMsg = null;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisGameStartMsg.mapId cannot be set twice.");
                  }
                  _loc6_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisGameStartMsg.difficulty cannot be set twice.");
                  }
                  _loc8_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc5_ = new CrisisPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  players.push(_loc5_);
                  break;
               case 3:
                  _loc3_ = new CrisisEventCountMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  eventCountInfos.push(_loc3_);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisGameStartMsg.needCrystal cannot be set twice.");
                  }
                  _loc7_++;
                  needCrystal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

