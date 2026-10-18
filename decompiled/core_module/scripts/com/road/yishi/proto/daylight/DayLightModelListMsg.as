package com.road.yishi.proto.daylight
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DayLightModelListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.daylight.DayLightModelInfoMsg")]
      public var blueModelList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.daylight.DayLightModelInfoMsg")]
      public var redModelList:Array = [];
      
      public function DayLightModelListMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < blueModelList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,blueModelList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < redModelList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,redModelList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:DayLightModelInfoMsg = null;
         var _loc5_:DayLightModelInfoMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new DayLightModelInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  blueModelList.push(_loc3_);
                  break;
               case 1:
                  _loc5_ = new DayLightModelInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  redModelList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

