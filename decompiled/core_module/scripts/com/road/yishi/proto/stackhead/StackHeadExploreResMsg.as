package com.road.yishi.proto.stackhead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadExploreResMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var result$field:Boolean;
      
      private var error_code$field:int;
      
      private var context$field:StackHeadExploreMsg;
      
      private var explore_player$field:ExplorePlayerMsg;
      
      private var updated_node$field:StackHeadExploreNodeMsg;
      
      public function StackHeadExploreResMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967293;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 2;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeErrorCode() : void
      {
         hasField$0 &= 4294967291;
         error_code$field = new int();
      }
      
      public function get hasErrorCode() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set errorCode(param1:int) : void
      {
         hasField$0 |= 4;
         error_code$field = param1;
      }
      
      public function get errorCode() : int
      {
         return error_code$field;
      }
      
      public function removeContext() : void
      {
         context$field = null;
      }
      
      public function get hasContext() : Boolean
      {
         return context$field != null;
      }
      
      public function set context(param1:StackHeadExploreMsg) : void
      {
         context$field = param1;
      }
      
      public function get context() : StackHeadExploreMsg
      {
         return context$field;
      }
      
      public function removeExplorePlayer() : void
      {
         explore_player$field = null;
      }
      
      public function get hasExplorePlayer() : Boolean
      {
         return explore_player$field != null;
      }
      
      public function set explorePlayer(param1:ExplorePlayerMsg) : void
      {
         explore_player$field = param1;
      }
      
      public function get explorePlayer() : ExplorePlayerMsg
      {
         return explore_player$field;
      }
      
      public function removeUpdatedNode() : void
      {
         updated_node$field = null;
      }
      
      public function get hasUpdatedNode() : Boolean
      {
         return updated_node$field != null;
      }
      
      public function set updatedNode(param1:StackHeadExploreNodeMsg) : void
      {
         updated_node$field = param1;
      }
      
      public function get updatedNode() : StackHeadExploreNodeMsg
      {
         return updated_node$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasErrorCode)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_ENUM(param1,error_code$field);
         }
         if(hasContext)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,context$field);
         }
         if(hasExplorePlayer)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,explore_player$field);
         }
         if(hasUpdatedNode)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,updated_node$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreResMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreResMsg.result cannot be set twice.");
                  }
                  _loc5_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreResMsg.errorCode cannot be set twice.");
                  }
                  _loc8_++;
                  errorCode = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreResMsg.context cannot be set twice.");
                  }
                  _loc4_++;
                  context = new StackHeadExploreMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,context);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreResMsg.explorePlayer cannot be set twice.");
                  }
                  _loc3_++;
                  explorePlayer = new ExplorePlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,explorePlayer);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadExploreResMsg.updatedNode cannot be set twice.");
                  }
                  _loc6_++;
                  updatedNode = new StackHeadExploreNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,updatedNode);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

