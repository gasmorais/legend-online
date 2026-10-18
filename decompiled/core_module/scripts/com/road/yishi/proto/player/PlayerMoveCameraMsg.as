package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerMoveCameraMsg extends Message implements IExternalizable
   {
      
      private var scene$field:String;
      
      private var target_x$field:int;
      
      private var hasField$0:uint = 0;
      
      private var target_y$field:int;
      
      private var delay$field:int;
      
      public function PlayerMoveCameraMsg()
      {
         super();
      }
      
      public function removeScene() : void
      {
         scene$field = null;
      }
      
      public function get hasScene() : Boolean
      {
         return scene$field != null;
      }
      
      public function set scene(param1:String) : void
      {
         scene$field = param1;
      }
      
      public function get scene() : String
      {
         return scene$field;
      }
      
      public function removeTargetX() : void
      {
         hasField$0 &= 4294967294;
         target_x$field = new int();
      }
      
      public function get hasTargetX() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set targetX(param1:int) : void
      {
         hasField$0 |= 1;
         target_x$field = param1;
      }
      
      public function get targetX() : int
      {
         return target_x$field;
      }
      
      public function removeTargetY() : void
      {
         hasField$0 &= 4294967293;
         target_y$field = new int();
      }
      
      public function get hasTargetY() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set targetY(param1:int) : void
      {
         hasField$0 |= 2;
         target_y$field = param1;
      }
      
      public function get targetY() : int
      {
         return target_y$field;
      }
      
      public function removeDelay() : void
      {
         hasField$0 &= 4294967291;
         delay$field = new int();
      }
      
      public function get hasDelay() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set delay(param1:int) : void
      {
         hasField$0 |= 4;
         delay$field = param1;
      }
      
      public function get delay() : int
      {
         return delay$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasScene)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,scene$field);
         }
         if(hasTargetX)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,target_x$field);
         }
         if(hasTargetY)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,target_y$field);
         }
         if(hasDelay)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,delay$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveCameraMsg.scene cannot be set twice.");
                  }
                  _loc6_++;
                  scene = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveCameraMsg.targetX cannot be set twice.");
                  }
                  _loc4_++;
                  targetX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveCameraMsg.targetY cannot be set twice.");
                  }
                  _loc3_++;
                  targetY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMoveCameraMsg.delay cannot be set twice.");
                  }
                  _loc5_++;
                  delay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

