package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MapUpdatedMsg extends Message implements IExternalizable
   {
      
      private var updated_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var army$field:ArmyMsg;
      
      private var wild_land$field:WildLandMsg;
      
      private var base_castle$field:BaseCastleMsg;
      
      public function MapUpdatedMsg()
      {
         super();
      }
      
      public function removeUpdatedType() : void
      {
         hasField$0 &= 4294967294;
         updated_type$field = new int();
      }
      
      public function get hasUpdatedType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set updatedType(param1:int) : void
      {
         hasField$0 |= 1;
         updated_type$field = param1;
      }
      
      public function get updatedType() : int
      {
         return updated_type$field;
      }
      
      public function removeArmy() : void
      {
         army$field = null;
      }
      
      public function get hasArmy() : Boolean
      {
         return army$field != null;
      }
      
      public function set army(param1:ArmyMsg) : void
      {
         army$field = param1;
      }
      
      public function get army() : ArmyMsg
      {
         return army$field;
      }
      
      public function removeWildLand() : void
      {
         wild_land$field = null;
      }
      
      public function get hasWildLand() : Boolean
      {
         return wild_land$field != null;
      }
      
      public function set wildLand(param1:WildLandMsg) : void
      {
         wild_land$field = param1;
      }
      
      public function get wildLand() : WildLandMsg
      {
         return wild_land$field;
      }
      
      public function removeBaseCastle() : void
      {
         base_castle$field = null;
      }
      
      public function get hasBaseCastle() : Boolean
      {
         return base_castle$field != null;
      }
      
      public function set baseCastle(param1:BaseCastleMsg) : void
      {
         base_castle$field = param1;
      }
      
      public function get baseCastle() : BaseCastleMsg
      {
         return base_castle$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUpdatedType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,updated_type$field);
         }
         if(hasArmy)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,army$field);
         }
         if(hasWildLand)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,wild_land$field);
         }
         if(hasBaseCastle)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,base_castle$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MapUpdatedMsg.updatedType cannot be set twice.");
                  }
                  _loc4_++;
                  updatedType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MapUpdatedMsg.army cannot be set twice.");
                  }
                  _loc7_++;
                  army = new ArmyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,army);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MapUpdatedMsg.wildLand cannot be set twice.");
                  }
                  _loc5_++;
                  wildLand = new WildLandMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,wildLand);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MapUpdatedMsg.baseCastle cannot be set twice.");
                  }
                  _loc3_++;
                  baseCastle = new BaseCastleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,baseCastle);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

