package com.road.yishi.proto.archaeology
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArchaeologyOuterMsg extends Message implements IExternalizable
   {
      
      private var rest_exploration_count$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.archaeology.ArchaeologyNodeMsg")]
      public var node:Array = [];
      
      public function ArchaeologyOuterMsg()
      {
         super();
      }
      
      public function removeRestExplorationCount() : void
      {
         hasField$0 &= 4294967294;
         rest_exploration_count$field = new int();
      }
      
      public function get hasRestExplorationCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set restExplorationCount(param1:int) : void
      {
         hasField$0 |= 1;
         rest_exploration_count$field = param1;
      }
      
      public function get restExplorationCount() : int
      {
         return rest_exploration_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasRestExplorationCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rest_exploration_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < node.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,node[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:ArchaeologyNodeMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArchaeologyOuterMsg.restExplorationCount cannot be set twice.");
                  }
                  _loc3_++;
                  restExplorationCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new ArchaeologyNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  node.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

