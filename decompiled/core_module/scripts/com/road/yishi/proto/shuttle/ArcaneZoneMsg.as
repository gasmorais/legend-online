package com.road.yishi.proto.shuttle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArcaneZoneMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.shuttle.ArcaneZoneBossMsg")]
      public var bossList:Array = [];
      
      private var arcane_zone_count$field:int;
      
      private var arcane_zone_buy_count$field:int;
      
      public function ArcaneZoneMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeArcaneZoneCount() : void
      {
         hasField$0 &= 4294967293;
         arcane_zone_count$field = new int();
      }
      
      public function get hasArcaneZoneCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set arcaneZoneCount(param1:int) : void
      {
         hasField$0 |= 2;
         arcane_zone_count$field = param1;
      }
      
      public function get arcaneZoneCount() : int
      {
         return arcane_zone_count$field;
      }
      
      public function removeArcaneZoneBuyCount() : void
      {
         hasField$0 &= 4294967291;
         arcane_zone_buy_count$field = new int();
      }
      
      public function get hasArcaneZoneBuyCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set arcaneZoneBuyCount(param1:int) : void
      {
         hasField$0 |= 4;
         arcane_zone_buy_count$field = param1;
      }
      
      public function get arcaneZoneBuyCount() : int
      {
         return arcane_zone_buy_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         _loc2_ = 0;
         while(_loc2_ < bossList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,bossList[_loc2_]);
            _loc2_++;
         }
         if(hasArcaneZoneCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,arcane_zone_count$field);
         }
         if(hasArcaneZoneBuyCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,arcane_zone_buy_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:ArcaneZoneBossMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc6_ = new ArcaneZoneBossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  bossList.push(_loc6_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneMsg.arcaneZoneCount cannot be set twice.");
                  }
                  _loc4_++;
                  arcaneZoneCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneMsg.arcaneZoneBuyCount cannot be set twice.");
                  }
                  _loc3_++;
                  arcaneZoneBuyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

