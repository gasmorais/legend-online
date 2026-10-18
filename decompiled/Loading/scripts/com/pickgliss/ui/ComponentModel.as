package com.pickgliss.ui
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.system.System;
   import flash.utils.Dictionary;
   
   public final class ComponentModel
   {
      
      private var _allTipStyles:Vector.<String>;
      
      private var _bitmapSets:Dictionary;
      
      private var _componentStyle:Dictionary;
      
      private var _currentComponentSet:XML;
      
      private var _customObjectStyle:Dictionary;
      
      private var _loadedComponentSet:Dictionary;
      
      private var _shaderData:Dictionary;
      
      private var _styleSets:Dictionary;
      
      public function ComponentModel()
      {
         super();
         _componentStyle = new Dictionary();
         _customObjectStyle = new Dictionary();
         _styleSets = new Dictionary();
         _allTipStyles = new Vector.<String>();
         _shaderData = new Dictionary();
         _bitmapSets = new Dictionary();
         _loadedComponentSet = new Dictionary();
      }
      
      public function addBitmapSet(param1:String, param2:XML) : void
      {
         _bitmapSets[param1] = param2;
      }
      
      public function addComponentSet(param1:XML) : void
      {
         if(_loadedComponentSet[String(param1.@name)])
         {
            return;
         }
         _currentComponentSet = param1;
         _loadedComponentSet[String(_currentComponentSet.@name)] = new Dictionary();
         paras();
         System.disposeXML(param1);
      }
      
      public function get allTipStyles() : Vector.<String>
      {
         return _allTipStyles;
      }
      
      public function getBitmapSet(param1:String) : XML
      {
         return _bitmapSets[param1];
      }
      
      public function getComonentStyle(param1:String) : XML
      {
         return _componentStyle[param1];
      }
      
      public function getCustomObjectStyle(param1:String) : XML
      {
         return _customObjectStyle[param1];
      }
      
      public function getSet(param1:String) : *
      {
         return _styleSets[param1];
      }
      
      private function paras() : void
      {
         parasSets(_currentComponentSet..set);
         parasComponent(_currentComponentSet..component);
         parasCustomObject(_currentComponentSet..custom);
         if(_currentComponentSet.hasOwnProperty("tips"))
         {
            parasTipStyle(_currentComponentSet.tips);
         }
         if(_currentComponentSet.shaderFilters.length() > 0)
         {
         }
         parasBitmapDataSets(_currentComponentSet..bitmapData);
         parasBitmapSets(_currentComponentSet..bitmap);
      }
      
      private function parasBitmapDataSets(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _bitmapSets[String(param1[_loc3_].@resourceLink)] = param1[_loc3_];
            param1[_loc3_].@stylename = String(param1[_loc3_].@resourceLink);
            _loadedComponentSet[String(_currentComponentSet.@name)][String(param1[_loc3_].@resourceLink)] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function parasBitmapSets(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _bitmapSets[String(param1[_loc3_].@resourceLink)] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function parasComponent(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Error = null;
         var _loc2_:int = param1.length();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_componentStyle[String(param1[_loc3_].@stylename)] != null)
            {
               _loc4_ = new Error("样式重名。。。请注意检查!!!!!!!!" + String(param1[_loc3_].@stylename));
               throw _loc4_;
            }
            _componentStyle[String(param1[_loc3_].@stylename)] = param1[_loc3_];
            _loadedComponentSet[String(_currentComponentSet.@name)][String(param1[_loc3_].@stylename)] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function parasCustomObject(param1:XMLList) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length())
         {
            if(_customObjectStyle[String(param1[_loc2_].@stylename)] != null)
            {
               throw new Error("样式重名。。。请注意检查!!!!!!!!" + String(param1[_loc2_].@stylename));
            }
            _customObjectStyle[String(param1[_loc2_].@stylename)] = param1[_loc2_];
            _loadedComponentSet[String(_currentComponentSet.@name)][String(param1[_loc2_].@stylename)] = param1[_loc2_];
            _loc2_++;
         }
      }
      
      private function parasSets(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(String(param1[_loc3_].@type) == "flash.filters.ColorMatrixFilter")
            {
               _styleSets[String(param1[_loc3_].@stylename)] = ClassUtils.CreatInstance(param1[_loc3_].@type,[ComponentFactory.parasArgs(param1[_loc3_].@args)]);
            }
            else
            {
               _styleSets[String(param1[_loc3_].@stylename)] = ClassUtils.CreatInstance(param1[_loc3_].@type,ComponentFactory.parasArgs(param1[_loc3_].@args));
            }
            ObjectUtils.copyPorpertiesByXML(_styleSets[String(param1[_loc3_].@stylename)],param1[_loc3_]);
            _loadedComponentSet[String(_currentComponentSet.@name)][String(param1[_loc3_].@stylename)] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function parasTipStyle(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = String(param1[0].@alltips).split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_allTipStyles.indexOf(_loc2_[_loc3_]) == -1)
            {
               _allTipStyles.push(_loc2_[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      public function getComponentConfig(param1:String) : Array
      {
         loop0:
         for(var _loc2_:String in _loadedComponentSet)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loadedComponentSet[_loc2_];
            do
            {
               for(var _loc3_:String in _loc4_)
               {
               }
               continue loop0;
            }
            while(_loc3_ != param1);
            return [_loc2_,_loadedComponentSet[_loc2_][_loc3_]];
         }
         return null;
      }
      
      public function deleteComponentConfig(param1:String) : Array
      {
         loop0:
         for(var _loc2_:String in _loadedComponentSet)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loadedComponentSet[_loc2_];
            do
            {
               for(var _loc3_:String in _loc4_)
               {
               }
               continue loop0;
            }
            while(_loc3_ != param1);
            delete _loadedComponentSet[_loc2_][_loc3_];
            return [_loc2_,_loadedComponentSet[_loc2_][_loc3_]];
         }
         return null;
      }
      
      public function deleteConfig(param1:String) : void
      {
         var _loc2_:Dictionary = _loadedComponentSet[param1];
         for(var _loc3_:String in _loc2_)
         {
            delete _componentStyle[_loc3_];
            delete _customObjectStyle[_loc3_];
            delete _styleSets[_loc3_];
            delete _allTipStyles[_loc3_];
            delete _shaderData[_loc3_];
            delete _bitmapSets[_loc3_];
         }
         delete _loadedComponentSet[param1];
      }
      
      public function get loadedComponentSet() : Dictionary
      {
         return _loadedComponentSet;
      }
   }
}

