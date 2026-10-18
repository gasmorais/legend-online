package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VersionMsg extends Message implements IExternalizable
   {
      
      private var open_version$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var version_id$field:int;
      
      private var open_story$field:Boolean;
      
      private var module$field:int;
      
      public function VersionMsg()
      {
         super();
      }
      
      public function removeOpenVersion() : void
      {
         hasField$0 &= 4294967294;
         open_version$field = new Boolean();
      }
      
      public function get hasOpenVersion() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set openVersion(param1:Boolean) : void
      {
         hasField$0 |= 1;
         open_version$field = param1;
      }
      
      public function get openVersion() : Boolean
      {
         return open_version$field;
      }
      
      public function removeVersionId() : void
      {
         hasField$0 &= 4294967293;
         version_id$field = new int();
      }
      
      public function get hasVersionId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set versionId(param1:int) : void
      {
         hasField$0 |= 2;
         version_id$field = param1;
      }
      
      public function get versionId() : int
      {
         return version_id$field;
      }
      
      public function removeOpenStory() : void
      {
         hasField$0 &= 4294967291;
         open_story$field = new Boolean();
      }
      
      public function get hasOpenStory() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set openStory(param1:Boolean) : void
      {
         hasField$0 |= 4;
         open_story$field = param1;
      }
      
      public function get openStory() : Boolean
      {
         return open_story$field;
      }
      
      public function removeModule() : void
      {
         hasField$0 &= 4294967287;
         module$field = new int();
      }
      
      public function get hasModule() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set module(param1:int) : void
      {
         hasField$0 |= 8;
         module$field = param1;
      }
      
      public function get module() : int
      {
         return module$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpenVersion)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,open_version$field);
         }
         if(hasVersionId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,version_id$field);
         }
         if(hasOpenStory)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,open_story$field);
         }
         if(hasModule)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,module$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VersionMsg.openVersion cannot be set twice.");
                  }
                  _loc3_++;
                  openVersion = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VersionMsg.versionId cannot be set twice.");
                  }
                  _loc4_++;
                  versionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VersionMsg.openStory cannot be set twice.");
                  }
                  _loc7_++;
                  openStory = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VersionMsg.module cannot be set twice.");
                  }
                  _loc5_++;
                  module = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

