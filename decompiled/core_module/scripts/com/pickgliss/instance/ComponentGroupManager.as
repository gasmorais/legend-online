package com.pickgliss.instance
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.core.Component;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class ComponentGroupManager
   {
      
      private static var _instance:ComponentGroupManager;
      
      private var _allGroups:Dictionary;
      
      private var _allInstance:Dictionary;
      
      public function ComponentGroupManager()
      {
         super();
         _allGroups = new Dictionary(true);
         _allInstance = new Dictionary(true);
      }
      
      public static function get Instance() : ComponentGroupManager
      {
         if(_instance == null)
         {
            _instance = new ComponentGroupManager();
         }
         return _instance;
      }
      
      private function addGroupsImp(param1:Array, param2:String, param3:Component) : void
      {
         var _loc6_:Dictionary = null;
         for each(var _loc5_:String in param1)
         {
            _loc6_ = _allGroups[_loc5_];
            if(_loc6_)
            {
               for each(var _loc4_:Component in _loc6_)
               {
                  _loc4_.dispatchEvent(new ComponentEvent("GROUP_CONFLICT"));
                  _loc4_.dispose();
               }
            }
            else
            {
               _loc6_ = new Dictionary(true);
            }
            _loc6_[param2] = param3;
            _allGroups[_loc5_] = _loc6_;
            if(!param3.isAddToPool)
            {
               param3.addEventListener("dispose",__disposeHandler);
            }
         }
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         (param1.currentTarget as Component).removeEventListener("dispose",__disposeHandler);
         removeGroups(param1.currentTarget as Component);
      }
      
      private function removeGroups(param1:Component) : void
      {
         deleteComponentByDict(param1,_allInstance);
         for each(var _loc2_:Dictionary in _allGroups)
         {
            deleteComponentByDict(param1,_loc2_);
         }
      }
      
      private function deleteComponentByDict(param1:Component, param2:Dictionary) : void
      {
         for(var _loc3_:String in param2)
         {
            if(param2[_loc3_] == param1)
            {
               delete param2[_loc3_];
               break;
            }
         }
      }
      
      private function addInstance(param1:String, param2:Object) : void
      {
         _allInstance[param1] = param2;
      }
      
      public function addGroups(param1:String, param2:Component) : void
      {
         addGroupsImp(param2.groups,param1,param2);
         addInstance(param1,param2);
      }
      
      public function hasInstanceClass(param1:String) : Boolean
      {
         return _allInstance[param1] != null ? true : false;
      }
      
      public function getInstanceByKey(param1:String) : Component
      {
         return _allInstance[param1];
      }
      
      public function disposePool() : void
      {
         var _loc2_:String = null;
         var _loc1_:Component = null;
         var _loc4_:Dictionary = null;
         for(var _loc3_:String in _allGroups)
         {
            _loc4_ = _allGroups[_loc3_];
            for(_loc2_ in _loc4_)
            {
               _loc1_ = _loc4_[_loc2_] as Component;
               if(_loc1_.parent == null)
               {
                  delete _loc4_[_loc2_];
               }
            }
         }
         for(_loc2_ in _allInstance)
         {
            _loc1_ = _allInstance[_loc2_] as Component;
            if(_loc1_)
            {
               if(_loc1_.parent == null)
               {
                  _loc1_.isAddToPool = false;
                  _loc1_.dispose();
                  delete _allInstance[_loc2_];
               }
            }
         }
      }
      
      public function disposeAllOpenFrame() : void
      {
         var _loc2_:String = null;
         var _loc1_:Component = null;
         var _loc4_:Dictionary = null;
         for(var _loc3_:String in _allGroups)
         {
            _loc4_ = _allGroups[_loc3_];
            for(_loc2_ in _loc4_)
            {
               _loc1_ = _loc4_[_loc2_] as Component;
               if(_loc1_.parent)
               {
                  delete _loc4_[_loc2_];
               }
            }
         }
         for(_loc2_ in _allInstance)
         {
            _loc1_ = _allInstance[_loc2_] as Component;
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  _loc1_.isAddToPool = false;
                  _loc1_.dispose();
                  delete _allInstance[_loc2_];
               }
            }
         }
      }
   }
}

