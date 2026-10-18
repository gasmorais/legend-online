package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignReqMsg extends Message implements IExternalizable
   {
      
      private var para_int1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var para_int2$field:int;
      
      private var para_int3$field:int;
      
      private var para_int4$field:int;
      
      private var para_int5$field:int;
      
      private var para_string1$field:String;
      
      private var para_bool1$field:Boolean;
      
      private var server_name$field:String;
      
      private var isCross$field:Boolean;
      
      public function CampaignReqMsg()
      {
         super();
      }
      
      public function removeParaInt1() : void
      {
         hasField$0 &= 4294967294;
         para_int1$field = new int();
      }
      
      public function get hasParaInt1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set paraInt1(param1:int) : void
      {
         hasField$0 |= 1;
         para_int1$field = param1;
      }
      
      public function get paraInt1() : int
      {
         return para_int1$field;
      }
      
      public function removeParaInt2() : void
      {
         hasField$0 &= 4294967293;
         para_int2$field = new int();
      }
      
      public function get hasParaInt2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set paraInt2(param1:int) : void
      {
         hasField$0 |= 2;
         para_int2$field = param1;
      }
      
      public function get paraInt2() : int
      {
         return para_int2$field;
      }
      
      public function removeParaInt3() : void
      {
         hasField$0 &= 4294967291;
         para_int3$field = new int();
      }
      
      public function get hasParaInt3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set paraInt3(param1:int) : void
      {
         hasField$0 |= 4;
         para_int3$field = param1;
      }
      
      public function get paraInt3() : int
      {
         return para_int3$field;
      }
      
      public function removeParaInt4() : void
      {
         hasField$0 &= 4294967287;
         para_int4$field = new int();
      }
      
      public function get hasParaInt4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set paraInt4(param1:int) : void
      {
         hasField$0 |= 8;
         para_int4$field = param1;
      }
      
      public function get paraInt4() : int
      {
         return para_int4$field;
      }
      
      public function removeParaInt5() : void
      {
         hasField$0 &= 4294967279;
         para_int5$field = new int();
      }
      
      public function get hasParaInt5() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set paraInt5(param1:int) : void
      {
         hasField$0 |= 16;
         para_int5$field = param1;
      }
      
      public function get paraInt5() : int
      {
         return para_int5$field;
      }
      
      public function removeParaString1() : void
      {
         para_string1$field = null;
      }
      
      public function get hasParaString1() : Boolean
      {
         return para_string1$field != null;
      }
      
      public function set paraString1(param1:String) : void
      {
         para_string1$field = param1;
      }
      
      public function get paraString1() : String
      {
         return para_string1$field;
      }
      
      public function removeParaBool1() : void
      {
         hasField$0 &= 4294967263;
         para_bool1$field = new Boolean();
      }
      
      public function get hasParaBool1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set paraBool1(param1:Boolean) : void
      {
         hasField$0 |= 32;
         para_bool1$field = param1;
      }
      
      public function get paraBool1() : Boolean
      {
         return para_bool1$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeIsCross() : void
      {
         hasField$0 &= 4294967231;
         isCross$field = new Boolean();
      }
      
      public function get hasIsCross() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isCross(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isCross$field = param1;
      }
      
      public function get isCross() : Boolean
      {
         return isCross$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasParaInt1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,para_int1$field);
         }
         if(hasParaInt2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,para_int2$field);
         }
         if(hasParaInt3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,para_int3$field);
         }
         if(hasParaInt4)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,para_int4$field);
         }
         if(hasParaInt5)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,para_int5$field);
         }
         if(hasParaString1)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,para_string1$field);
         }
         if(hasParaBool1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,para_bool1$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasIsCross)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isCross$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.paraInt1 cannot be set twice.");
                  }
                  _loc7_++;
                  paraInt1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.paraInt2 cannot be set twice.");
                  }
                  _loc5_++;
                  paraInt2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.paraInt3 cannot be set twice.");
                  }
                  _loc12_++;
                  paraInt3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.paraInt4 cannot be set twice.");
                  }
                  _loc6_++;
                  paraInt4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.paraInt5 cannot be set twice.");
                  }
                  _loc10_++;
                  paraInt5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.paraString1 cannot be set twice.");
                  }
                  _loc3_++;
                  paraString1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.paraBool1 cannot be set twice.");
                  }
                  _loc4_++;
                  paraBool1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReqMsg.isCross cannot be set twice.");
                  }
                  _loc11_++;
                  isCross = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

