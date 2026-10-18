package emailII.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.EmailEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.controler.EmailControler;
   import mvc.module.emailII.EmailInfo;
   import mvc.module.emailII.EmailModel;
   import mvc.module.star.StarInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.EmailHelp;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ReadEmailView extends Sprite implements Disposeable
   {
      
      private static const UNDERLEVEL:int = 6;
      
      private var _background:MutipleImage;
      
      private var _sysBackgroud:MutipleImage;
      
      private var _line:BitmapData;
      
      private var _gmIcon:Image;
      
      private var _personValue:FilterFrameText;
      
      private var _titleValue:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _alertText:ScaleFrameImage;
      
      private var _sendBtn:SelectedCheckButton;
      
      private var _closeBtn:SelectedCheckButton;
      
      private var _data:EmailInfo;
      
      private var _goodHBox:HBox;
      
      private var _goodDic:Dictionary;
      
      private var _control:EmailControler;
      
      private var _model:EmailModel;
      
      private var _emailPanel:ScrollPanel;
      
      private var _emailVBox:VBox;
      
      public function ReadEmailView(param1:EmailControler, param2:EmailModel)
      {
         super();
         _control = param1;
         _model = param2;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         _background = ComponentFactory.Instance.creatComponentByStylename("email.ReadPrivateEmailBack");
         _sysBackgroud = ComponentFactory.Instance.creatComponentByStylename("email.ReadSystemEmailBack");
         _gmIcon = ComponentFactory.Instance.creatComponentByStylename("email.GmIcon");
         _personValue = ComponentFactory.Instance.creatComponentByStylename("email.SenderValueText");
         _titleValue = ComponentFactory.Instance.creatComponentByStylename("email.TitleValueText");
         _content = ComponentFactory.Instance.creatComponentByStylename("email.ContentText");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("email.AlertText");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("email.ReplyBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("email.CloseBtn");
         _line = ComponentFactory.Instance.creatBitmapData("asset.core.WriteEmailLine");
         _emailPanel = ComponentFactory.Instance.creatComponentByStylename("email.ReadEmailScrollPanel");
         _emailVBox = ComponentFactory.Instance.creatComponentByStylename("email.ReadEmailListVbox");
         _sendBtn.text = LanguageMgr.GetTranslation("emailII.view.ReadEmailView.send");
         _closeBtn.text = LanguageMgr.GetTranslation("emailII.view.ReadEmailView.close");
         addChild(_background);
         addChild(_sysBackgroud);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new Bitmap(_line);
            _loc1_.x = 5;
            _loc1_.y = _loc2_ * 24 + 79;
            addChild(_loc1_);
            _loc2_++;
         }
         addChild(_personValue);
         _personValue.setFrame(1);
         addChild(_titleValue);
         addChild(_content);
         addChild(_alertText);
         addChild(_sendBtn);
         addChild(_closeBtn);
         addChild(_emailPanel);
         _emailPanel.setView(_emailVBox);
         _goodHBox = ComponentFactory.Instance.creatComponentByStylename("email.GoodsHBox");
         addChild(_goodHBox);
         initGoods();
         refreshData();
         _content.mouseEnabled = true;
      }
      
      private function initBack() : void
      {
         if(_data)
         {
            if(_data.SendId > 0)
            {
               _background.visible = true;
               _sysBackgroud.visible = false;
               _personValue.setFrame(1);
            }
            else
            {
               _background.visible = false;
               _sysBackgroud.visible = true;
               _personValue.setFrame(2);
            }
         }
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_line);
         ObjectUtils.disposeObject(_background);
         ObjectUtils.disposeObject(_sysBackgroud);
         ObjectUtils.disposeObject(_gmIcon);
         ObjectUtils.disposeObject(_personValue);
         ObjectUtils.disposeObject(_titleValue);
         ObjectUtils.disposeObject(_content);
         ObjectUtils.disposeObject(_alertText);
         ObjectUtils.disposeObject(_sendBtn);
         ObjectUtils.disposeObject(_closeBtn);
         if(_goodHBox)
         {
            _goodHBox.disposeAllChildren();
         }
         ObjectUtils.disposeObject(_goodHBox);
         ObjectUtils.disposeObject(_emailPanel);
         ObjectUtils.disposeObject(_emailVBox);
         _emailVBox = null;
         _emailPanel = null;
         _goodHBox = null;
         _closeBtn = null;
         _sendBtn = null;
         _alertText = null;
         _content = null;
         _titleValue = null;
         _personValue = null;
         _gmIcon = null;
         _data = null;
         _line = null;
         _background = null;
         _goodDic = null;
         _control = null;
         _model = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initGoods() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc3_:BaseIconView = null;
         _goodDic = new Dictionary();
         _loc2_ = 1;
         while(_loc2_ <= 10)
         {
            if(_loc2_ <= 5)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("email.GoodsItem");
               _goodHBox.addChild(_loc1_);
               _goodDic[_loc2_] = _loc1_;
            }
            else
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("email.StarItemIcon");
               _goodHBox.addChild(_loc3_);
               _goodDic[_loc2_] = _loc3_;
            }
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _sendBtn.addEventListener("click",__sendHandler);
         _closeBtn.addEventListener("click",__closeHandler);
         _model.addEventListener("DATA_EMAIL_DELETE",__deleteHandler);
         _model.addEventListener("DATA_EMAIL_UPDATE",__updateHandler);
         NotificationManager.instance.addEventListener("ANNEX_CALLBACK",__onAnnexCallback);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         NotificationManager.instance.removeEventListener("ANNEX_CALLBACK",__onAnnexCallback);
         _sendBtn.removeEventListener("click",__sendHandler);
         _closeBtn.removeEventListener("click",__closeHandler);
         _model.removeEventListener("DATA_EMAIL_DELETE",__deleteHandler);
         _model.removeEventListener("DATA_EMAIL_UPDATE",__updateHandler);
         _loc1_ = 1;
         while(_loc1_ <= 10)
         {
            if(_goodDic[_loc1_])
            {
               _goodDic[_loc1_].removeEventListener("click",__itemClickHandler);
            }
            _loc1_++;
         }
      }
      
      private function __updateHandler(param1:EmailEvent) : void
      {
         var _loc3_:Array = param1.list;
         for each(var _loc2_:int in _loc3_)
         {
            if(_data.Id == _loc2_)
            {
               refreshData();
               break;
            }
         }
      }
      
      private function __deleteHandler(param1:EmailEvent) : void
      {
         if(_data && param1.list.indexOf(_data.Id) >= 0)
         {
            _control.closeReadFrame();
         }
      }
      
      public function refreshData() : void
      {
         _data = _model.currentReadEmail;
         initBack();
         refreshView();
      }
      
      private function __sendHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(_data.MailType == 2 || _data.SendId == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.ReadEmailView.content01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("emailII.EmailFrame.view.underSixLevel",6);
            SimpleAlertHelper.instance.data = [];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc3_,"",true,false,false);
            return;
         }
         _model.reply = _data.SendNickName;
         FrameControllerManager.instance.openControllerByInfo("writeemail","email.WriteEmailFrame",_data.SendNickName);
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("008");
         if(_data.hasGoods)
         {
            _control.getAttached(_data.Id,0);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.ReadEmailView.content02");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:BaseIconView = null;
         if(param1.currentTarget is BaseItemView)
         {
            _loc2_ = param1.currentTarget as BaseItemView;
            if(_loc2_.data && _loc2_.data.templateId < 0 || _loc2_.data && EmailHelp.checkCanGetGoods())
            {
               _control.getAttached(_data.Id,_loc2_.pos);
            }
         }
         else
         {
            _loc3_ = param1.currentTarget as BaseIconView;
            if(_loc3_.icon && EmailHelp.checkCanGetStart())
            {
               _control.getAttached(_data.Id,_loc3_.pos);
            }
         }
      }
      
      private function refreshView() : void
      {
         _emailVBox.beginChanges();
         cleanGood();
         _alertText.visible = PlayerManager.instance.currentPlayerModel.playerInfo.nickName == _data.SendNickName ? false : true;
         if(_data.SendType == 2)
         {
            addChild(_gmIcon);
            _personValue.x = 105;
            _alertText.visible = false;
         }
         else
         {
            if(_gmIcon.parent)
            {
               _gmIcon.parent.removeChild(_gmIcon);
            }
            _personValue.x = 95;
         }
         if(_data.SendPlayerGrade > 0)
         {
            _personValue.htmlText = _data.SendNickName + "  <font color=\'#00f6ff\'>" + LanguageMgr.GetTranslation("public.level2",_data.SendPlayerGrade) + "</font>";
         }
         else
         {
            _personValue.htmlText = _data.SendNickName;
         }
         _titleValue.text = _data.Title;
         _content.text = _data.Contents;
         _content.height = Math.max(_content.textHeight + 5,_emailPanel.displayObjectViewport.height);
         _emailVBox.addChild(_content);
         _emailVBox.commitChanges();
         _emailPanel.invalidateViewport();
         if(_data.MailType == 2 || _data.MailType == 4 || _data.MailType == 5)
         {
            _alertText.setFrame(1);
         }
         else
         {
            _alertText.setFrame(2);
         }
         if(_data.hasGoods)
         {
            refreshAnnex();
         }
      }
      
      private function cleanGood() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 10)
         {
            if(_goodDic[_loc1_] is BaseItemView)
            {
               (_goodDic[_loc1_] as BaseItemView).data = null;
            }
            else
            {
               (_goodDic[_loc1_] as BaseIconView).tipData = null;
               (_goodDic[_loc1_] as BaseIconView).icon = null;
            }
            _loc1_++;
         }
      }
      
      private function __onAnnexCallback(param1:EmailEvent) : void
      {
         if(_data.hasGoods)
         {
            refreshAnnex();
         }
      }
      
      private function refreshAnnex() : void
      {
         var _loc5_:int = 0;
         var _loc2_:BaseIconView = null;
         var _loc4_:StarInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc3_:int = 1;
         _loc5_ = 1;
         while(_loc5_ <= 5)
         {
            if(!_data["IsAnnex" + _loc5_] && _data["Annex" + _loc5_] != 0)
            {
               if(_model.currentReadEmail.MailType == 4)
               {
                  _loc2_ = _goodDic[_loc3_ + 5] as BaseIconView;
                  _loc4_ = _data.getAnnexStarByIndex(_loc5_);
                  _loc2_.icon = IconFactory.getCommonIconPath(_loc4_.template.Icon);
                  _loc2_.tipData = _loc4_;
                  _loc2_.pos = _loc5_;
                  _loc2_.x = (_loc3_ - 1) * 58 + 25;
                  _loc2_.addEventListener("click",__itemClickHandler);
               }
               else
               {
                  _loc1_ = _goodDic[_loc3_] as BaseItemView;
                  _loc1_.data = _data.getAnnexByIndex(_loc5_);
                  _loc1_.pos = _loc5_;
                  _loc1_.addEventListener("click",__itemClickHandler);
               }
               _loc3_++;
            }
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

