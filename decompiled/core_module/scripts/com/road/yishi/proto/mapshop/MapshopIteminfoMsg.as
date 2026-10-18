package com.road.yishi.proto.mapshop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MapshopIteminfoMsg extends Message implements IExternalizable
   {
      
      private var mapshopitemid$field:int;
      
      private var hasField$0:uint = 0;
      
      private var mapshopcostid$field:int;
      
      private var isbuy$field:Boolean;
      
      private var index$field:int;
      
      public function MapshopIteminfoMsg()
      {
         super();
      }
      
      public function removeMapshopitemid() : void
      {
         hasField$0 &= 4294967294;
         mapshopitemid$field = new int();
      }
      
      public function get hasMapshopitemid() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapshopitemid(param1:int) : void
      {
         hasField$0 |= 1;
         mapshopitemid$field = param1;
      }
      
      public function get mapshopitemid() : int
      {
         return mapshopitemid$field;
      }
      
      public function removeMapshopcostid() : void
      {
         hasField$0 &= 4294967293;
         mapshopcostid$field = new int();
      }
      
      public function get hasMapshopcostid() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mapshopcostid(param1:int) : void
      {
         hasField$0 |= 2;
         mapshopcostid$field = param1;
      }
      
      public function get mapshopcostid() : int
      {
         return mapshopcostid$field;
      }
      
      public function removeIsbuy() : void
      {
         hasField$0 &= 4294967291;
         isbuy$field = new Boolean();
      }
      
      public function get hasIsbuy() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isbuy(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isbuy$field = param1;
      }
      
      public function get isbuy() : Boolean
      {
         return isbuy$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967287;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 8;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMapshopitemid)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mapshopitemid$field);
         }
         if(hasMapshopcostid)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,mapshopcostid$field);
         }
         if(hasIsbuy)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isbuy$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MapshopIteminfoMsg.mapshopitemid cannot be set twice.");
                  }
                  _loc7_++;
                  mapshopitemid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MapshopIteminfoMsg.mapshopcostid cannot be set twice.");
                  }
                  _loc3_++;
                  mapshopcostid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MapshopIteminfoMsg.isbuy cannot be set twice.");
                  }
                  _loc5_++;
                  isbuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MapshopIteminfoMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

