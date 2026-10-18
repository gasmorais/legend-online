package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TreasureBoxUserMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var dropList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.module.TreasureBoxMsg")]
      public var boxList:Array = [];
      
      public function TreasureBoxUserMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < dropList.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,dropList[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < boxList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,boxList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:TreasureBoxMsg = null;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,dropList);
                  }
                  else
                  {
                     dropList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 1:
                  _loc4_ = new TreasureBoxMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  boxList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

