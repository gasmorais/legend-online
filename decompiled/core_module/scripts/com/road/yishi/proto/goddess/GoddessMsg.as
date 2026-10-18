package com.road.yishi.proto.goddess
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoddessMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.goddess.GoddessInfoMsg")]
      public var infos:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.goddess.GoddessFormationIdInfoMsg")]
      public var formations:Array = [];
      
      public function GoddessMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < infos.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,infos[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < formations.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,formations[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:GoddessInfoMsg = null;
         var _loc4_:GoddessFormationIdInfoMsg = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc3_ = new GoddessInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  infos.push(_loc3_);
                  break;
               case 1:
                  _loc4_ = new GoddessFormationIdInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  formations.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

