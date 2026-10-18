package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SystemArmyMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var heroTemplated:Array = [];
      
      [ArrayElementType("int")]
      public var soldierTemplated:Array = [];
      
      public function SystemArmyMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < heroTemplated.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,heroTemplated[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < soldierTemplated.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,soldierTemplated[_loc2_]);
            _loc2_++;
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
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,heroTemplated);
                  }
                  else
                  {
                     heroTemplated.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 1:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,soldierTemplated);
                  }
                  else
                  {
                     soldierTemplated.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

