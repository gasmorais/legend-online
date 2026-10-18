package map.space.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DivorceAlert extends Frame implements IManualSize
   {
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _bmp:Bitmap;
      
      private var _vobx1:VBox;
      
      private var _vobx2:VBox;
      
      private var _submitButton:IconButton;
      
      private var _cancelButton:IconButton;
      
      public var backCall:Function;
      
      private var _content:FilterFrameText;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _consult:Boolean;
      
      public function DivorceAlert(param1:int, param2:Boolean = false)
      {
         _type = param1;
         _consult = param2;
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,300,280);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.text1");
         _vobx1 = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.vbox1");
         _vobx2 = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.vbox2");
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.submitButton");
         _cancelButton = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.cancelButton");
         var _loc1_:String = MarryManager.instance.model.selfMarryInfo.nickName;
         if(MarryManager.instance.model.isMarry)
         {
            _txt1.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.DivorceAlert.text01",needPoint,_loc1_);
            _loc3_ = int(MarryManager.instance.model.selfMarryInfo.logoutDays);
            _loc2_ = true;
            if(_type == 92 || _type == 93 || _type == 91)
            {
               if(_type == 91)
               {
                  _txt1.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.DivorceAlert.text13",_loc1_);
                  if(_loc3_ < 5)
                  {
                     _loc2_ = false;
                     _txt1.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.DivorceAlert.text14",_loc1_);
                  }
               }
               else
               {
                  _txt1.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.DivorceAlert.text01",needPoint,_loc1_);
               }
               height = 170;
               if(_loc2_)
               {
                  _bmp = ComponentFactory.Instance.creatBitmap("asset.taskTrace.ItemTitleIcon1");
                  _vobx1.addChild(_bmp);
                  _txt2 = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.text2");
                  _vobx2.addChild(_txt2);
                  _txt2.text = LanguageMgr.GetTranslation("map.space.view.frame.DivorceAlert.text03");
                  _bmp = ComponentFactory.Instance.creatBitmap("asset.taskTrace.ItemTitleIcon1");
                  _vobx1.addChild(_bmp);
                  _txt2 = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.text2");
                  _txt2 = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.text2");
                  _vobx2.addChild(_txt2);
                  _txt2.text = LanguageMgr.GetTranslation("map.space.view.frame.DivorceAlert.text05");
                  _content = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.ConfirmSellContent");
                  _inputBack = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.ConfirmSellInputBack");
                  _inputTxt = ComponentFactory.Instance.creatComponentByStylename("DivorceAlert.ConfirmSellInputTxt");
                  _content.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.DivorceAlert.submitByYesTxt");
                  _vobx1.y = _txt1.y + _txt1.textHeight + 12;
                  _vobx2.y = _txt1.y + _txt1.textHeight + 10;
                  _content.y = _vobx2.height + _vobx2.y + 5;
                  _inputBack.y = _content.y + 27;
                  _inputTxt.y = _inputBack.y + 1;
                  addToContent(_content);
                  addToContent(_inputBack);
                  addToContent(_inputTxt);
                  _cancelButton.y = _submitButton.y = _inputTxt.y + _inputTxt.textHeight + 15;
               }
            }
         }
         addToContent(_txt1);
         addToContent(_vobx1);
         addToContent(_vobx2);
         if(_content != null)
         {
            addToContent(_content);
         }
         if(_inputBack != null)
         {
            addToContent(_inputBack);
         }
         if(_inputTxt != null)
         {
            addToContent(_inputTxt);
         }
         addToContent(_submitButton);
         addToContent(_cancelButton);
         if(_type == 91 && MarryManager.instance.model.selfMarryInfo.logoutDays < 5)
         {
            _cancelButton.visible = false;
            _submitButton.x = 110;
            _submitButton.y = 60;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 == _height)
         {
            return;
         }
         _height = param1;
         if(MarryManager.instance.model.isEngaged)
         {
            _height = 260;
         }
         if(_type == 91 && MarryManager.instance.model.selfMarryInfo.logoutDays < 5)
         {
            _height = 170;
         }
         onPropertiesChanged("height");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _submitButton.addEventListener("click",__submitButtonHandler);
         _cancelButton.addEventListener("click",__cancelButtonHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_submitButton)
         {
            _submitButton.removeEventListener("click",__submitButtonHandler);
         }
         if(_cancelButton)
         {
            _cancelButton.removeEventListener("click",__cancelButtonHandler);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_txt1)
         {
            _txt1.dispose();
         }
         _txt1 = null;
         if(_vobx1)
         {
            _vobx1.dispose();
         }
         _vobx1 = null;
         if(_vobx2)
         {
            _vobx2.dispose();
         }
         _vobx2 = null;
         if(_submitButton)
         {
            _submitButton.dispose();
         }
         _submitButton = null;
         if(_cancelButton)
         {
            _cancelButton.dispose();
         }
         _cancelButton = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_consult)
               {
                  MarrySender.agreeDivorce(marryModel.selfMarryInfo.userId,false);
               }
               dispose();
         }
      }
      
      private function __cancelButtonHandler(param1:MouseEvent) : void
      {
         if(_consult)
         {
            MarrySender.agreeDivorce(marryModel.selfMarryInfo.userId,false);
         }
         param1.stopPropagation();
         dispose();
      }
      
      private function __submitButtonHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         param1.stopPropagation();
         if(_type == 91 && MarryManager.instance.model.selfMarryInfo.logoutDays < 5)
         {
            dispose();
            return;
         }
         if(_inputTxt.text.toLocaleLowerCase() == "yes")
         {
            if(marryModel.isSingle)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.quality.MarryConfirmFrame.noLover"));
            }
            else
            {
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
               if(_type == 92)
               {
                  if(_loc2_ < needPoint)
                  {
                     RechargeAlertMannager.show();
                     return;
                  }
                  MarrySender.divorce(1,"",false);
               }
               else if(_type == 93)
               {
                  if(_loc2_ < needPoint)
                  {
                     RechargeAlertMannager.show();
                     return;
                  }
                  if(_consult)
                  {
                     MarrySender.agreeDivorce(marryModel.selfMarryInfo.userId,true);
                  }
                  else
                  {
                     MarrySender.consultDivorce(marryModel.selfMarryInfo.userId);
                  }
               }
               else if(_type == 91)
               {
                  if(marryModel.selfMarryInfo.logoutDays < 5)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.freeDivorce.tips"));
                  }
                  else
                  {
                     MarrySender.freeDivorce();
                  }
               }
               if(backCall != null)
               {
                  backCall();
               }
               dispose();
            }
         }
         else if(_inputTxt.text.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.inputNull"));
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.inputWrong"));
         }
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get needPoint() : int
      {
         var _loc1_:ConfigInfosTempInfo = null;
         var _loc2_:int = 10;
         if(MarryManager.instance.model.selfMarryInfo.state == 1)
         {
            _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("cancel_engage_need");
            if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.ConfigValue))
            {
               _loc2_ = int(_loc1_.ConfigValue);
            }
         }
         else if(MarryManager.instance.model.selfMarryInfo.state == 3)
         {
            if(_type == 93)
            {
               _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("marriage_deal_divorce_point");
               if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.ConfigValue))
               {
                  _loc2_ = int(_loc1_.ConfigValue);
               }
            }
            else if(_type == 92)
            {
               _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("divorce_need");
               if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.ConfigValue))
               {
                  _loc2_ = int(_loc1_.ConfigValue);
               }
            }
         }
         return _loc2_;
      }
   }
}

