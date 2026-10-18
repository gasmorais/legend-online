package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarFightRankMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.consortiawar.ConsortiaWarFightInfoMsg")]
      public var myTeam:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.consortiawar.ConsortiaWarFightInfoMsg")]
      public var rivalTeam:Array = [];
      
      public function ConsortiaWarFightRankMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < myTeam.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,myTeam[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < rivalTeam.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,rivalTeam[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:ConsortiaWarFightInfoMsg = null;
         var _loc4_:ConsortiaWarFightInfoMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 2)
            {
               case 0:
                  _loc3_ = new ConsortiaWarFightInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  myTeam.push(_loc3_);
                  break;
               case 1:
                  _loc4_ = new ConsortiaWarFightInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  rivalTeam.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

