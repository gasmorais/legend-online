package yishi.utils
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class SimpleAlertHelper extends EventDispatcher
   {
      
      public static const SIMPLE_ALERT:String = "SIMPLE_ALERT";
      
      public static const FUNCTION_ALERT:String = "FUNCTION_ALERT";
      
      public static const USEBINDPOINT_ALERT:String = "USEBINDPOINT_ALERT";
      
      public static const CHATINVIE_ALERT:String = "CHATINVIE_ALERT";
      
      public static const USEBINDPOINT_WITHCHOICE_AUTOLAYOUT_ALERT:String = "USEBINDPOINT_WITHCHOICE_AUTOLAYOUT_ALERT";
      
      private static var _instance:SimpleAlertHelper;
      
      private var _data:Array;
      
      public function SimpleAlertHelper()
      {
         super();
      }
      
      public static function get instance() : SimpleAlertHelper
      {
         if(_instance == null)
         {
            _instance = new SimpleAlertHelper();
         }
         return _instance;
      }
      
      public function set data(param1:Array) : void
      {
         _data = param1;
      }
      
      public function addBackCallData(param1:Object) : void
      {
         if(_data.length - 1 < 5)
         {
            _data.push(param1);
         }
      }
      
      private function createAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:int = 0, param10:String = "", param11:Function = null, param12:String = "SimpleAlert") : Component
      {
         var _loc13_:BaseAlerFrame = AlertManager.Instance.simpleAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12);
         if(param9 != 0)
         {
            _loc13_.height = param9;
         }
         _loc13_.addEventListener("response",__responseHandler);
         _loc13_.addEventListener("dispose",__disposeComponentHandler);
         KeyBoardRegister.instance.keyEnable = false;
         return _loc13_;
      }
      
      private function createFunctionAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = "", param10:Function = null) : Component
      {
         var _loc11_:BaseAlerFrame = AlertManager.Instance.functionAlert(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         _loc11_.addEventListener("response",__responseHandler);
         _loc11_.addEventListener("dispose",__disposeComponentHandler);
         KeyBoardRegister.instance.keyEnable = false;
         return _loc11_;
      }
      
      private function createUseBindPointAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:Number = 0, param10:String = "", param11:Function = null, param12:Object = null, param13:Number = 350) : Component
      {
         var _loc14_:BaseAlerFrame = AlertManager.Instance.useBindPointAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12,param13);
         if(param9 != 0)
         {
            _loc14_.height = param9;
         }
         _loc14_.addEventListener("response",__responseHandler);
         _loc14_.addEventListener("dispose",__disposeComponentHandler);
         KeyBoardRegister.instance.keyEnable = false;
         return _loc14_;
      }
      
      private function createChatInvieAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:Number = 0, param10:String = "", param11:Function = null, param12:Object = null, param13:Number = 350, param14:Boolean = false) : Component
      {
         var _loc15_:BaseAlerFrame = AlertManager.Instance.chatInvieAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12,param13);
         if(param9 != 0)
         {
            _loc15_.height = param9;
         }
         _loc15_.addEventListener("response",__responseHandler);
         _loc15_.addEventListener("dispose",__disposeComponentHandler);
         KeyBoardRegister.instance.keyEnable = false;
         return _loc15_;
      }
      
      private function createUseBindPointWithChoiceAutoLayoutAlert(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:Number = 0, param10:String = "", param11:Function = null, param12:Object = null, param13:Number = 350, param14:String = "", param15:String = "") : Component
      {
         var _loc16_:BaseAlerFrame = AlertManager.Instance.useBindPointWithChoiceAutoLayoutAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12,param13,param14,param15);
         if(param9 != 0)
         {
            _loc16_.height = param9;
         }
         _loc16_.addEventListener("response",__responseHandler);
         _loc16_.addEventListener("dispose",__disposeComponentHandler);
         KeyBoardRegister.instance.keyEnable = false;
         return _loc16_;
      }
      
      private function __disposeComponentHandler(param1:Event) : void
      {
         this.dispatchEvent(new Event("dispose"));
      }
      
      private function dispose(param1:BaseAlerFrame) : void
      {
         if(param1)
         {
            param1.removeEventListener("response",__responseHandler);
            param1.removeEventListener("dispose",__disposeComponentHandler);
            param1.dispose();
         }
         param1 = null;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         dispose(param1.currentTarget as BaseAlerFrame);
         switch(param1.responseCode - 2)
         {
            case 0:
            case 1:
               successBack(param1.obj);
               break;
            default:
               failBack(param1.obj);
         }
      }
      
      private function successBack(param1:Boolean = false) : void
      {
         if(!_data || _data.length < 1)
         {
            return;
         }
         var _loc2_:Function = _data[0] as Function;
         backCall(_loc2_,true,param1);
         _loc2_ = null;
      }
      
      private function backCall(param1:Function, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("yishi.utils.SimpleAlertHelper.HasFiveParams");
         if(param1 == null)
         {
            return;
         }
         switch(_data.length - 1)
         {
            case 0:
               param1(param2,param3);
               break;
            case 1:
               param1(param2,param3,_data[1]);
               break;
            case 2:
               param1(param2,param3,_data[1],_data[2]);
               break;
            case 3:
               param1(param2,param3,_data[1],_data[2],_data[3]);
               break;
            case 4:
               param1(param2,param3,_data[1],_data[2],_data[3],_data[4]);
               break;
            case 5:
               param1(param2,param3,_data[1],_data[2],_data[3],_data[4],_data[5]);
               break;
            default:
               throw new Error(_loc4_);
         }
         if(param1 == null)
         {
            _data = null;
         }
      }
      
      private function failBack(param1:Boolean = false) : void
      {
         if(!_data || _data.length < 1)
         {
            return;
         }
         var _loc2_:Function = _data[0] as Function;
         backCall(_loc2_,false,false);
         _loc2_ = null;
      }
      
      public function popAlerFrame(param1:String, param2:String, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:int = 2, param9:String = "SIMPLE_ALERT", param10:int = 0, param11:String = "", param12:Function = null, param13:String = "SimpleAlert", param14:Object = null, param15:Number = 350, param16:String = "", param17:String = "") : Component
      {
         switch(param9)
         {
            case "SIMPLE_ALERT":
               return createAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12,param13);
            case "FUNCTION_ALERT":
               return createFunctionAlert(param1,param2,param3,param4,param5,param6,param7,param8,param11,param12);
            case "USEBINDPOINT_ALERT":
               return createUseBindPointAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12,param14,param15);
            case "CHATINVIE_ALERT":
               return createChatInvieAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12,param14,param15);
            case "USEBINDPOINT_WITHCHOICE_AUTOLAYOUT_ALERT":
               return createUseBindPointWithChoiceAutoLayoutAlert(param1,param2,param3,param4,param5,param6,param7,param8,param10,param11,param12,param14,param15,param16,param17);
            default:
               return null;
         }
      }
   }
}

