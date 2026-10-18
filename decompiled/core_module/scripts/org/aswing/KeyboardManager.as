package org.aswing
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import org.aswing.util.*;
   
   [Event(name="keyDown",type="flash.events.KeyboardEvent")]
   [Event(name="keyUp",type="flash.events.KeyboardEvent")]
   public class KeyboardManager extends EventDispatcher
   {
      
      private static var instance:KeyboardManager;
      
      private var keymaps:VectorII;
      
      private var keySequence:VectorII;
      
      private var selfKeyMap:KeyMap;
      
      private var inited:Boolean;
      
      private var keyJustActed:Boolean;
      
      private var mnemonicModifier:Array;
      
      public function KeyboardManager()
      {
         super();
         inited = false;
         keyJustActed = false;
         keymaps = new VectorII();
         keySequence = new VectorII();
         selfKeyMap = new KeyMap();
         mnemonicModifier = [17,16];
         registerKeyMap(selfKeyMap);
      }
      
      public static function getInstance() : KeyboardManager
      {
         if(instance == null)
         {
            instance = new KeyboardManager();
         }
         return instance;
      }
      
      public static function isDown(param1:uint) : Boolean
      {
         return getInstance().isKeyDown(param1);
      }
      
      public function init(param1:Stage) : void
      {
         if(!inited)
         {
            inited = true;
            param1.addEventListener("keyDown",__onKeyDown,false,0,true);
            param1.addEventListener("keyUp",__onKeyUp,false,0,true);
            param1.addEventListener("deactivate",__deactived,false,0,true);
         }
      }
      
      public function registerKeyMap(param1:KeyMap) : void
      {
         if(!keymaps.contains(param1))
         {
            keymaps.append(param1);
         }
      }
      
      public function unregisterKeyMap(param1:KeyMap) : void
      {
         keymaps.remove(param1);
      }
      
      public function registerKeyAction(param1:KeyType, param2:Function) : void
      {
         selfKeyMap.registerKeyAction(param1,param2);
      }
      
      public function unregisterKeyAction(param1:KeyType, param2:Function) : void
      {
         selfKeyMap.unregisterKeyAction(param1,param2);
      }
      
      public function isKeyDown(param1:uint) : Boolean
      {
         return keySequence.contains(param1);
      }
      
      public function setMnemonicModifier(param1:Array) : void
      {
         mnemonicModifier = param1.concat();
      }
      
      public function isMnemonicModifierDown() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < mnemonicModifier.length)
         {
            if(!isKeyDown(mnemonicModifier[_loc1_]))
            {
               return false;
            }
            _loc1_++;
         }
         return mnemonicModifier.length > 0;
      }
      
      public function isKeyJustActed() : Boolean
      {
         return keyJustActed;
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:KeyMap = null;
         dispatchEvent(param1);
         var _loc2_:uint = param1.keyCode;
         if(!keySequence.contains(_loc2_) && _loc2_ < 139)
         {
            keySequence.append(_loc2_);
         }
         keyJustActed = false;
         var _loc5_:int = keymaps.size();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = KeyMap(keymaps.get(_loc4_));
            if(_loc3_.fireKeyAction(keySequence.toArray()))
            {
               keyJustActed = true;
            }
            _loc4_++;
         }
      }
      
      private function __onKeyUp(param1:KeyboardEvent) : void
      {
         dispatchEvent(param1);
         var _loc2_:uint = param1.keyCode;
         keySequence.remove(_loc2_);
         if(!param1.ctrlKey)
         {
            keySequence.remove(17);
         }
         if(!param1.shiftKey)
         {
            keySequence.remove(16);
         }
      }
      
      private function __deactived(param1:Event) : void
      {
         keySequence.clear();
      }
      
      public function reset() : void
      {
         keySequence.clear();
      }
   }
}

