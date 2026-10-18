package com.road.yishi.proto.room
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesWarAllPlayerMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      [ArrayElementType("com.road.yishi.proto.room.PlanesWarPlayerInfoMsg")]
      public var playerList:Array = [];
      
      public function PlanesWarAllPlayerMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         _loc2_ = 0;
         while(_loc2_ < playerList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,playerList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:PlanesWarPlayerInfoMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarAllPlayerMsg.op cannot be set twice.");
                  }
                  _loc5_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new PlanesWarPlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  playerList.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
         if(_loc5_ != 1)
         {
            throw new IOError("Bad data format: PlanesWarAllPlayerMsg.op must be set.");
         }
      }
   }
}

