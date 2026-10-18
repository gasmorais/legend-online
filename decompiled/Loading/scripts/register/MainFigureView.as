package register
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import loading.MaxLoading;
   import manager.DesktopManager;
   import manager.ExternalInterfaceManager;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import manager.NamesLibManager;
   import newbie.NewbieSPHelper;
   
   public class MainFigureView extends Sprite implements IManualSize
   {
      
      private var _viewRect:Rectangle = new Rectangle(0,0,1400,800);
      
      public const MAX_LENGTH:int = 12;
      
      public const MIN_LENGTH:int = 4;
      
      private var _back:Bitmap;
      
      private var _showNetTips01:Bitmap;
      
      private var _showNetTips02:Bitmap;
      
      private var _bg:MovieClip;
      
      private var _confirmBtn:IconButton;
      
      private var _containerHead:Sprite;
      
      private var _head1:HeadComp;
      
      private var _head2:HeadComp;
      
      private var _head3:HeadComp;
      
      private var _head4:HeadComp;
      
      private var _head5:HeadComp;
      
      private var _head6:HeadComp;
      
      private var _tipsBg:ScaleBitmapImage;
      
      private var _tipsContentTxt:FilterFrameText;
      
      private var _shaiziBtn:BaseButton;
      
      private var _renameTxt:FilterFrameText;
      
      private var _describtTxt:FilterFrameText;
      
      private var _figureNameBg:MovieClip;
      
      private var _currentSelectRole:HeadComp;
      
      private var _preSelectRole:HeadComp;
      
      private var _userInfo:Object;
      
      private var _renameCallBack:Function;
      
      private var _nickName:String = "";
      
      private var _txtChange:String = "";
      
      private var _titlePos1:int;
      
      private var _titlePos2:int;
      
      private var _titlePos3:int;
      
      public function MainFigureView(param1:Object, param2:Function)
      {
         super();
         _userInfo = param1;
         _renameCallBack = param2;
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _viewRect;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.mainloadingii.register.Back");
         _showNetTips01 = ComponentFactory.Instance.creatBitmap("asset.mainloadingii.register.Back01");
         _showNetTips02 = ComponentFactory.Instance.creatBitmap("asset.mainloadingii.register.Back02");
         _bg = ComponentFactory.Instance.creat("asset.mainloadingii.register.MainFigureBg") as MovieClip;
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("mainloadingii.register.ChooseView.ConfirmBtn");
         _head1 = ComponentFactory.Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp1",[2,__roleClickHandler]);
         _head2 = ComponentFactory.Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp2",[1,__roleClickHandler]);
         _head3 = ComponentFactory.Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp3",[4,__roleClickHandler]);
         _head4 = ComponentFactory.Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp4",[3,__roleClickHandler]);
         _head5 = ComponentFactory.Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp5",[6,__roleClickHandler]);
         _head6 = ComponentFactory.Instance.creatCustomObject("mainloadingii.register.ChooseView.HeadComp6",[5,__roleClickHandler]);
         _tipsBg = ComponentFactory.Instance.creatComponentByStylename("mainloadingii.register.ChooseView.commonTipBg");
         _tipsContentTxt = ComponentFactory.Instance.creatComponentByStylename("mainloadingii.register.ChooseView.commonTipText");
         _shaiziBtn = ComponentFactory.Instance.creatComponentByStylename("mainloadingii.register.ChooseView.ShaiziBtn");
         _renameTxt = ComponentFactory.Instance.creatComponentByStylename("mainloadingii.register.ChooseView.ReNameTxt");
         _describtTxt = ComponentFactory.Instance.creatComponentByStylename("mainloadingii.register.ChooseView.DescribeTxt");
         _figureNameBg = ComponentFactory.Instance.creat("asset.mainloadingii.register.figureNameBg");
         _containerHead = new Sprite();
         _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt01");
         _describtTxt.setFrame(2);
         _containerHead.x = 50;
         _containerHead.addChild(_head1);
         _containerHead.addChild(_head2);
         _containerHead.addChild(_head3);
         _containerHead.addChild(_head4);
         _containerHead.addChild(_head5);
         _containerHead.addChild(_head6);
         this.addChild(_back);
         this.addChild(_bg);
         this.addChild(_containerHead);
         this.addChild(_confirmBtn);
         this.addChild(_tipsContentTxt);
         this.addChild(_shaiziBtn);
         this.addChild(_figureNameBg);
         this.addChild(_renameTxt);
         this.addChild(_describtTxt);
         _showNetTips01.visible = _showNetTips02.visible = MaxLoading.showNetTips;
         _showNetTips01.x = _back.x + (_back.width - _showNetTips01.width) * 0.5;
         _showNetTips01.y = _back.y + 30;
         _showNetTips02.x = _back.x + (_back.width - _showNetTips02.width) * 0.5;
         _showNetTips02.y = _back.y + _back.height - _showNetTips02.height - 30;
         _titlePos1 = _bg.title1.y;
         _titlePos2 = _bg.title3.y;
         _titlePos3 = _bg.title5.y;
         var _loc1_:int = int(Math.random() * 6) + 1;
         _preSelectRole = this["_head" + _loc1_];
         _preSelectRole.dispatchEvent(new MouseEvent("click"));
         _shaiziBtn.visible = false;
         _renameTxt.text = NamesLibManager.newName(getSex());
         if(_renameTxt.text != "")
         {
            _shaiziBtn.visible = true;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_showNetTips01);
         _showNetTips01 = null;
         ObjectUtils.disposeObject(_showNetTips02);
         _showNetTips02 = null;
         ObjectUtils.disposeViolentMc(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_containerHead);
         _containerHead = null;
         ObjectUtils.disposeObject(_head1);
         _head1 = null;
         ObjectUtils.disposeObject(_head2);
         _head2 = null;
         ObjectUtils.disposeObject(_head3);
         _head3 = null;
         ObjectUtils.disposeObject(_head4);
         _head4 = null;
         ObjectUtils.disposeObject(_head5);
         _head5 = null;
         ObjectUtils.disposeObject(_head6);
         _head6 = null;
         ObjectUtils.disposeObject(_tipsBg);
         _tipsBg = null;
         ObjectUtils.disposeObject(_tipsContentTxt);
         _tipsContentTxt = null;
         ObjectUtils.disposeObject(_shaiziBtn);
         _shaiziBtn = null;
         ObjectUtils.disposeObject(_renameTxt);
         _renameTxt = null;
         ObjectUtils.disposeObject(_describtTxt);
         _describtTxt = null;
         ObjectUtils.disposeViolentMc(_figureNameBg);
         _figureNameBg = null;
         ObjectUtils.disposeObject(_currentSelectRole);
         _currentSelectRole = null;
         ObjectUtils.disposeObject(_preSelectRole);
         _preSelectRole = null;
         ObjectUtils.disposeAllChildren(this);
         _currentSelectRole = null;
         _preSelectRole = null;
         _userInfo = null;
         _renameCallBack = null;
      }
      
      private function addEvent() : void
      {
         _confirmBtn.addEventListener("click",__confirmBtnClickHandler);
         _shaiziBtn.addEventListener("click",__shaiziBtnClickHandler);
         _renameTxt.addEventListener("keyDown",__keyDownHandler);
         _renameTxt.addEventListener("change",__onTxtChange);
      }
      
      private function removeEvent() : void
      {
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnClickHandler);
         }
         if(_shaiziBtn)
         {
            _shaiziBtn.removeEventListener("click",__shaiziBtnClickHandler);
         }
         if(_renameTxt)
         {
            _renameTxt.removeEventListener("keyDown",__keyDownHandler);
         }
         if(_renameTxt)
         {
            _renameTxt.removeEventListener("change",__onTxtChange);
         }
      }
      
      private function __shaiziBtnClickHandler(param1:MouseEvent) : void
      {
         _renameTxt.text = NamesLibManager.newName(getSex());
      }
      
      private function __confirmBtnClickHandler(param1:MouseEvent) : void
      {
         loadRegister();
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 13)
         {
            case 0:
               __confirmBtnClickHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onTxtChange(param1:Event) : void
      {
         _describtTxt.setFrame(2);
         _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt01");
         if(checkStringLength(_renameTxt.text) > 12)
         {
            _renameTxt.text = _txtChange;
         }
         _txtChange = _renameTxt.text;
      }
      
      public function checkStringLength(param1:String) : int
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(param1,"");
         return _loc2_.length;
      }
      
      private function __roleClickHandler(param1:MouseEvent) : void
      {
         if(_currentSelectRole == param1.currentTarget)
         {
            return;
         }
         _preSelectRole.selected = false;
         _currentSelectRole = param1.currentTarget as HeadComp;
         _currentSelectRole.selected = true;
         _preSelectRole = _currentSelectRole;
         _containerHead.addChildAt(_currentSelectRole,_containerHead.numChildren - 1);
         setBody(_currentSelectRole.headId);
      }
      
      private function setBody(param1:int) : void
      {
         var _loc2_:String = "asset.mainloadingii.register.RoleIcon_" + param1;
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap(_loc2_);
         ObjectUtils.disposeAllChildren(_bg.bodyContainer);
         _bg.bodyContainer.addChild(_loc3_);
         reviseTitlePos(param1);
      }
      
      private function reviseTitlePos(param1:int) : void
      {
         _bg.title1.y = _titlePos1;
         _bg.title3.y = _titlePos2;
         _bg.title5.y = _titlePos3;
         switch(param1 - 1)
         {
            case 0:
            case 1:
               _bg.title1.y = _titlePos1 - 40;
               break;
            case 2:
            case 3:
               _bg.title3.y = _titlePos2 - 40;
               break;
            case 4:
            case 5:
               _bg.title5.y = _titlePos3 - 40;
         }
      }
      
      private function getSex() : int
      {
         return _currentSelectRole.headId % 2;
      }
      
      private function getIcon() : int
      {
         switch(_currentSelectRole.headId - 1)
         {
            case 0:
            case 2:
               return _currentSelectRole.headId;
            case 1:
               return 4;
            case 3:
               return 6;
            case 4:
               return 2;
            case 5:
               return 5;
            default:
               return 0;
         }
      }
      
      private function loadRegister() : void
      {
         _nickName = _renameTxt.text;
         _nickName = _nickName.replace("\r","");
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(_nickName,"");
         var _loc4_:int = int(_loc3_.length);
         if(_nickName == "")
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt02");
            return;
         }
         if(_loc4_ < 4)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt03");
            return;
         }
         if(_loc4_ > 12)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt04");
            return;
         }
         if(FilterWordManager.containUnableChar(_nickName) || FilterWordManager.filterWrod(_nickName) != _nickName)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt05");
            return;
         }
         _confirmBtn.enable = false;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["client"] = DesktopManager.Instance.isDesktop;
         _loc1_["userid"] = _userInfo.userId;
         _loc1_["nickname"] = _nickName;
         _loc1_["jumpnovice"] = 0;
         _loc1_["camp"] = 1;
         _loc1_["sex"] = getSex();
         _loc1_["icon"] = getIcon();
         _loc1_["username"] = _userInfo.user;
         _loc1_["site"] = _userInfo.site;
         _loc1_["key"] = _userInfo.key;
         _loc1_["ran"] = Math.random();
         var _loc2_:String = ComponentSetting.REQUEST_PATH + "visualizeregister";
         LoaderManagerII.instance.load(_loc2_,7,0,__onRegisterCompleteHandler,null,__onRegisterErrorHandler,null,_loc1_);
      }
      
      private function __onRegisterCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Array = null;
         var _loc9_:int = 0;
         var _loc11_:String = null;
         var _loc5_:URLVariables = null;
         var _loc4_:URLRequest = null;
         var _loc8_:URLLoader = null;
         var _loc7_:XML = XML(param2);
         var _loc6_:String = _loc7_.@value;
         var _loc10_:int = int(_loc7_.@type);
         if(_loc6_ == "true" && (_loc10_ == 0 || _loc10_ == 3))
         {
            _confirmBtn.enable = false;
            mouseEnabled = mouseChildren = false;
            ExternalInterfaceManager.instance.setFirstLeave(_userInfo.site,_userInfo.user);
            _loc3_ = _userInfo.site.split("_");
            if(_loc3_[0] == "duowan")
            {
               try
               {
                  _loc9_ = int(_loc3_[1]);
                  _loc11_ = "http://assist" + _loc9_ + ".shenqu.game.yy.com/";
                  _loc5_ = new URLVariables();
                  _loc5_["username"] = _userInfo.user;
                  _loc5_["site"] = _userInfo.site;
                  _loc5_["type"] = 4;
                  _loc5_["rnd"] = Math.random();
                  _loc4_ = new URLRequest(_loc11_ + "playerNotify");
                  _loc4_.data = _loc5_;
                  _loc8_ = new URLLoader();
                  _loc8_.load(_loc4_);
               }
               catch(e:Error)
               {
               }
            }
            NewbieSPHelper.saveNoviceProcess(_userInfo,10000,onNoviceProcessSaveComplete);
         }
         else
         {
            if(_confirmBtn)
            {
               _confirmBtn.enable = true;
            }
            if(_describtTxt)
            {
               _describtTxt.setFrame(1);
               _describtTxt.text = _loc7_.@message;
            }
         }
      }
      
      private function __onRegisterErrorHandler(param1:LoaderInfo, param2:Object) : void
      {
         _confirmBtn.enable = true;
         _describtTxt.setFrame(1);
         _describtTxt.text = LanguageMgr.GetTranslation("noviceII.view.AddUserNameFrame.checkNickErrorEvent2");
      }
      
      private function onNoviceProcessSaveComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = param1 ? param1.target as URLLoader : null;
         if(_loc2_)
         {
            _loc2_.removeEventListener("complete",onNoviceProcessSaveComplete);
         }
         _confirmBtn.visible = false;
         StageReferance.stage.focus = null;
         if(_renameCallBack != null)
         {
            _renameCallBack();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

