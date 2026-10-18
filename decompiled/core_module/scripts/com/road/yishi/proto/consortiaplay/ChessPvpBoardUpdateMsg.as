package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpBoardUpdateMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpTeamMsg")]
      public var teams:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpBoxMsg")]
      public var boxes:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpRoleMsg")]
      public var roles:Array = [];
      
      public function ChessPvpBoardUpdateMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < teams.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,teams[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < boxes.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,boxes[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < roles.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,roles[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:ChessPvpTeamMsg = null;
         var _loc4_:ChessPvpBoxMsg = null;
         var _loc5_:ChessPvpRoleMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new ChessPvpTeamMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  teams.push(_loc3_);
                  break;
               case 1:
                  _loc4_ = new ChessPvpBoxMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  boxes.push(_loc4_);
                  break;
               case 2:
                  _loc5_ = new ChessPvpRoleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  roles.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

