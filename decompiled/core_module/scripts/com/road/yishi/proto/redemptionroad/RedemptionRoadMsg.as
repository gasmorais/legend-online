package com.road.yishi.proto.redemptionroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RedemptionRoadMsg extends Message implements IExternalizable
   {
      
      private var difficulty$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.redemptionroad.RedemptionRoadLayerMsg")]
      public var layers:Array = [];
      
      public function RedemptionRoadMsg()
      {
         super();
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294967294;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 1;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         _loc2_ = 0;
         while(_loc2_ < layers.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,layers[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:RedemptionRoadLayerMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadMsg.difficulty cannot be set twice.");
                  }
                  _loc5_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new RedemptionRoadLayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  layers.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

