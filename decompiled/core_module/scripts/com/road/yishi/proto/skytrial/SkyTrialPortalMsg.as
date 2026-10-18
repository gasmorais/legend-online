package com.road.yishi.proto.skytrial
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialPortalMsg extends Message implements IExternalizable
   {
      
      public var portalId:int;
      
      private var search_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var clear$field:Boolean;
      
      public function SkyTrialPortalMsg()
      {
         super();
      }
      
      public function removeSearchCount() : void
      {
         hasField$0 &= 4294967294;
         search_count$field = new int();
      }
      
      public function get hasSearchCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set searchCount(param1:int) : void
      {
         hasField$0 |= 1;
         search_count$field = param1;
      }
      
      public function get searchCount() : int
      {
         return search_count$field;
      }
      
      public function removeClear() : void
      {
         hasField$0 &= 4294967293;
         clear$field = new Boolean();
      }
      
      public function get hasClear() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set clear(param1:Boolean) : void
      {
         hasField$0 |= 2;
         clear$field = param1;
      }
      
      public function get clear() : Boolean
      {
         return clear$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,portalId);
         if(hasSearchCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,search_count$field);
         }
         if(hasClear)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,clear$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPortalMsg.portalId cannot be set twice.");
                  }
                  _loc3_++;
                  portalId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPortalMsg.searchCount cannot be set twice.");
                  }
                  _loc6_++;
                  searchCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPortalMsg.clear cannot be set twice.");
                  }
                  _loc4_++;
                  clear = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc3_ != 1)
         {
            throw new IOError("Bad data format: SkyTrialPortalMsg.portalId must be set.");
         }
      }
   }
}

