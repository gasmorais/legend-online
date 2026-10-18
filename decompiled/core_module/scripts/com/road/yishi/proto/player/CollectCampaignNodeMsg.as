package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CollectCampaignNodeMsg extends Message implements IExternalizable
   {
      
      private var mast_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var item$field:int;
      
      private var campaignDataId$field:int;
      
      private var son_type$field:int;
      
      private var name$field:String;
      
      public function CollectCampaignNodeMsg()
      {
         super();
      }
      
      public function removeMastType() : void
      {
         hasField$0 &= 4294967294;
         mast_type$field = new int();
      }
      
      public function get hasMastType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mastType(param1:int) : void
      {
         hasField$0 |= 1;
         mast_type$field = param1;
      }
      
      public function get mastType() : int
      {
         return mast_type$field;
      }
      
      public function removeItem() : void
      {
         hasField$0 &= 4294967293;
         item$field = new int();
      }
      
      public function get hasItem() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set item(param1:int) : void
      {
         hasField$0 |= 2;
         item$field = param1;
      }
      
      public function get item() : int
      {
         return item$field;
      }
      
      public function removeCampaignDataId() : void
      {
         hasField$0 &= 4294967291;
         campaignDataId$field = new int();
      }
      
      public function get hasCampaignDataId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set campaignDataId(param1:int) : void
      {
         hasField$0 |= 4;
         campaignDataId$field = param1;
      }
      
      public function get campaignDataId() : int
      {
         return campaignDataId$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967287;
         son_type$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 8;
         son_type$field = param1;
      }
      
      public function get sonType() : int
      {
         return son_type$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMastType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mast_type$field);
         }
         if(hasItem)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,item$field);
         }
         if(hasCampaignDataId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,campaignDataId$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,son_type$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CollectCampaignNodeMsg.mastType cannot be set twice.");
                  }
                  _loc5_++;
                  mastType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CollectCampaignNodeMsg.item cannot be set twice.");
                  }
                  _loc7_++;
                  item = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CollectCampaignNodeMsg.campaignDataId cannot be set twice.");
                  }
                  _loc6_++;
                  campaignDataId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CollectCampaignNodeMsg.sonType cannot be set twice.");
                  }
                  _loc3_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CollectCampaignNodeMsg.name cannot be set twice.");
                  }
                  _loc4_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

