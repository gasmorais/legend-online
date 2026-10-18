package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpRankListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpGroupRankMsg")]
      public var groups:Array = [];
      
      private var rankTime$field:String;
      
      public function ChessPvpRankListMsg()
      {
         super();
      }
      
      public function removeRankTime() : void
      {
         rankTime$field = null;
      }
      
      public function get hasRankTime() : Boolean
      {
         return rankTime$field != null;
      }
      
      public function set rankTime(param1:String) : void
      {
         rankTime$field = param1;
      }
      
      public function get rankTime() : String
      {
         return rankTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < groups.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,groups[_loc2_]);
            _loc2_++;
         }
         if(hasRankTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,rankTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:ChessPvpGroupRankMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new ChessPvpGroupRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  groups.push(_loc3_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpRankListMsg.rankTime cannot be set twice.");
                  }
                  _loc5_++;
                  rankTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

