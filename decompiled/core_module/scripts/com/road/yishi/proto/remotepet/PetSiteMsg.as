package com.road.yishi.proto.remotepet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetSiteMsg extends Message implements IExternalizable
   {
      
      private var site$field:int;
      
      private var hasField$0:uint = 0;
      
      private var petId$field:int;
      
      private var skills$field:String;
      
      public function PetSiteMsg()
      {
         super();
      }
      
      public function removeSite() : void
      {
         hasField$0 &= 4294967294;
         site$field = new int();
      }
      
      public function get hasSite() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set site(param1:int) : void
      {
         hasField$0 |= 1;
         site$field = param1;
      }
      
      public function get site() : int
      {
         return site$field;
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967293;
         petId$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 2;
         petId$field = param1;
      }
      
      public function get petId() : int
      {
         return petId$field;
      }
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSite)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,site$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,petId$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetSiteMsg.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetSiteMsg.petId cannot be set twice.");
                  }
                  _loc4_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PetSiteMsg.skills cannot be set twice.");
                  }
                  _loc6_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

