package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerAASRefreshMsg extends Message implements IExternalizable
   {
      
      private var aasOnlineTime$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isCloseAAS$field:Boolean;
      
      private var sysSwitch$field:Boolean;
      
      public function PlayerAASRefreshMsg()
      {
         super();
      }
      
      public function removeAasOnlineTime() : void
      {
         hasField$0 &= 4294967294;
         aasOnlineTime$field = new int();
      }
      
      public function get hasAasOnlineTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set aasOnlineTime(param1:int) : void
      {
         hasField$0 |= 1;
         aasOnlineTime$field = param1;
      }
      
      public function get aasOnlineTime() : int
      {
         return aasOnlineTime$field;
      }
      
      public function removeIsCloseAAS() : void
      {
         hasField$0 &= 4294967293;
         isCloseAAS$field = new Boolean();
      }
      
      public function get hasIsCloseAAS() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isCloseAAS(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isCloseAAS$field = param1;
      }
      
      public function get isCloseAAS() : Boolean
      {
         return isCloseAAS$field;
      }
      
      public function removeSysSwitch() : void
      {
         hasField$0 &= 4294967291;
         sysSwitch$field = new Boolean();
      }
      
      public function get hasSysSwitch() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sysSwitch(param1:Boolean) : void
      {
         hasField$0 |= 4;
         sysSwitch$field = param1;
      }
      
      public function get sysSwitch() : Boolean
      {
         return sysSwitch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAasOnlineTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,aasOnlineTime$field);
         }
         if(hasIsCloseAAS)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isCloseAAS$field);
         }
         if(hasSysSwitch)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,sysSwitch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASRefreshMsg.aasOnlineTime cannot be set twice.");
                  }
                  _loc6_++;
                  aasOnlineTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASRefreshMsg.isCloseAAS cannot be set twice.");
                  }
                  _loc4_++;
                  isCloseAAS = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAASRefreshMsg.sysSwitch cannot be set twice.");
                  }
                  _loc3_++;
                  sysSwitch = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

