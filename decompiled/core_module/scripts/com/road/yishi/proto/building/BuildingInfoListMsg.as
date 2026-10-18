package com.road.yishi.proto.building
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BuildingInfoListMsg extends Message implements IExternalizable
   {
      
      private var result$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.building.BuildingInfoMsg")]
      public var building:Array = [];
      
      public function BuildingInfoListMsg()
      {
         super();
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967294;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 1;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         _loc2_ = 0;
         while(_loc2_ < building.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,building[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:BuildingInfoMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoListMsg.result cannot be set twice.");
                  }
                  _loc3_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  _loc5_ = new BuildingInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  building.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

