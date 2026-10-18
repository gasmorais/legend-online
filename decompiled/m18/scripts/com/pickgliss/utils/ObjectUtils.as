package com.pickgliss.utils
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public final class ObjectUtils
   {
      
      private static var _copyAbleTypes:Vector.<String>;
      
      private static var _descriptOjbXMLs:Dictionary;
      
      public function ObjectUtils()
      {
         super();
      }
      
      public static function cloneSimpleObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function copyPorpertiesByXML(param1:Object, param2:XML) : void
      {
         var _loc6_:String = null;
         var _loc5_:String = null;
         if(param1.hasOwnProperty("beginChanges"))
         {
            param1["beginChanges"]();
         }
         var _loc4_:XMLList = param2.attributes();
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = _loc3_.name().toString();
            if(param1.hasOwnProperty(_loc6_))
            {
               _loc5_ = _loc3_.toString();
               if(_loc5_ == "false")
               {
                  param1[_loc6_] = false;
               }
               else
               {
                  param1[_loc6_] = _loc5_;
               }
            }
         }
         if(param1.hasOwnProperty("commitChanges"))
         {
            param1["commitChanges"]();
         }
      }
      
      public static function copyProperties(param1:Object, param2:Object, param3:Boolean = true) : void
      {
         var _loc9_:XMLList = null;
         var _loc8_:XML = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         if(_descriptOjbXMLs == null)
         {
            _descriptOjbXMLs = new Dictionary();
         }
         var _loc6_:Vector.<String> = getCopyAbleType();
         if(param3)
         {
            _loc8_ = describeTypeSave(param2);
         }
         else
         {
            _loc8_ = describeTypeSave(param1);
         }
         _loc9_ = _loc8_.variable;
         for each(var _loc4_:XML in _loc9_)
         {
            _loc7_ = _loc4_.@type;
            if(_loc6_.indexOf(_loc7_) != -1)
            {
               _loc5_ = _loc4_.@name;
               if(_loc7_ == "Date")
               {
                  param1[_loc5_] = copyDateType(param2[_loc5_]);
               }
               else if(param1.hasOwnProperty(_loc5_))
               {
                  param1[_loc5_] = param2[_loc5_];
               }
            }
         }
      }
      
      private static function copyDateType(param1:Object) : Date
      {
         if(!param1)
         {
            return null;
         }
         return new Date(param1["fullYear"],param1["month"],param1["date"],param1["hours"],param1["minutes"],param1["seconds"]);
      }
      
      public static function getObjectWidth(param1:DisplayObject) : Number
      {
         if(param1 is IManualSize)
         {
            return (param1 as IManualSize).viewRectangle.width;
         }
         if(param1 is IManualTipTargetSize)
         {
            return (param1 as IManualTipTargetSize).manualWidth;
         }
         if(param1 is Component)
         {
            return (param1 as Component).displayWidth;
         }
         return param1.width;
      }
      
      public static function getObjectHeight(param1:DisplayObject) : Number
      {
         if(param1 is IManualSize)
         {
            return (param1 as IManualSize).viewRectangle.height;
         }
         if(param1 is IManualTipTargetSize)
         {
            return (param1 as IManualTipTargetSize).manualHeight;
         }
         if(param1 is Component)
         {
            return (param1 as Component).displayHeight;
         }
         return param1.height;
      }
      
      public static function disposeAllChildren(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 == null)
         {
            return;
         }
         while(param1.numChildren > 0)
         {
            _loc2_ = param1.getChildAt(0);
            ObjectUtils.disposeObject(_loc2_);
         }
      }
      
      public static function stopAllSubClips(param1:DisplayObjectContainer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObjectContainer = null;
         var _loc4_:MovieClip = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 is MovieClip)
         {
            (param1 as MovieClip).stop();
         }
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_) as DisplayObjectContainer;
            if(_loc2_ != null)
            {
               stopAllSubClips(_loc2_);
            }
            _loc4_ = _loc2_ as MovieClip;
            if(_loc4_ != null)
            {
               _loc4_.stop();
            }
            _loc3_++;
         }
      }
      
      public static function removeFromParent(param1:DisplayObject) : void
      {
         if(param1 != null && param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public static function removeChildAllChildren(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObject = null;
         if(!param1)
         {
            return;
         }
         while(param1.numChildren > 0)
         {
            _loc2_ = param1.removeChildAt(0);
            ObjectUtils.disposeObject(_loc2_);
         }
      }
      
      public static function removeChildAllChildrenFromStage(param1:DisplayObjectContainer) : void
      {
         if(!param1)
         {
            return;
         }
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      public static function disposeAllGrandson(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1)
         {
            while(param1.numChildren > 0)
            {
               _loc2_ = param1.removeChildAt(0);
               if(_loc2_ is DisplayObjectContainer)
               {
                  ObjectUtils.disposeAllChildren(_loc2_ as DisplayObjectContainer);
               }
               else
               {
                  ObjectUtils.disposeObject(_loc2_);
               }
               _loc2_ = null;
            }
            ObjectUtils.disposeAllChildren(param1);
         }
         param1 = null;
      }
      
      public static function disposeViolentMc(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         if(param1)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
            if(param1 is MovieClip)
            {
               (param1 as MovieClip).stop();
            }
            if(param1 is Loader)
            {
               return;
            }
            _loc2_ = param1.numChildren - 1;
            _loc3_ = _loc2_;
            while(_loc3_ >= 0)
            {
               _loc4_ = param1.removeChildAt(_loc3_);
               if(_loc4_)
               {
                  if(_loc4_.parent)
                  {
                     _loc4_.parent.removeChild(_loc4_);
                  }
                  if(_loc4_ is MovieClip)
                  {
                     (_loc4_ as MovieClip).stop();
                  }
                  if(_loc4_ is DisplayObjectContainer)
                  {
                     disposeViolentMc(_loc4_ as DisplayObjectContainer);
                  }
                  else
                  {
                     disposeObject(_loc4_);
                     _loc4_ = null;
                  }
               }
               _loc3_--;
            }
            disposeObject(param1);
         }
      }
      
      public static function disposeObject(param1:Object) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc7_:Bitmap = null;
         var _loc2_:BitmapData = null;
         var _loc6_:DisplayObject = null;
         var _loc3_:MovieClip = null;
         var _loc4_:DisplayObject = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 is Disposeable)
         {
            if(param1 is DisplayObject)
            {
               _loc5_ = param1 as DisplayObject;
               if(_loc5_.parent)
               {
                  _loc5_.parent.removeChild(_loc5_);
               }
            }
            Disposeable(param1).dispose();
         }
         else if(param1 is Bitmap)
         {
            _loc7_ = Bitmap(param1);
            if(_loc7_.parent)
            {
               if(_loc7_.parent is Loader)
               {
                  (_loc7_.parent as Loader).unload();
               }
               else
               {
                  _loc7_.parent.removeChild(_loc7_);
               }
            }
            if(_loc7_.bitmapData)
            {
               _loc7_.bitmapData.dispose();
            }
         }
         else if(param1 is BitmapData)
         {
            _loc2_ = BitmapData(param1);
            _loc2_.dispose();
         }
         else if(param1.hasOwnProperty("dispose"))
         {
            if(param1 is DisplayObject)
            {
               _loc6_ = param1 as DisplayObject;
               if(_loc6_.parent)
               {
                  _loc6_.parent.removeChild(_loc6_);
               }
            }
            param1["dispose"]();
         }
         else if(param1 is MovieClip)
         {
            _loc3_ = MovieClip(param1);
            _loc3_.stop();
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
         }
         else if(param1 is DisplayObject)
         {
            _loc4_ = DisplayObject(param1);
            if(_loc4_.parent)
            {
               _loc4_.parent.removeChild(_loc4_);
            }
         }
         else if(param1 is ByteArray)
         {
            (param1 as ByteArray).clear();
         }
      }
      
      public static function clearDictionary(param1:Dictionary) : Dictionary
      {
         for(var _loc2_:String in param1)
         {
            delete param1[_loc2_];
         }
         return param1;
      }
      
      private static function getCopyAbleType() : Vector.<String>
      {
         if(_copyAbleTypes == null)
         {
            _copyAbleTypes = new Vector.<String>();
            _copyAbleTypes.push("int");
            _copyAbleTypes.push("uint");
            _copyAbleTypes.push("String");
            _copyAbleTypes.push("Boolean");
            _copyAbleTypes.push("Number");
            _copyAbleTypes.push("Date");
         }
         return _copyAbleTypes;
      }
      
      public static function describeTypeSave(param1:Object) : XML
      {
         var _loc2_:XML = null;
         var _loc3_:String = getQualifiedClassName(param1);
         if(_descriptOjbXMLs[_loc3_] != null)
         {
            _loc2_ = _descriptOjbXMLs[_loc3_];
         }
         else
         {
            _loc2_ = describeType(param1);
            _descriptOjbXMLs[_loc3_] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function encode(param1:String, param2:Object) : XML
      {
         var _loc6_:Object = null;
         var _loc4_:String = "<" + param1 + " ";
         var _loc3_:XML = describeTypeSave(param2);
         if(_loc3_.@name.toString() == "Object")
         {
            for(var _loc7_:String in param2)
            {
               _loc6_ = param2[_loc7_];
               if(!(_loc6_ is Function))
               {
                  _loc4_ += encodingProperty(_loc7_,_loc6_);
               }
            }
         }
         else
         {
            for each(var _loc5_:XML in _loc3_..*.(name() == "variable" || name() == "accessor"))
            {
               _loc4_ += encodingProperty(_loc5_.@name.toString(),param2[_loc5_.@name]);
            }
         }
         _loc4_ += "/>";
         return new XML(_loc4_);
      }
      
      private static function encodingProperty(param1:String, param2:Object) : String
      {
         if(param2 is Array)
         {
            return "";
         }
         return escapeString(param1) + "=\"" + String(param2) + "\" ";
      }
      
      private static function escapeString(param1:String) : String
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = "";
         var _loc4_:Number = param1.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            switch(_loc6_ = param1.charAt(_loc7_))
            {
               case "\"":
                  _loc3_ += "\\\"";
                  break;
               case "/":
                  _loc3_ += "\\/";
                  break;
               case "\\":
                  _loc3_ += "\\\\";
                  break;
               case "\b":
                  _loc3_ += "\\b";
                  break;
               case "\f":
                  _loc3_ += "\\f";
                  break;
               case "\n":
                  _loc3_ += "\\n";
                  break;
               case "\r":
                  _loc3_ += "\\r";
                  break;
               case "\t":
                  _loc3_ += "\\t";
                  break;
               default:
                  if(_loc6_ < " ")
                  {
                     _loc5_ = _loc6_.charCodeAt(0).toString(16);
                     _loc2_ = _loc5_.length == 2 ? "00" : "000";
                     _loc3_ += "\\u" + _loc2_ + _loc5_;
                  }
                  else
                  {
                     _loc3_ += _loc6_;
                  }
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public static function disposeSelf(param1:Object) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc2_ = param1 as DisplayObjectContainer;
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         param1 = null;
      }
      
      public static function modifyVisibility(param1:Boolean, ... rest) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < rest.length)
         {
            (rest[_loc3_] as DisplayObject).visible = param1;
            _loc3_++;
         }
      }
      
      public static function copyPropertyByRectangle(param1:DisplayObject, param2:Rectangle) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
         if(param2.width != 0)
         {
            param1.width = param2.width;
         }
         if(param2.height != 0)
         {
            param1.height = param2.height;
         }
      }
      
      public static function combineXML(param1:XML, param2:XML) : void
      {
         var _loc6_:String = null;
         var _loc5_:String = null;
         if(param2 == null || param1 == null)
         {
            return;
         }
         var _loc4_:XMLList = param2.attributes();
         for each(var _loc3_:XML in _loc4_)
         {
            _loc6_ = _loc3_.name().toString();
            _loc5_ = _loc3_.toString();
            if(!param1.hasOwnProperty("@" + _loc6_))
            {
               param1["@" + _loc6_] = _loc5_;
            }
         }
      }
      
      public static function cleanFrameScript(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return;
         }
         _loc2_ = 1;
         while(_loc2_ <= param1.totalFrames)
         {
            param1.addFrameScript(_loc2_,null);
            _loc2_++;
         }
      }
   }
}

