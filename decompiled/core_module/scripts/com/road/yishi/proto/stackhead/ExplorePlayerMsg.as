package com.road.yishi.proto.stackhead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ExplorePlayerMsg extends Message implements IExternalizable
   {
      
      private var current_point$field:String;
      
      [ArrayElementType("com.road.yishi.proto.stackhead.StackHeadExploreDiceMsg")]
      public var dice:Array = [];
      
      public function ExplorePlayerMsg()
      {
         super();
      }
      
      public function removeCurrentPoint() : void
      {
         current_point$field = null;
      }
      
      public function get hasCurrentPoint() : Boolean
      {
         return current_point$field != null;
      }
      
      public function set currentPoint(param1:String) : void
      {
         current_point$field = param1;
      }
      
      public function get currentPoint() : String
      {
         return current_point$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCurrentPoint)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,current_point$field);
         }
         _loc2_ = 0;
         while(_loc2_ < dice.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,dice[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:StackHeadExploreDiceMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ExplorePlayerMsg.currentPoint cannot be set twice.");
                  }
                  _loc3_++;
                  currentPoint = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  _loc4_ = new StackHeadExploreDiceMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  dice.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

