package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignNotifyMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var scene$field:String;
      
      private var map_id$field:int;
      
      private var body$field:String;
      
      private var delay$field:int;
      
      public function CampaignNotifyMsg()
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
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967293;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 2;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removeBody() : void
      {
         body$field = null;
      }
      
      public function get hasBody() : Boolean
      {
         return body$field != null;
      }
      
      public function set body(param1:String) : void
      {
         body$field = param1;
      }
      
      public function get body() : String
      {
         return body$field;
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
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasScene)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,scene$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasBody)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,body$field);
         }
         if(hasDelay)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,delay$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNotifyMsg.id cannot be set twice.");
                  }
                  _loc3_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNotifyMsg.scene cannot be set twice.");
                  }
                  _loc5_++;
                  scene = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNotifyMsg.mapId cannot be set twice.");
                  }
                  _loc6_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNotifyMsg.body cannot be set twice.");
                  }
                  _loc7_++;
                  body = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNotifyMsg.delay cannot be set twice.");
                  }
                  _loc4_++;
                  delay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

