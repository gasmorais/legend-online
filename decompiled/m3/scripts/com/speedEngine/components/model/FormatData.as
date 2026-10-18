package com.speedEngine.components.model
{
   public class FormatData
   {
      
      private var _path:String;
      
      private var _data:FormatModel;
      
      private var _version:String;
      
      public function FormatData()
      {
         super();
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function set path(param1:String) : void
      {
         _path = param1;
      }
      
      public function get data() : FormatModel
      {
         return _data;
      }
      
      public function set data(param1:FormatModel) : void
      {
         _data = param1;
      }
      
      public function get version() : String
      {
         return _version;
      }
      
      public function set version(param1:String) : void
      {
         _version = param1;
      }
   }
}

