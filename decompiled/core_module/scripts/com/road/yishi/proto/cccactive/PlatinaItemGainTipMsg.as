package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlatinaItemGainTipMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("String")]
      public var luckPassTip:Array = [];
      
      [ArrayElementType("String")]
      public var personalTip:Array = [];
      
      [ArrayElementType("int")]
      public var itemIds:Array = [];
      
      public function PlatinaItemGainTipMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < luckPassTip.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,luckPassTip[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < personalTip.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,personalTip[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < itemIds.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,itemIds[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  luckPassTip.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 1:
                  personalTip.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 2:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,itemIds);
                  }
                  else
                  {
                     itemIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

