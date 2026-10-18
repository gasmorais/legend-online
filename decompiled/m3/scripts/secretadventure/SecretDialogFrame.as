package secretadventure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretEventInfo;
   import secretadventure.item.SecretHexagon;
   import yishi.datas.templates.SecretEventTemplate;
   import yishi.manager.PathManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   
   public class SecretDialogFrame extends Frame
   {
      
      private var _desTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _confirmBtn:IconButton;
      
      private var _helpBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _eInfo:SecretEventInfo;
      
      private var _eTemp:SecretEventTemplate;
      
      private var _timeOutId:int;
      
      private var _roleMc:MovieClip;
      
      public function SecretDialogFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secret.dialogDesTxt");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("ui.secret.dialogHbox");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secret.dialogConfrimBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secret.dialogHelpBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secret.dialogCancelBtn");
         addToContent(_desTxt);
         addToContent(_hbox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _cancelBtn.addEventListener("click",cancelHandler);
         _helpBtn.addEventListener("click",helpHandler);
         _confirmBtn.addEventListener("click",confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _cancelBtn.removeEventListener("click",cancelHandler);
         _helpBtn.removeEventListener("click",helpHandler);
         _confirmBtn.removeEventListener("click",confirmHandler);
      }
      
      private function cancelHandler(param1:MouseEvent) : void
      {
         requestServer();
         dispose();
      }
      
      private function helpHandler(param1:MouseEvent) : void
      {
         _cancelBtn.visible = false;
         _helpBtn.visible = false;
         if(_eInfo.params == "1")
         {
            _desTxt.text = LanguageMgr.GetTranslation("secret.solder.dialog1");
         }
         else
         {
            _desTxt.text = LanguageMgr.GetTranslation("secret.solder.dialog2");
         }
         clearTimeout(_timeOutId);
         _timeOutId = setTimeout(doResult,1500);
      }
      
      private function doResult() : void
      {
         requestServer(1);
         dispose();
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      private function requestServer(param1:int = 0) : void
      {
         var _loc2_:SecretHexagon = null;
         if(model.isTest)
         {
            if(_eInfo)
            {
               _eInfo.state = 1;
               _loc2_ = model.getNode(_eInfo.mapDataId,_eInfo.nodeId) as SecretHexagon;
               if(_loc2_)
               {
                  _loc2_.eventInfo = _eInfo;
               }
            }
         }
         else if(_eInfo)
         {
            SecretAdventerManager.Instance.opEvent(_eInfo.mapDataId,_eInfo.nodeId,param1);
         }
      }
      
      private function confirmHandler(param1:MouseEvent) : void
      {
         requestServer();
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadCompleteHandler);
         clearTimeout(_timeOutId);
         removeEvent();
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeViolentMc(_roleMc);
         _roleMc = null;
         super.dispose();
         _eTemp = null;
         _eInfo = null;
      }
      
      public function show(param1:SecretEventInfo) : void
      {
         _eInfo = param1;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function refreshView() : void
      {
         if(_eInfo)
         {
            _hbox.removeAllChild();
            _eTemp = TempleteManager.instance.secretEventCate.getEventTempInfo(_eInfo.eventId);
            if(_eTemp.FunType == 2)
            {
               _desTxt.text = LanguageMgr.GetTranslation("secret.solder.dialog0");
               _hbox.beginChanges();
               _hbox.addChild(_helpBtn);
               _hbox.addChild(_cancelBtn);
               _hbox.commitChanges();
               doLoadRes("halfman.swf");
            }
            else if(_eTemp.FunType == 11)
            {
               _desTxt.text = LanguageMgr.GetTranslation("secret.castle.dialog");
               _hbox.beginChanges();
               _hbox.addChild(_confirmBtn);
               _hbox.commitChanges();
               doLoadRes("halfwoman.swf");
            }
         }
      }
      
      private function doLoadRes(param1:String) : void
      {
         var _loc2_:String = PathManager.getSecretSource(0,param1);
         LoaderManagerII.instance.load(_loc2_,2,0,onLoadCompleteHandler);
      }
      
      private function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(param2 is MovieClip)
         {
            _roleMc = param2 as MovieClip;
            addToContent(_roleMc);
            _roleMc.x = -285;
            _roleMc.y = -195;
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}

