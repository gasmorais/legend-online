package com.road.yishi.proto.chat
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CatRequestInfoMsg extends Message implements IExternalizable
   {
      
      private var parm1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var parm2$field:int;
      
      private var parm3$field:int;
      
      [ArrayElementType("com.road.yishi.proto.chat.CatMsg")]
      public var __import:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.chat.CatMsg")]
      public var export:Array = [];
      
      private var update$field:CatMsg;
      
      [ArrayElementType("int")]
      public var requestUserId:Array = [];
      
      public function CatRequestInfoMsg()
      {
         super();
      }
      
      public function removeParm1() : void
      {
         hasField$0 &= 4294967294;
         parm1$field = new int();
      }
      
      public function get hasParm1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set parm1(param1:int) : void
      {
         hasField$0 |= 1;
         parm1$field = param1;
      }
      
      public function get parm1() : int
      {
         return parm1$field;
      }
      
      public function removeParm2() : void
      {
         hasField$0 &= 4294967293;
         parm2$field = new int();
      }
      
      public function get hasParm2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set parm2(param1:int) : void
      {
         hasField$0 |= 2;
         parm2$field = param1;
      }
      
      public function get parm2() : int
      {
         return parm2$field;
      }
      
      public function removeParm3() : void
      {
         hasField$0 &= 4294967291;
         parm3$field = new int();
      }
      
      public function get hasParm3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set parm3(param1:int) : void
      {
         hasField$0 |= 4;
         parm3$field = param1;
      }
      
      public function get parm3() : int
      {
         return parm3$field;
      }
      
      public function removeUpdate() : void
      {
         update$field = null;
      }
      
      public function get hasUpdate() : Boolean
      {
         return update$field != null;
      }
      
      public function set update(param1:CatMsg) : void
      {
         update$field = param1;
      }
      
      public function get update() : CatMsg
      {
         return update$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasParm1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,parm1$field);
         }
         if(hasParm2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,parm2$field);
         }
         if(hasParm3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,parm3$field);
         }
         _loc4_ = 0;
         while(_loc4_ < __import.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,__import[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < export.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,export[_loc2_]);
            _loc2_++;
         }
         if(hasUpdate)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,update$field);
         }
         _loc3_ = 0;
         while(_loc3_ < requestUserId.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,requestUserId[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:CatMsg = null;
         var _loc9_:CatMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CatRequestInfoMsg.parm1 cannot be set twice.");
                  }
                  _loc3_++;
                  parm1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CatRequestInfoMsg.parm2 cannot be set twice.");
                  }
                  _loc5_++;
                  parm2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CatRequestInfoMsg.parm3 cannot be set twice.");
                  }
                  _loc8_++;
                  parm3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc6_ = new CatMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  __import.push(_loc6_);
                  break;
               case 4:
                  _loc9_ = new CatMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  export.push(_loc9_);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CatRequestInfoMsg.update cannot be set twice.");
                  }
                  _loc4_++;
                  update = new CatMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,update);
                  break;
               case 6:
                  if((_loc7_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,requestUserId);
                  }
                  else
                  {
                     requestUserId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

