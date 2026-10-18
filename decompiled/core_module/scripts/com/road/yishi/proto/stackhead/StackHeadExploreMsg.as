package com.road.yishi.proto.stackhead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadExploreMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var raw_node$field:StackHeadExploreRawNodeMsg;
      
      [ArrayElementType("com.road.yishi.proto.stackhead.StackHeadExploreNodeMsg")]
      public var node:Array = [];
      
      public function StackHeadExploreMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeRawNode() : void
      {
         raw_node$field = null;
      }
      
      public function get hasRawNode() : Boolean
      {
         return raw_node$field != null;
      }
      
      public function set rawNode(param1:StackHeadExploreRawNodeMsg) : void
      {
         raw_node$field = param1;
      }
      
      public function get rawNode() : StackHeadExploreRawNodeMsg
      {
         return raw_node$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasRawNode)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,raw_node$field);
         }
         _loc2_ = 0;
         while(_loc2_ < node.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,node[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:StackHeadExploreNodeMsg = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreMsg.rawNode cannot be set twice.");
                  }
                  _loc4_++;
                  rawNode = new StackHeadExploreRawNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rawNode);
                  break;
               case 2:
                  _loc3_ = new StackHeadExploreNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  node.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

