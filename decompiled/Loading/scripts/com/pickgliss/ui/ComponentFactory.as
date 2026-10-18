package com.pickgliss.ui
{
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.setInterval;
   
   public final class ComponentFactory
   {
      
      private static var _instance:ComponentFactory;
      
      private static var COMPONENT_COUNTER:int = 1;
      
      private var _allComponents:Dictionary;
      
      private var _instanceDic:Dictionary;
      
      private var _model:ComponentModel;
      
      public var preStylename:String;
      
      public function ComponentFactory(param1:ComponentFactoryEnforcer)
      {
         super();
         _model = new ComponentModel();
         _allComponents = new Dictionary();
         _instanceDic = new Dictionary(true);
         ClassUtils.uiSourceDomain = ApplicationDomain.currentDomain;
         setInterval(checkGC,300000);
      }
      
      public static function get Instance() : ComponentFactory
      {
         if(_instance == null)
         {
            _instance = new ComponentFactory(new ComponentFactoryEnforcer());
         }
         return _instance;
      }
      
      public static function parasArgs(param1:String) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = param1.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            StringUtils.trim(_loc3_[_loc2_]);
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function checkGC() : void
      {
      }
      
      public function creat(param1:String, param2:Array = null) : *
      {
         var _loc3_:* = undefined;
         if(_model.getComonentStyle(param1))
         {
            _loc3_ = creatComponentByStylename(param1);
         }
         else if(_model.getBitmapSet(param1) || ClassUtils.classIsBitmapData(param1))
         {
            _loc3_ = creatBitmap(param1);
         }
         else if(_model.getCustomObjectStyle(param1))
         {
            _loc3_ = creatCustomObject(param1);
         }
         else
         {
            _loc3_ = ClassUtils.CreatInstance(param1,param2);
         }
         return _loc3_;
      }
      
      public function creatBitmap(param1:String) : Bitmap
      {
         var _loc2_:BitmapData = null;
         var _loc3_:CustomBitmap = null;
         var _loc4_:XML = _model.getBitmapSet(param1);
         if(_loc4_ == null)
         {
            if(ClassUtils.uiSourceDomain.hasDefinition(param1))
            {
               _loc2_ = ClassUtils.CreatInstance(param1,[0,0]);
               _loc3_ = new CustomBitmap(_loc2_);
               _model.addBitmapSet(param1,new XML("<bitmapData resourceLink=\'" + param1 + "\' width=\'" + _loc3_.width + "\' height=\'" + _loc3_.height + "\' />"));
            }
         }
         else
         {
            if(_loc4_.name() == ComponentSetting.BITMAPDATA_TAG_NAME)
            {
               _loc2_ = creatBitmapData(param1);
               _loc3_ = new CustomBitmap(_loc2_,"auto",String(_loc4_.@smoothing) == "true");
            }
            else
            {
               _loc3_ = ClassUtils.CreatInstance(param1);
            }
            ObjectUtils.copyPorpertiesByXML(_loc3_,_loc4_);
         }
         return _loc3_;
      }
      
      public function creatBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:XML = _model.getBitmapSet(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         if(_loc3_.name() == ComponentSetting.BITMAPDATA_TAG_NAME)
         {
            _loc2_ = ClassUtils.CreatInstance(param1,[int(_loc3_.@width),int(_loc3_.@height)]);
         }
         else
         {
            _loc2_ = ClassUtils.CreatInstance(param1)["btimapData"];
         }
         return _loc2_;
      }
      
      public function createComponentGroupByStylename(param1:String, param2:Boolean = false, param3:Array = null) : *
      {
         var _loc5_:Component = null;
         var _loc4_:Boolean = ComponentGroupManager.Instance.hasInstanceClass(param1);
         if(_loc4_)
         {
            _loc5_ = ComponentGroupManager.Instance.getInstanceByKey(param1);
            if(preStylename == param1)
            {
               _loc5_.dispose();
               preStylename = "";
               return null;
            }
            preStylename = param1;
            return _loc5_;
         }
         _loc5_ = creatComponentByStylename(param1,param3);
         if(_loc5_.groups.length <= 0)
         {
            throw new Error("该实例没有分配组，请重载groups().");
         }
         ComponentGroupManager.Instance.addGroups(param1,_loc5_);
         preStylename = param1;
         return _loc5_;
      }
      
      public function creatComponentByStylename(param1:String, param2:Array = null) : *
      {
         var _loc5_:XML = getComponentStyle(param1);
         var _loc4_:String = _loc5_.@classname;
         var _loc3_:* = ClassUtils.CreatInstance(_loc4_,param2);
         _loc3_.id = componentID;
         _allComponents[_loc3_.id] = _loc3_;
         if(ClassUtils.classIsComponent(_loc4_))
         {
            _loc3_.beginChanges();
            ObjectUtils.copyPorpertiesByXML(_loc3_,_loc5_);
            _loc3_.commitChanges();
         }
         else
         {
            ObjectUtils.copyPorpertiesByXML(_loc3_,_loc5_);
         }
         return _loc3_;
      }
      
      private function getComponentStyle(param1:String) : XML
      {
         var _loc3_:XML = null;
         var _loc2_:XML = _model.getComonentStyle(param1);
         while(_loc2_.hasOwnProperty("@parentStyle"))
         {
            _loc3_ = _model.getComonentStyle(String(_loc2_.@parentStyle));
            delete _loc2_.@parentStyle;
            ObjectUtils.combineXML(_loc2_,_loc3_);
         }
         return _loc2_;
      }
      
      private function getCustomStyle(param1:String) : XML
      {
         var _loc3_:XML = null;
         var _loc2_:XML = _model.getCustomObjectStyle(param1);
         while(_loc2_.hasOwnProperty("@parentStyle"))
         {
            _loc3_ = _model.getCustomObjectStyle(String(_loc2_.@parentStyle));
            delete _loc2_.@parentStyle;
            ObjectUtils.combineXML(_loc2_,_loc3_);
         }
         return _loc2_;
      }
      
      public function creatCustomObject(param1:String, param2:Array = null) : *
      {
         var _loc5_:XML = getCustomStyle(param1);
         var _loc3_:String = _loc5_.@classname;
         var _loc4_:* = ClassUtils.CreatInstance(_loc3_,param2);
         ObjectUtils.copyPorpertiesByXML(_loc4_,_loc5_);
         return _loc4_;
      }
      
      public function getComponentByID(param1:int) : *
      {
         return _allComponents[param1];
      }
      
      public function removeComponent(param1:int) : void
      {
         delete _allComponents[param1];
      }
      
      public function creatFrameFilters(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = parasArgs(param1);
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_] == "null")
            {
               _loc2_.push(null);
            }
            else
            {
               _loc2_.push(creatFilters(_loc3_[_loc4_]));
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function creatFilters(param1:String) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:Array = param1.split("|");
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_.push(ComponentFactory.Instance.model.getSet(_loc4_[_loc3_]));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get model() : ComponentModel
      {
         return _model;
      }
      
      public function setup(param1:XML) : void
      {
         _model.addComponentSet(param1);
      }
      
      public function get componentID() : int
      {
         return COMPONENT_COUNTER++;
      }
      
      public function getInstanceByStyleName(param1:String) : *
      {
         return _instanceDic[param1];
      }
      
      public function addInstanceByStyleName(param1:String, param2:*) : void
      {
         _instanceDic[param1] = param2;
      }
      
      public function removeInstanceByStyleName(param1:String) : void
      {
         delete _instanceDic[param1];
      }
   }
}

class ComponentFactoryEnforcer
{
   
   public function ComponentFactoryEnforcer()
   {
      super();
   }
}
