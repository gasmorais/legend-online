package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FMDropMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.active.FMBaseItem")]
      public var fashionDrop:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.FMBaseItem")]
      public var mountDrop:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.FMBaseItem")]
      public var fashionHotDrop:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.FMBaseItem")]
      public var mountHotDrop:Array = [];
      
      public function FMDropMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < fashionDrop.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,fashionDrop[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < mountDrop.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,mountDrop[_loc2_]);
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < fashionHotDrop.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,fashionHotDrop[_loc5_]);
            _loc5_++;
         }
         _loc3_ = 0;
         while(_loc3_ < mountHotDrop.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,mountHotDrop[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:FMBaseItem = null;
         var _loc6_:FMBaseItem = null;
         var _loc3_:FMBaseItem = null;
         var _loc5_:FMBaseItem = null;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new FMBaseItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  fashionDrop.push(_loc4_);
                  break;
               case 1:
                  _loc6_ = new FMBaseItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  mountDrop.push(_loc6_);
                  break;
               case 2:
                  _loc3_ = new FMBaseItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  fashionHotDrop.push(_loc3_);
                  break;
               case 3:
                  _loc5_ = new FMBaseItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  mountHotDrop.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

