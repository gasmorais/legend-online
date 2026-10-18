package dialog
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.StringUtils;
   import dialog.data.DialogMessageInfo;
   import dialog.view.DialogView;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MaskUtils;
   import yzhkof.debug.log;
   
   public class DialogControl extends Sprite implements Disposeable
   {
      
      private static const PAGE_SIZE:int = 100;
      
      private static const MAX_TIME_OUT:int = 120000;
      
      private var _view:DialogView;
      
      private var _model:DialogModel;
      
      private var _callBack:Function;
      
      private var _parentObj:DisplayObject;
      
      private var _showBg:Boolean;
      
      private var _timeId:int;
      
      public function DialogControl(param1:Function, param2:DisplayObject, param3:Boolean = true)
      {
         _parentObj = param2;
         _callBack = param1;
         _showBg = param3;
         super();
      }
      
      public function set model(param1:DialogModel) : void
      {
         _model = param1;
         show();
      }
      
      private function DialogTextHandle(param1:DialogModel) : void
      {
         var _loc3_:int = 0;
         var _loc4_:DialogMessageInfo = null;
         var _loc2_:int = int(param1.infos.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.infos[_loc3_];
            TxtArray(_loc4_,_loc3_);
            _loc3_++;
         }
      }
      
      private function TxtArray(param1:DialogMessageInfo, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:DialogMessageInfo = null;
         if(param1.txt.length > 100)
         {
            _loc3_ = param1.txt;
            param1.txt = param1.txt.substring(0,100);
            _loc4_ = new DialogMessageInfo();
            _loc4_.index = param1.index;
            _loc4_.event = param1.event;
            _loc4_.rawData = param1.rawData;
            _loc4_.param = param1.param;
            _loc4_.direction = param1.direction;
            _loc4_.roleId = param1.roleId;
            _loc4_.delayTime = param1.delayTime;
            _loc4_.roleName = param1.roleName;
            _loc4_.txt = _loc3_.substring(100);
            _model.infos.splice(param2 + 1,0,_loc4_);
            TxtArray(_loc4_,param2 + 1);
         }
      }
      
      private function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.clearnGameDynamic();
         _view = new DialogView(this,_parentObj,true,_showBg);
         _view.setRoles(_model.rightRoles,_model.leftRoles);
         addChild(_view);
         LayerManager.Instance.addToLayer(this,0);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_OUT_SCENE"));
         gotoAndNextMessage();
      }
      
      private function __switchSceneHandler(param1:Event) : void
      {
         if(SceneManager.instance.currentType != _model.scene)
         {
            hide();
         }
      }
      
      private function hide() : void
      {
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         if(_model && SceneManager.instance.currentType != _model.scene)
         {
            log(_model,"dialog scene : " + _model.scene + " current scene : " + SceneManager.instance.currentType);
         }
         dispose();
         if(_callBack != null)
         {
            _callBack();
            _callBack = null;
         }
      }
      
      public function gotoAndNextMessage() : void
      {
         var _loc1_:DialogMessageInfo = null;
         if(_model.hasNextInfo() && SceneManager.instance.currentType == _model.scene)
         {
            _loc1_ = _model.nextInfo();
            if(StringUtils.isEmpty(_loc1_.event))
            {
               _view.showMessage(_loc1_);
            }
            else
            {
               dispatchDialogEvent(_loc1_);
            }
         }
         else
         {
            hide();
         }
      }
      
      private function dispatchDialogEvent(param1:DialogMessageInfo) : void
      {
         var _loc2_:Object = {
            "callBack":gotoAndNextMessage,
            "data":param1
         };
         NotificationManager.instance.sendNotification(param1.event,_loc2_);
      }
      
      public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_ENTER_SCENE"));
         clearInterval(_timeId);
         if(_view)
         {
            _view.dispose();
         }
         _view = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         MaskUtils.instance.dispose();
         dispatchEvent(new Event("dispose"));
      }
   }
}

