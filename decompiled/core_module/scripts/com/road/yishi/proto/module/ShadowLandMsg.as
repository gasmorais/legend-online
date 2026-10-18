package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ShadowLandMsg extends Message implements IExternalizable
   {
      
      private var openAreaId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var checkpointId$field:int;
      
      private var bodyStrength$field:int;
      
      private var updateTime$field:String;
      
      private var boxStates$field:String;
      
      [ArrayElementType("com.road.yishi.proto.module.ShadowLandNodeMsg")]
      public var nodeList:Array = [];
      
      public function ShadowLandMsg()
      {
         super();
      }
      
      public function removeOpenAreaId() : void
      {
         hasField$0 &= 4294967294;
         openAreaId$field = new int();
      }
      
      public function get hasOpenAreaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set openAreaId(param1:int) : void
      {
         hasField$0 |= 1;
         openAreaId$field = param1;
      }
      
      public function get openAreaId() : int
      {
         return openAreaId$field;
      }
      
      public function removeCheckpointId() : void
      {
         hasField$0 &= 4294967293;
         checkpointId$field = new int();
      }
      
      public function get hasCheckpointId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set checkpointId(param1:int) : void
      {
         hasField$0 |= 2;
         checkpointId$field = param1;
      }
      
      public function get checkpointId() : int
      {
         return checkpointId$field;
      }
      
      public function removeBodyStrength() : void
      {
         hasField$0 &= 4294967291;
         bodyStrength$field = new int();
      }
      
      public function get hasBodyStrength() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bodyStrength(param1:int) : void
      {
         hasField$0 |= 4;
         bodyStrength$field = param1;
      }
      
      public function get bodyStrength() : int
      {
         return bodyStrength$field;
      }
      
      public function removeUpdateTime() : void
      {
         updateTime$field = null;
      }
      
      public function get hasUpdateTime() : Boolean
      {
         return updateTime$field != null;
      }
      
      public function set updateTime(param1:String) : void
      {
         updateTime$field = param1;
      }
      
      public function get updateTime() : String
      {
         return updateTime$field;
      }
      
      public function removeBoxStates() : void
      {
         boxStates$field = null;
      }
      
      public function get hasBoxStates() : Boolean
      {
         return boxStates$field != null;
      }
      
      public function set boxStates(param1:String) : void
      {
         boxStates$field = param1;
      }
      
      public function get boxStates() : String
      {
         return boxStates$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpenAreaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,openAreaId$field);
         }
         if(hasCheckpointId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,checkpointId$field);
         }
         if(hasBodyStrength)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,bodyStrength$field);
         }
         if(hasUpdateTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,updateTime$field);
         }
         if(hasBoxStates)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,boxStates$field);
         }
         _loc2_ = 0;
         while(_loc2_ < nodeList.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:ShadowLandNodeMsg = null;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ShadowLandMsg.openAreaId cannot be set twice.");
                  }
                  _loc9_++;
                  openAreaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ShadowLandMsg.checkpointId cannot be set twice.");
                  }
                  _loc7_++;
                  checkpointId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ShadowLandMsg.bodyStrength cannot be set twice.");
                  }
                  _loc4_++;
                  bodyStrength = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ShadowLandMsg.updateTime cannot be set twice.");
                  }
                  _loc3_++;
                  updateTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ShadowLandMsg.boxStates cannot be set twice.");
                  }
                  _loc6_++;
                  boxStates = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  _loc5_ = new ShadowLandNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  nodeList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

