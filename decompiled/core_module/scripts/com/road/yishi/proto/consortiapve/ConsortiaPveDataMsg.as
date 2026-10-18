package com.road.yishi.proto.consortiapve
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaPveDataMsg extends Message implements IExternalizable
   {
      
      private var curNodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.consortiapve.ConsortiaPveAreaBoxMsg")]
      public var boxs:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.consortiapve.ConsortiaPveNodeMsg")]
      public var nodes:Array = [];
      
      private var serverName$field:String;
      
      public function ConsortiaPveDataMsg()
      {
         super();
      }
      
      public function removeCurNodeId() : void
      {
         hasField$0 &= 4294967294;
         curNodeId$field = new int();
      }
      
      public function get hasCurNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curNodeId(param1:int) : void
      {
         hasField$0 |= 1;
         curNodeId$field = param1;
      }
      
      public function get curNodeId() : int
      {
         return curNodeId$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasCurNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,curNodeId$field);
         }
         _loc3_ = 0;
         while(_loc3_ < boxs.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,boxs[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < nodes.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,nodes[_loc2_]);
            _loc2_++;
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:ConsortiaPveAreaBoxMsg = null;
         var _loc5_:ConsortiaPveNodeMsg = null;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveDataMsg.curNodeId cannot be set twice.");
                  }
                  _loc7_++;
                  curNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new ConsortiaPveAreaBoxMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  boxs.push(_loc4_);
                  break;
               case 2:
                  _loc5_ = new ConsortiaPveNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  nodes.push(_loc5_);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaPveDataMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

