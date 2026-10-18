package com.speedEngine.components.model
{
   import avmplus.getQualifiedClassName;
   import com.speedEngine.utils.json.JSON;
   
   public class FileAdapter
   {
      
      public function FileAdapter()
      {
         super();
      }
      
      public static function getObjectData(param1:*) : FormatData
      {
         var _loc2_:String = getQualifiedClassName(param1);
         switch(_loc2_)
         {
            case "XML":
               return getObjectDataFromXml(param1);
            case "String":
               return getObjectDataFromJson(param1);
            default:
               return null;
         }
      }
      
      private static function getObjectDataFromJson(param1:String) : FormatData
      {
         var _loc4_:FormatModel = new FormatModel();
         var _loc2_:FormatData = new FormatData();
         var _loc3_:Object = com.speedEngine.utils.json.JSON.decode(param1);
         _loc2_.version = _loc3_.version;
         copyJsonData(_loc3_.components[0],_loc4_);
         _loc2_.data = _loc4_;
         return _loc2_;
      }
      
      private static function copyJsonData(param1:Object, param2:FormatModel) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc6_:Array = null;
         var _loc5_:FormatModel = null;
         var _loc7_:int = 0;
         for(_loc4_ in param1)
         {
            if(_loc4_ == "components")
            {
               _loc6_ = param1[_loc4_] as Array;
               _loc3_ = int(_loc6_.length);
               _loc7_ = 0;
               while(_loc7_ < _loc3_)
               {
                  _loc5_ = new FormatModel();
                  copyJsonData(_loc6_[_loc7_],_loc5_);
                  param2.puchChild(_loc5_);
                  _loc7_++;
               }
            }
            else if(_loc4_ == "classname")
            {
               param2.className = param1[_loc4_];
            }
            else if(_loc4_ == "name")
            {
               param2.objectName = param1[_loc4_];
               param2["name"] = param1[_loc4_];
            }
            else
            {
               param2[_loc4_] = param1[_loc4_];
            }
         }
      }
      
      private static function getObjectDataFromXml(param1:XML) : FormatData
      {
         var _loc4_:FormatModel = null;
         var _loc2_:XMLList = param1.components.component;
         var _loc3_:FormatData = new FormatData();
         _loc4_ = copyDataFromXMLList(_loc2_,new FormatModel());
         _loc3_.data = _loc4_;
         return _loc3_;
      }
      
      private static function copyDataFromXMLList(param1:XMLList, param2:FormatModel) : FormatModel
      {
         var _loc6_:XML = null;
         var _loc5_:FormatModel = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:int = param1.length();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = param1[_loc4_];
            _loc5_ = new FormatModel();
            copyData(_loc5_,_loc6_);
            if(param2)
            {
               param2.puchChild(_loc5_);
            }
            copyDataFromXMLList(_loc6_.child("component"),_loc5_);
            _loc4_++;
         }
         if(param2 == null)
         {
            return _loc5_;
         }
         return param2;
      }
      
      private static function copyData(param1:FormatModel, param2:XML) : void
      {
         var _loc6_:XML = null;
         var _loc4_:String = null;
         var _loc5_:XMLList = param2.attributes();
         var _loc3_:int = _loc5_.length();
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = _loc5_[_loc7_];
            _loc4_ = _loc6_.name();
            if(_loc4_ == "classname")
            {
               param1.className = _loc6_.toString();
            }
            else if(_loc4_ == "objectname")
            {
               param1.objectName = _loc6_.toString();
               param1["name"] = _loc6_.toString();
            }
            else
            {
               param1[_loc4_] = _loc6_.toString();
            }
            _loc7_++;
         }
      }
      
      public static function getJsonFromData(param1:FormatData) : String
      {
         var _loc2_:String = param1.version;
         var _loc3_:Array = [param1.data];
         var _loc5_:Object = {
            "version":_loc2_,
            "component":_loc3_
         };
         var _loc4_:String = com.speedEngine.utils.json.JSON.encode(_loc5_);
         _loc4_ = _loc4_.replace(/\"children\":null,/g,"");
         _loc4_ = _loc4_.replace(/\"children\":null/g,"");
         return _loc4_.replace(/\"children\":/g,"\"component\":");
      }
      
      public static function getXmlFromData(param1:FormatData) : String
      {
         var _loc2_:FormatModel = param1.data;
         var _loc4_:XML = <root/>;
         var _loc3_:XML = <components/>;
         _loc4_.appendChild(_loc3_);
         _loc4_.@version = param1.version;
         analyze(_loc2_,_loc3_);
         return _loc4_.toXMLString();
      }
      
      private static function analyze(param1:FormatModel, param2:XML) : void
      {
         var _loc7_:int = 0;
         var _loc6_:XML = <component/>;
         _loc6_.@classname = param1.className;
         _loc6_.@objectname = param1.objectName;
         for(var _loc4_:String in param1)
         {
            _loc6_[_loc4_] = param1[_loc4_];
         }
         param2.appendChild(_loc6_);
         var _loc5_:Array = param1.children;
         var _loc3_:int = _loc5_ ? _loc5_.length : 0;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            analyze(_loc5_[_loc7_],_loc6_);
            _loc7_++;
         }
      }
      
      private static function copyFormatModel(param1:FormatModel) : void
      {
      }
   }
}

