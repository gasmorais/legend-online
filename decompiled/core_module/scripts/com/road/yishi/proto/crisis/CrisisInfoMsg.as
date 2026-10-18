package com.road.yishi.proto.crisis
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrisisInfoMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.crisis.CrisisPlayerInfo")]
      public var players:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.crisis.CrisisNodeInfo")]
      public var nodes:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.crisis.CrisisEventCount")]
      public var eventCountInfos:Array = [];
      
      private var isRelogin$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function CrisisInfoMsg()
      {
         super();
      }
      
      public function removeIsRelogin() : void
      {
         hasField$0 &= 4294967294;
         isRelogin$field = new Boolean();
      }
      
      public function get hasIsRelogin() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isRelogin(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isRelogin$field = param1;
      }
      
      public function get isRelogin() : Boolean
      {
         return isRelogin$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < players.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,players[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < nodes.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,nodes[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < eventCountInfos.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,eventCountInfos[_loc3_]);
            _loc3_++;
         }
         if(hasIsRelogin)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isRelogin$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:CrisisPlayerInfo = null;
         var _loc4_:CrisisNodeInfo = null;
         var _loc3_:CrisisEventCount = null;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new CrisisPlayerInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  players.push(_loc6_);
                  break;
               case 1:
                  _loc4_ = new CrisisNodeInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  nodes.push(_loc4_);
                  break;
               case 2:
                  _loc3_ = new CrisisEventCount();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  eventCountInfos.push(_loc3_);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrisisInfoMsg.isRelogin cannot be set twice.");
                  }
                  _loc7_++;
                  isRelogin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

