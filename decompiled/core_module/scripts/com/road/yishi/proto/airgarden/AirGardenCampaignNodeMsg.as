package com.road.yishi.proto.airgarden
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AirGardenCampaignNodeMsg extends Message implements IExternalizable
   {
      
      private var campaignNodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nodeTempId$field:int;
      
      private var objId$field:int;
      
      private var tempId$field:int;
      
      private var grade$field:int;
      
      private var hero$field:AirGardenHeroMsg;
      
      public function AirGardenCampaignNodeMsg()
      {
         super();
      }
      
      public function removeCampaignNodeId() : void
      {
         hasField$0 &= 4294967294;
         campaignNodeId$field = new int();
      }
      
      public function get hasCampaignNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set campaignNodeId(param1:int) : void
      {
         hasField$0 |= 1;
         campaignNodeId$field = param1;
      }
      
      public function get campaignNodeId() : int
      {
         return campaignNodeId$field;
      }
      
      public function removeNodeTempId() : void
      {
         hasField$0 &= 4294967293;
         nodeTempId$field = new int();
      }
      
      public function get hasNodeTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeTempId(param1:int) : void
      {
         hasField$0 |= 2;
         nodeTempId$field = param1;
      }
      
      public function get nodeTempId() : int
      {
         return nodeTempId$field;
      }
      
      public function removeObjId() : void
      {
         hasField$0 &= 4294967291;
         objId$field = new int();
      }
      
      public function get hasObjId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set objId(param1:int) : void
      {
         hasField$0 |= 4;
         objId$field = param1;
      }
      
      public function get objId() : int
      {
         return objId$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967287;
         tempId$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 8;
         tempId$field = param1;
      }
      
      public function get tempId() : int
      {
         return tempId$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967279;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 16;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeHero() : void
      {
         hero$field = null;
      }
      
      public function get hasHero() : Boolean
      {
         return hero$field != null;
      }
      
      public function set hero(param1:AirGardenHeroMsg) : void
      {
         hero$field = param1;
      }
      
      public function get hero() : AirGardenHeroMsg
      {
         return hero$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaignNodeId$field);
         }
         if(hasNodeTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,nodeTempId$field);
         }
         if(hasObjId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,objId$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,tempId$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasHero)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,hero$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignNodeMsg.campaignNodeId cannot be set twice.");
                  }
                  _loc9_++;
                  campaignNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignNodeMsg.nodeTempId cannot be set twice.");
                  }
                  _loc5_++;
                  nodeTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignNodeMsg.objId cannot be set twice.");
                  }
                  _loc7_++;
                  objId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignNodeMsg.tempId cannot be set twice.");
                  }
                  _loc4_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignNodeMsg.grade cannot be set twice.");
                  }
                  _loc6_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignNodeMsg.hero cannot be set twice.");
                  }
                  _loc3_++;
                  hero = new AirGardenHeroMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,hero);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

