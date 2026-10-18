package com.road.yishi.proto.avenger
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DarkMazeMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var layer$field:int;
      
      private var nodeId$field:int;
      
      private var targetId$field:int;
      
      private var nodeInfo$field:String;
      
      private var pathInfo$field:String;
      
      private var posInfo$field:String;
      
      [ArrayElementType("com.road.yishi.proto.avenger.DarkMazeChildMsg")]
      public var childs:Array = [];
      
      private var buyInfo$field:String;
      
      public function DarkMazeMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeLayer() : void
      {
         hasField$0 &= 4294967293;
         layer$field = new int();
      }
      
      public function get hasLayer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set layer(param1:int) : void
      {
         hasField$0 |= 2;
         layer$field = param1;
      }
      
      public function get layer() : int
      {
         return layer$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967291;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 4;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeTargetId() : void
      {
         hasField$0 &= 4294967287;
         targetId$field = new int();
      }
      
      public function get hasTargetId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set targetId(param1:int) : void
      {
         hasField$0 |= 8;
         targetId$field = param1;
      }
      
      public function get targetId() : int
      {
         return targetId$field;
      }
      
      public function removeNodeInfo() : void
      {
         nodeInfo$field = null;
      }
      
      public function get hasNodeInfo() : Boolean
      {
         return nodeInfo$field != null;
      }
      
      public function set nodeInfo(param1:String) : void
      {
         nodeInfo$field = param1;
      }
      
      public function get nodeInfo() : String
      {
         return nodeInfo$field;
      }
      
      public function removePathInfo() : void
      {
         pathInfo$field = null;
      }
      
      public function get hasPathInfo() : Boolean
      {
         return pathInfo$field != null;
      }
      
      public function set pathInfo(param1:String) : void
      {
         pathInfo$field = param1;
      }
      
      public function get pathInfo() : String
      {
         return pathInfo$field;
      }
      
      public function removePosInfo() : void
      {
         posInfo$field = null;
      }
      
      public function get hasPosInfo() : Boolean
      {
         return posInfo$field != null;
      }
      
      public function set posInfo(param1:String) : void
      {
         posInfo$field = param1;
      }
      
      public function get posInfo() : String
      {
         return posInfo$field;
      }
      
      public function removeBuyInfo() : void
      {
         buyInfo$field = null;
      }
      
      public function get hasBuyInfo() : Boolean
      {
         return buyInfo$field != null;
      }
      
      public function set buyInfo(param1:String) : void
      {
         buyInfo$field = param1;
      }
      
      public function get buyInfo() : String
      {
         return buyInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasLayer)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,layer$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasTargetId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,targetId$field);
         }
         if(hasNodeInfo)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,nodeInfo$field);
         }
         if(hasPathInfo)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,pathInfo$field);
         }
         if(hasPosInfo)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,posInfo$field);
         }
         _loc2_ = 0;
         while(_loc2_ < childs.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,childs[_loc2_]);
            _loc2_++;
         }
         if(hasBuyInfo)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,buyInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc10_:DarkMazeChildMsg = null;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.opType cannot be set twice.");
                  }
                  _loc5_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.layer cannot be set twice.");
                  }
                  _loc7_++;
                  layer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.targetId cannot be set twice.");
                  }
                  _loc9_++;
                  targetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.nodeInfo cannot be set twice.");
                  }
                  _loc12_++;
                  nodeInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.pathInfo cannot be set twice.");
                  }
                  _loc4_++;
                  pathInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.posInfo cannot be set twice.");
                  }
                  _loc11_++;
                  posInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  _loc10_ = new DarkMazeChildMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  childs.push(_loc10_);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeMsg.buyInfo cannot be set twice.");
                  }
                  _loc6_++;
                  buyInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

