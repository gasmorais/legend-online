package com.road.yishi.proto.gameplot
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlotMsg extends Message implements IExternalizable
   {
      
      private var loop$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var scene_type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.gameplot.PlotInfoMsg")]
      public var info:Array = [];
      
      public function PlotMsg()
      {
         super();
      }
      
      public function removeLoop() : void
      {
         hasField$0 &= 4294967294;
         loop$field = new Boolean();
      }
      
      public function get hasLoop() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set loop(param1:Boolean) : void
      {
         hasField$0 |= 1;
         loop$field = param1;
      }
      
      public function get loop() : Boolean
      {
         return loop$field;
      }
      
      public function removeSceneType() : void
      {
         hasField$0 &= 4294967293;
         scene_type$field = new int();
      }
      
      public function get hasSceneType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sceneType(param1:int) : void
      {
         hasField$0 |= 2;
         scene_type$field = param1;
      }
      
      public function get sceneType() : int
      {
         return scene_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasLoop)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,loop$field);
         }
         if(hasSceneType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,scene_type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:PlotInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlotMsg.loop cannot be set twice.");
                  }
                  _loc3_++;
                  loop = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlotMsg.sceneType cannot be set twice.");
                  }
                  _loc5_++;
                  sceneType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc4_ = new PlotInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  info.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

