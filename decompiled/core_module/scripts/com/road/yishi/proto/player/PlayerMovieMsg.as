package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerMovieMsg extends Message implements IExternalizable
   {
      
      private var movie_target_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var target_id$field:int;
      
      private var movie_type$field:String;
      
      private var delay$field:int;
      
      private var map_id$field:int;
      
      public function PlayerMovieMsg()
      {
         super();
      }
      
      public function removeMovieTargetType() : void
      {
         hasField$0 &= 4294967294;
         movie_target_type$field = new int();
      }
      
      public function get hasMovieTargetType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set movieTargetType(param1:int) : void
      {
         hasField$0 |= 1;
         movie_target_type$field = param1;
      }
      
      public function get movieTargetType() : int
      {
         return movie_target_type$field;
      }
      
      public function removeTargetId() : void
      {
         hasField$0 &= 4294967293;
         target_id$field = new int();
      }
      
      public function get hasTargetId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set targetId(param1:int) : void
      {
         hasField$0 |= 2;
         target_id$field = param1;
      }
      
      public function get targetId() : int
      {
         return target_id$field;
      }
      
      public function removeMovieType() : void
      {
         movie_type$field = null;
      }
      
      public function get hasMovieType() : Boolean
      {
         return movie_type$field != null;
      }
      
      public function set movieType(param1:String) : void
      {
         movie_type$field = param1;
      }
      
      public function get movieType() : String
      {
         return movie_type$field;
      }
      
      public function removeDelay() : void
      {
         hasField$0 &= 4294967291;
         delay$field = new int();
      }
      
      public function get hasDelay() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set delay(param1:int) : void
      {
         hasField$0 |= 4;
         delay$field = param1;
      }
      
      public function get delay() : int
      {
         return delay$field;
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967287;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 8;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMovieTargetType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,movie_target_type$field);
         }
         if(hasTargetId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,target_id$field);
         }
         if(hasMovieType)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,movie_type$field);
         }
         if(hasDelay)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,delay$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMovieMsg.movieTargetType cannot be set twice.");
                  }
                  _loc3_++;
                  movieTargetType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMovieMsg.targetId cannot be set twice.");
                  }
                  _loc5_++;
                  targetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMovieMsg.movieType cannot be set twice.");
                  }
                  _loc8_++;
                  movieType = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMovieMsg.delay cannot be set twice.");
                  }
                  _loc4_++;
                  delay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerMovieMsg.mapId cannot be set twice.");
                  }
                  _loc6_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

