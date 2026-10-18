package oldbacker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.OldBackerEvents;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.OldBackerManager;
   import mvc.module.oldbacker.OldBackerModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class OldBackerMsgView extends Component
   {
      
      private var _backMc:MutipleImage;
      
      private var _msgTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _iconBtn01:IconButton;
      
      private var _iconBtn02:IconButton;
      
      private var _iconBtn03:IconButton;
      
      private var _iconBtn04:IconButton;
      
      private var _iconBtn05:IconButton;
      
      private var _iconBtn06:IconButton;
      
      private var _iconBtn07:IconButton;
      
      private var _returnBtn:IconButton;
      
      private var _inputView:OldBackerInputView;
      
      private var _viewType:int = 1;
      
      public function OldBackerMsgView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _backMc = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBack01");
         _msgTxt = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewMsgText01");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewMsgText02");
         _iconBtn01 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn01");
         _iconBtn02 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn02");
         _iconBtn03 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn03");
         _iconBtn04 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn04");
         _iconBtn05 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn07");
         _iconBtn06 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn08");
         _iconBtn07 = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn09");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewReturnBtn");
         _inputView = ComponentFactory.Instance.creatCustomObject("oldbacker.OldBackerInputView1");
         addChild(_backMc);
         addChild(_msgTxt);
         addChild(_timeTxt);
         addChild(_iconBtn01);
         addChild(_iconBtn02);
         addChild(_iconBtn03);
         addChild(_iconBtn04);
         addChild(_iconBtn05);
         addChild(_iconBtn06);
         addChild(_iconBtn07);
         addChild(_returnBtn);
         addChild(_inputView);
         _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText01","jackChen");
         _timeTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText02","30:23:59");
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = model.stopTime.substr(0,10);
         _timeTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText02",_loc1_);
         if(model.backerType == 1)
         {
            if(_viewType == 3 || _viewType == 4)
            {
               _inputView.singKey = model.singKey;
               if(model.singKey == "" || model.singKey == null)
               {
                  _viewType = 3;
               }
               else
               {
                  _viewType = 4;
               }
            }
            viewType = _viewType;
         }
         else if(model.isUseKey)
         {
            viewType = 7;
         }
         else
         {
            viewType = 5;
         }
      }
      
      private function addEvent() : void
      {
         _iconBtn01.addEventListener("click",__onClickHander);
         _iconBtn02.addEventListener("click",__onClickHander);
         _iconBtn03.addEventListener("click",__onClickHander);
         _iconBtn04.addEventListener("click",__onClickHander);
         _iconBtn05.addEventListener("click",__onClickHander);
         _iconBtn06.addEventListener("click",__onClickHander);
         _iconBtn07.addEventListener("click",__onClickHander);
         _returnBtn.addEventListener("click",__onClickHander);
         model.addEventListener("REFRESH_VIEW_INFO",__updataInfos);
      }
      
      private function __updataInfos(param1:OldBackerEvents) : void
      {
         refreshView();
      }
      
      private function __onClickHander(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _iconBtn01:
               viewType = 2;
               if(model.viewInfoList.length <= 0)
               {
                  OldBackerManager.instance.sendInfo(1,0,"",1);
               }
               break;
            case _iconBtn02:
               if(model.singKey == null || model.singKey == "")
               {
                  viewType = 3;
               }
               else
               {
                  viewType = 4;
               }
               break;
            case _iconBtn03:
               OldBackerManager.instance.sendInfo(4);
               break;
            case _iconBtn04:
            case _iconBtn07:
               showPromptAlert(1,LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText08"),LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText09"));
               break;
            case _iconBtn05:
               viewType = 6;
               break;
            case _iconBtn06:
               showPromptAlert(2,LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText06"),LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText07"));
               break;
            case _returnBtn:
               if(model.backerType == 1)
               {
                  if(model.viewInfoList.length > 0)
                  {
                     viewType = 2;
                  }
                  else
                  {
                     viewType = 1;
                  }
               }
               else if(model.isUseKey)
               {
                  viewType = 7;
               }
               else
               {
                  viewType = 5;
               }
         }
      }
      
      private function showPromptAlert(param1:int, param2:String, param3:String) : void
      {
         SimpleAlertHelper.instance.data = [showAlertBack,param1];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.popAlerFrame(param2,param3,_loc4_,_loc5_,true,true,true,2,"SIMPLE_ALERT");
      }
      
      private function showAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(param3 == 0)
            {
               OldBackerManager.instance.sendInfo(1,0,"",1);
            }
            else if(param3 == 1)
            {
               OldBackerManager.instance.sendInfo(1,0,"",2);
            }
            else if(param3 == 2)
            {
               OldBackerManager.instance.sendInfo(2,0,_inputView.singKey);
            }
         }
      }
      
      private function removeEvent() : void
      {
         _iconBtn01.removeEventListener("click",__onClickHander);
         _iconBtn02.removeEventListener("click",__onClickHander);
         _iconBtn03.removeEventListener("click",__onClickHander);
         _iconBtn04.removeEventListener("click",__onClickHander);
         _iconBtn05.removeEventListener("click",__onClickHander);
         _iconBtn06.removeEventListener("click",__onClickHander);
         _iconBtn07.removeEventListener("click",__onClickHander);
         _returnBtn.removeEventListener("click",__onClickHander);
         model.removeEventListener("REFRESH_VIEW_INFO",__updataInfos);
      }
      
      public function set viewType(param1:int) : void
      {
         _viewType = param1;
         _iconBtn01.visible = _iconBtn02.visible = _iconBtn03.visible = _iconBtn04.visible = false;
         _iconBtn05.visible = _iconBtn06.visible = _inputView.visible = _iconBtn07.visible = false;
         _returnBtn.visible = true;
         _inputView.isTextInput = false;
         switch(_viewType - 1)
         {
            case 0:
               _returnBtn.visible = false;
               _iconBtn01.visible = true;
               if(model.isOpenNewSvr)
               {
                  _iconBtn01.x = 290;
                  _iconBtn02.visible = true;
                  if(VersionSwitch.OLD_BACK_DIAMOND)
                  {
                     _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText01",playerInfo.nickName);
                  }
                  else
                  {
                     _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText13",playerInfo.nickName);
                  }
               }
               else
               {
                  _iconBtn01.x = 383;
                  _iconBtn02.visible = false;
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText11",playerInfo.nickName);
               }
               break;
            case 1:
               _returnBtn.visible = false;
               if(model.isOpenNewSvr)
               {
                  _iconBtn03.x = 290;
                  _iconBtn02.visible = true;
               }
               else
               {
                  _iconBtn03.x = 383;
                  _iconBtn02.visible = false;
               }
               _iconBtn03.visible = true;
               _iconBtn03.enable = !model.isTakeBuffer;
               _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText03");
               break;
            case 2:
               _iconBtn04.visible = _inputView.visible = true;
               if(VersionSwitch.OLD_BACK_DIAMOND)
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText04",model.needGrades);
               }
               else
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText14",model.needGrades);
               }
               _inputView.singKey = model.singKey;
               _iconBtn04.enable = true;
               break;
            case 3:
               _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackFrame.viewText05",model.needGrades);
               _iconBtn07.visible = _inputView.visible = true;
               _inputView.singKey = model.singKey;
               _iconBtn04.visible = false;
               _iconBtn04.enable = false;
               break;
            case 4:
               _returnBtn.visible = false;
               if(VersionSwitch.OLD_BACK_DIAMOND)
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackNewFrame.viewText01",model.needGrades);
               }
               else
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackNewFrame.viewText04",model.needGrades);
               }
               _iconBtn05.visible = true;
               _iconBtn05.enable = true;
               break;
            case 5:
               if(VersionSwitch.OLD_BACK_DIAMOND)
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackNewFrame.viewText02");
               }
               else
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackNewFrame.viewText05");
               }
               _iconBtn06.visible = _inputView.visible = true;
               _inputView.isTextInput = true;
               break;
            case 6:
               _returnBtn.visible = false;
               if(VersionSwitch.OLD_BACK_DIAMOND)
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackNewFrame.viewText03",model.chargeTotalCount);
               }
               else
               {
                  _msgTxt.htmlText = LanguageMgr.GetTranslation("oldback.OldBackNewFrame.viewText06",model.chargeTotalCount);
               }
               _iconBtn05.enable = false;
               _iconBtn05.visible = true;
         }
      }
      
      private function get model() : OldBackerModel
      {
         return OldBackerManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return playerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backMc);
         _backMc = null;
         ObjectUtils.disposeObject(_msgTxt);
         _msgTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_iconBtn01);
         _iconBtn01 = null;
         ObjectUtils.disposeObject(_iconBtn02);
         _iconBtn02 = null;
         ObjectUtils.disposeObject(_iconBtn03);
         _iconBtn03 = null;
         ObjectUtils.disposeObject(_iconBtn04);
         _iconBtn04 = null;
         ObjectUtils.disposeObject(_iconBtn05);
         _iconBtn05 = null;
         ObjectUtils.disposeObject(_iconBtn06);
         _iconBtn06 = null;
         ObjectUtils.disposeObject(_iconBtn07);
         _iconBtn07 = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_inputView);
         _inputView = null;
         super.dispose();
      }
   }
}

