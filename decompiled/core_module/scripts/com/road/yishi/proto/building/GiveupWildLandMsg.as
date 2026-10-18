package com.road.yishi.proto.building
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GiveupWildLandMsg extends Message implements IExternalizable
   {
      
      private var wild_land_pos$field:String;
      
      public function GiveupWildLandMsg()
      {
         super();
      }
      
      public function removeWildLandPos() : void
      {
         wild_land_pos$field = null;
      }
      
      public function get hasWildLandPos() : Boolean
      {
         return wild_land_pos$field != null;
      }
      
      public function set wildLandPos(param1:String) : void
      {
         wild_land_pos$field = param1;
      }
      
      public function get wildLandPos() : String
      {
         return wild_land_pos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasWildLandPos)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,wild_land_pos$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GiveupWildLandMsg.wildLandPos cannot be set twice.");
                  }
                  _loc3_++;
                  wildLandPos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

