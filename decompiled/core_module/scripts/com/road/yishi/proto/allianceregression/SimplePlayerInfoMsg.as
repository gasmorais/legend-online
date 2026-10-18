package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SimplePlayerInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var isExist$field:int;
      
      private var sexs$field:int;
      
      private var pics$field:int;
      
      private var camp$field:int;
      
      public function SimplePlayerInfoMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967293;
         isExist$field = new int();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isExist(param1:int) : void
      {
         hasField$0 |= 2;
         isExist$field = param1;
      }
      
      public function get isExist() : int
      {
         return isExist$field;
      }
      
      public function removeSexs() : void
      {
         hasField$0 &= 4294967291;
         sexs$field = new int();
      }
      
      public function get hasSexs() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sexs(param1:int) : void
      {
         hasField$0 |= 4;
         sexs$field = param1;
      }
      
      public function get sexs() : int
      {
         return sexs$field;
      }
      
      public function removePics() : void
      {
         hasField$0 &= 4294967287;
         pics$field = new int();
      }
      
      public function get hasPics() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pics(param1:int) : void
      {
         hasField$0 |= 8;
         pics$field = param1;
      }
      
      public function get pics() : int
      {
         return pics$field;
      }
      
      public function removeCamp() : void
      {
         hasField$0 &= 4294967279;
         camp$field = new int();
      }
      
      public function get hasCamp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set camp(param1:int) : void
      {
         hasField$0 |= 16;
         camp$field = param1;
      }
      
      public function get camp() : int
      {
         return camp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,isExist$field);
         }
         if(hasSexs)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,sexs$field);
         }
         if(hasPics)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pics$field);
         }
         if(hasCamp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,camp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.isExist cannot be set twice.");
                  }
                  _loc4_++;
                  isExist = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.sexs cannot be set twice.");
                  }
                  _loc5_++;
                  sexs = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.pics cannot be set twice.");
                  }
                  _loc9_++;
                  pics = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SimplePlayerInfoMsg.camp cannot be set twice.");
                  }
                  _loc6_++;
                  camp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

