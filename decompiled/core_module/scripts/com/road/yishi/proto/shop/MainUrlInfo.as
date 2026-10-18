package com.road.yishi.proto.shop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MainUrlInfo extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var url$field:String;
      
      private var site$field:int;
      
      public function MainUrlInfo()
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
      
      public function removeUrl() : void
      {
         url$field = null;
      }
      
      public function get hasUrl() : Boolean
      {
         return url$field != null;
      }
      
      public function set url(param1:String) : void
      {
         url$field = param1;
      }
      
      public function get url() : String
      {
         return url$field;
      }
      
      public function removeSite() : void
      {
         hasField$0 &= 4294967293;
         site$field = new int();
      }
      
      public function get hasSite() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set site(param1:int) : void
      {
         hasField$0 |= 2;
         site$field = param1;
      }
      
      public function get site() : int
      {
         return site$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasUrl)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,url$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,site$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MainUrlInfo.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MainUrlInfo.url cannot be set twice.");
                  }
                  _loc5_++;
                  url = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MainUrlInfo.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

