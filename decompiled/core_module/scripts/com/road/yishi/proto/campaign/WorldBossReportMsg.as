package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossReportMsg extends Message implements IExternalizable
   {
      
      private var campaignId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var order$field:int;
      
      private var gold$field:Int64;
      
      private var strengy$field:Int64;
      
      private var total_wound$field:int;
      
      private var type$field:int;
      
      private var property1$field:String;
      
      public function WorldBossReportMsg()
      {
         super();
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967294;
         campaignId$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 1;
         campaignId$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaignId$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967293;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 2;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeGold() : void
      {
         gold$field = null;
      }
      
      public function get hasGold() : Boolean
      {
         return gold$field != null;
      }
      
      public function set gold(param1:Int64) : void
      {
         gold$field = param1;
      }
      
      public function get gold() : Int64
      {
         return gold$field;
      }
      
      public function removeStrengy() : void
      {
         strengy$field = null;
      }
      
      public function get hasStrengy() : Boolean
      {
         return strengy$field != null;
      }
      
      public function set strengy(param1:Int64) : void
      {
         strengy$field = param1;
      }
      
      public function get strengy() : Int64
      {
         return strengy$field;
      }
      
      public function removeTotalWound() : void
      {
         hasField$0 &= 4294967291;
         total_wound$field = new int();
      }
      
      public function get hasTotalWound() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalWound(param1:int) : void
      {
         hasField$0 |= 4;
         total_wound$field = param1;
      }
      
      public function get totalWound() : int
      {
         return total_wound$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967287;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
      {
         return property1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaignId$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasGold)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,gold$field);
         }
         if(hasStrengy)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,strengy$field);
         }
         if(hasTotalWound)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,total_wound$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossReportMsg.campaignId cannot be set twice.");
                  }
                  _loc10_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossReportMsg.order cannot be set twice.");
                  }
                  _loc4_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossReportMsg.gold cannot be set twice.");
                  }
                  _loc5_++;
                  gold = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossReportMsg.strengy cannot be set twice.");
                  }
                  _loc3_++;
                  strengy = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossReportMsg.totalWound cannot be set twice.");
                  }
                  _loc6_++;
                  totalWound = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossReportMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossReportMsg.property1 cannot be set twice.");
                  }
                  _loc7_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

