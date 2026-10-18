package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LodeListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.LevelInfoMsg")]
      public var leveInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.RewardItemInfoMsg")]
      public var totalTakedInfo:Array = [];
      
      private var isOver$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function LodeListMsg()
      {
         super();
      }
      
      public function removeIsOver() : void
      {
         hasField$0 &= 4294967294;
         isOver$field = new Boolean();
      }
      
      public function get hasIsOver() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isOver(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isOver$field = param1;
      }
      
      public function get isOver() : Boolean
      {
         return isOver$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < leveInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,leveInfo[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < totalTakedInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,totalTakedInfo[_loc2_]);
            _loc2_++;
         }
         if(hasIsOver)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isOver$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:LevelInfoMsg = null;
         var _loc3_:RewardItemInfoMsg = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new LevelInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  leveInfo.push(_loc6_);
                  break;
               case 1:
                  _loc3_ = new RewardItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  totalTakedInfo.push(_loc3_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LodeListMsg.isOver cannot be set twice.");
                  }
                  _loc4_++;
                  isOver = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

