package magicpub
{
   import chat.datas.ChatData;
   import com.greensock.text.SplitTextField;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.magicpub.MagicPubInfoMsg;
   import dialog.DialogWordHandler;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.CurrencyInfo;
   import mvc.module.currency.CurrencyType;
   import mvc.module.currency.PlayerCurrencyInfo;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.MagicPubChatTemplateInfo;
   import yishi.datas.templates.MagicPubNpcTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.MagicPubManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MagicPubChatView extends Component
   {
      
      private var _clickStrip:StripView;
      
      private var _giftBg:DisplayObject;
      
      private var _noteBmp:DisplayObject;
      
      private var _noteBg:DisplayObject;
      
      private var _bottomBg:DisplayObject;
      
      private var _data:MagicPubInfoMsg;
      
      private var _isLoading:Boolean;
      
      private var _mountMovieClip:MovieClip;
      
      private var _returnBtn:IconButton;
      
      private var _sendBtn:IconButton;
      
      private var _dialogText:FilterFrameText;
      
      private var _stf:SplitTextField;
      
      private var _speakEndHandler:Function;
      
      private var _speakHandler:DialogWordHandler;
      
      private var _txtWidth:Number = 530;
      
      private var _nameText:FilterFrameText;
      
      private var _name:String;
      
      private var _sentence:String;
      
      private var _itemList:Vector.<MagicPubGiftItem>;
      
      private var _currentItem:MagicPubGiftItem;
      
      private const COUNT:int = 10;
      
      private var _nameTxt:FilterFrameText;
      
      private var _friendTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _yellowBar:MovieClip;
      
      private var _leftSendTxt:FilterFrameText;
      
      private var _talkBtn:IconButton;
      
      private var _doubleBmp2:Image;
      
      private var _listArr:Array = [];
      
      private var _isPlay:Boolean;
      
      private var _effect:MainToolBtnGlowEffect;
      
      public function MagicPubChatView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MagicPubGiftItem = null;
         _clickStrip = ComponentFactory.Instance.creatCustomObject("magicpub.clickStripView");
         _giftBg = ComponentFactory.Instance.creatBitmap("asset.magicpub.gift.Bg");
         _noteBmp = ComponentFactory.Instance.creatBitmap("asset.magicpub.npc.noteBmp");
         _noteBg = ComponentFactory.Instance.creatBitmap("asset.magicpub.npc.noteBg");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.magicpub.npc.dialogBg");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.npc.returnBtn");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.npc.sendBtn");
         _dialogText = ComponentFactory.Instance.creatComponentByStylename("core.novice.DialogText");
         _stf = new SplitTextField();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubChatView.Name");
         _friendTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubChatView.Friend");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubChatView.Progress");
         _yellowBar = ComponentFactory.Instance.creatCustomObject("magicpub.chat.yellowBar");
         _leftSendTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubChatView.leftSendTxt");
         _talkBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.npc.talkBtn");
         _doubleBmp2 = ComponentFactory.Instance.creatComponentByStylename("magicpub.item.doubleBmp2");
         addChild(_clickStrip);
         addChild(_giftBg);
         addChild(_noteBmp);
         addChild(_noteBg);
         addChild(_bottomBg);
         addChild(_returnBtn);
         addChild(_sendBtn);
         addChild(_dialogText);
         addChild(_nameTxt);
         addChild(_friendTxt);
         addChild(_yellowBar);
         addChild(_progressTxt);
         addChild(_leftSendTxt);
         addChild(_talkBtn);
         addChild(_doubleBmp2);
         _clickStrip.setHitArea(0,0,926,510);
         _itemList = new Vector.<MagicPubGiftItem>();
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = new MagicPubGiftItem();
            _loc1_.x = int(_loc2_ % 6) * 52 + 537;
            _loc1_.y = int(_loc2_ / 6) * 53 + 80;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _clickStrip.addEventListener("click",__onClickHandler);
         _returnBtn.addEventListener("click",__returnHandler);
         _sendBtn.addEventListener("click",__sendHandler);
         _talkBtn.addEventListener("click",__talkHandler);
         NotificationManager.instance.addEventListener("MAGICPUB_UPDATE_CHAT_VIEW",__updateChatHandler);
         StageReferance.stage.addEventListener("keyDown",__onKeyDownHandler,false,101);
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].addEventListener("click",__itemClick);
            _loc1_++;
         }
         __refreshGiftView(null);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _clickStrip.removeEventListener("click",__onClickHandler);
         _returnBtn.removeEventListener("click",__returnHandler);
         _sendBtn.removeEventListener("click",__sendHandler);
         _talkBtn.removeEventListener("click",__talkHandler);
         NotificationManager.instance.removeEventListener("MAGICPUB_UPDATE_CHAT_VIEW",__updateChatHandler);
         StageReferance.stage.removeEventListener("keyDown",__onKeyDownHandler,false);
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].removeEventListener("click",__itemClick);
            _loc1_++;
         }
      }
      
      public function set data(param1:MagicPubInfoMsg) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         startLoad();
         MagicPubManager.instance.OperateMagicHotelReq(2,_data.templateId);
      }
      
      private function __updateChatHandler(param1:NotificationEvent) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         if(!_data)
         {
            return;
         }
         _dialogText.x = 153;
         _dialogText.y = 428;
         _dialogText.width = _txtWidth;
         var _loc3_:int = int(_data.grades > 4 ? 4 : _data.grades);
         var _loc2_:MagicPubChatTemplateInfo = TempleteManager.instance.magicPubChatTemplateCate.getTemplateByID(_data.templateId,_loc3_);
         switch(int(_data.state) - 1)
         {
            case 0:
               _loc4_ = _loc2_.GreetWord.split("|");
               break;
            case 1:
               _loc4_ = _loc2_.AskWord.split("|");
               break;
            case 2:
               _loc4_ = _loc2_.ThankWord.split("|");
         }
         _loc5_ = Math.floor(Math.random() * (_loc4_.length - 1 - 0 + 1));
         _sentence = _loc4_[_loc5_];
         _dialogText.htmlText = "    " + _sentence;
         _stf.source = _dialogText;
         refreshView();
         if(_speakHandler)
         {
            _speakHandler.canStop();
            _speakHandler = null;
         }
         _speakHandler = new DialogWordHandler(_stf,speakEndHandler);
         _speakHandler.start();
         isPlay = true;
         _talkBtn.visible = _data.isFirst;
         _doubleBmp2.visible = _data.isEvent;
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:MagicPubNpcTemplateInfo = TempleteManager.instance.magicPubNpcTemplateCate.getTemplateByID(_data.templateId);
         _nameTxt.text = _loc1_.TemplateName;
         var _loc7_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_data.grades + 1,126);
         if(!_loc7_)
         {
            _progressTxt.text = "max";
            _loc2_ = 100;
         }
         else
         {
            _loc4_ = int(_data.gp);
            _loc5_ = int(_loc7_.Data);
            _progressTxt.text = _loc4_ + "/" + _loc5_;
            _loc2_ = _loc4_ / _loc5_ * 100;
         }
         _yellowBar.gotoAndStop(_loc2_);
         var _loc6_:int = int(_data.grades > 4 ? 4 : _data.grades);
         _friendTxt.text = LanguageMgr.GetTranslation("public.level2",_loc6_);
         var _loc3_:int = int(ConfigInfoManager.instance.getMagicPubPresentCount());
         _leftSendTxt.htmlText = LanguageMgr.GetTranslation("magicpub.MagicPubChatView.leftSendText",_loc3_ - _data.presentCount,_loc3_);
      }
      
      private function speakEndHandler() : void
      {
         if(isDie)
         {
            return;
         }
         isPlay = false;
         showTipMessage();
         __refreshGiftView(null);
      }
      
      private function showTipMessage() : void
      {
         var _loc2_:String = null;
         var _loc1_:ChatData = null;
         if(MagicPubManager.instance.listMsg.tip && MagicPubManager.instance.listMsg.tip.length > 0)
         {
            MessageTipManager.instance().show(MagicPubManager.instance.listMsg.tip);
            _loc2_ = MagicPubManager.instance.listMsg.tip;
            _loc1_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc1_.channel = 3;
            _loc1_.msg = _loc2_;
            _loc1_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc1_);
            MagicPubManager.instance.listMsg.tip = "";
         }
      }
      
      private function set isPlay(param1:Boolean) : void
      {
         _isPlay = param1;
         if(_isPlay)
         {
            if(_effect)
            {
               _effect.stop();
               ObjectUtils.disposeObject(_effect);
               _effect = null;
            }
            _talkBtn.enable = false;
            _sendBtn.enable = false;
         }
         else
         {
            _talkBtn.enable = true;
            _effect = new MainToolBtnGlowEffect(_talkBtn);
            _effect.play();
            _sendBtn.enable = true;
         }
      }
      
      private function __refreshGiftView(param1:NotificationEvent) : void
      {
         var _loc5_:CurrencyInfo = null;
         var _loc4_:int = 0;
         var _loc3_:MagicPubGiftItem = null;
         var _loc6_:int = 0;
         _listArr = [];
         var _loc2_:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc5_ = _loc2_.getMagicPubCurrencyInfoByType(CurrencyType.MAGIC_PUB_TYPE_LIST[_loc4_]);
            if(_loc5_ && _loc5_.amount > 0)
            {
               _listArr.push([CurrencyType.MAGIC_PUB_VALUE_LIST[_loc4_],_loc5_.amount]);
            }
            _loc4_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _itemList.length)
         {
            _loc3_ = _itemList[_loc6_];
            if(_loc6_ < _listArr.length)
            {
               _loc3_.data = _listArr[_loc6_][0];
               _loc3_.count = _listArr[_loc6_][1];
            }
            else
            {
               _loc3_.data = 0;
               _loc3_.count = 0;
            }
            _loc6_++;
         }
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         if((param1.currentTarget as MagicPubGiftItem).templeteId == 0)
         {
            return;
         }
         if(_currentItem && _currentItem.templeteId == (param1.currentTarget as MagicPubGiftItem).templeteId)
         {
            return;
         }
         if(_currentItem)
         {
            _currentItem.stop();
         }
         _currentItem = param1.currentTarget as MagicPubGiftItem;
         _currentItem.play();
      }
      
      private function __returnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_OPEN_CHAT_VIEW",null));
         if(_currentItem)
         {
            _currentItem.stop();
            _currentItem = null;
         }
      }
      
      private function __talkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         MagicPubManager.instance.OperateMagicHotelReq(1,_data.templateId);
         _talkBtn.visible = false;
         isPlay = true;
      }
      
      private function __sendHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_currentItem)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("magicpub.MagicPubChatView.noGiftText"));
         }
         else
         {
            MagicPubManager.instance.OperateMagicHotelReq(3,_data.templateId,_currentItem.templeteId,1);
            isPlay = true;
            _currentItem.stop();
            _currentItem = null;
         }
      }
      
      private function __onKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 32)
         {
            __onClickHandler();
         }
      }
      
      private function __onClickHandler(param1:Event = null) : void
      {
         _speakHandler.canStop();
      }
      
      private function startLoad() : void
      {
         var _loc1_:MagicPubNpcTemplateInfo = TempleteManager.instance.magicPubNpcTemplateCate.getTemplateByID(_data.templateId);
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _isLoading = false;
         }
         if(!_data)
         {
            return;
         }
         _isLoading = true;
         var _loc2_:String = PathManager.getMagicPubResourcePath(_loc1_.ResourcePath);
         LoaderManagerII.instance.load(_loc2_,2,4,__onLoaded);
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:BitmapData = null;
         var _loc3_:Rectangle = null;
         _isLoading = false;
         if(isDie)
         {
            return;
         }
         if(_mountMovieClip)
         {
            _mountMovieClip.stop();
            _mountMovieClip.parent && _mountMovieClip.parent.removeChild(_mountMovieClip);
         }
         _mountMovieClip = param2 as MovieClip;
         if(!_mountMovieClip)
         {
            return;
         }
         _mountMovieClip.gotoAndStop(1);
         this.addChildAt(_mountMovieClip,0);
         if(_mountMovieClip["pos_down"])
         {
            _mountMovieClip.x = -_mountMovieClip["pos_down"].x;
            _mountMovieClip.y = -_mountMovieClip["pos_down"].y;
         }
         else
         {
            _loc4_ = new BitmapData(500,500,true,0);
            _loc4_.draw(_mountMovieClip);
            _loc3_ = _loc4_.getColorBoundsRect(4278190080,0,false);
            _loc4_.dispose();
            _loc4_ = null;
         }
         _mountMovieClip.play();
         _mountMovieClip.x = 90;
         _mountMovieClip.y = 90;
      }
      
      public function get data() : MagicPubInfoMsg
      {
         return _data;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         showTipMessage();
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _isLoading = false;
         }
         ObjectUtils.disposeObject(_clickStrip);
         _clickStrip = null;
         ObjectUtils.disposeObject(_giftBg);
         _giftBg = null;
         ObjectUtils.disposeObject(_noteBmp);
         _noteBmp = null;
         ObjectUtils.disposeObject(_noteBg);
         _noteBg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeViolentMc(_mountMovieClip);
         _mountMovieClip = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_sendBtn);
         _sendBtn = null;
         ObjectUtils.disposeObject(_dialogText);
         _dialogText = null;
         ObjectUtils.disposeObject(_stf);
         _stf = null;
         ObjectUtils.disposeObject(_speakHandler);
         _speakHandler = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_friendTxt);
         _friendTxt = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeViolentMc(_yellowBar);
         _yellowBar = null;
         ObjectUtils.disposeObject(_leftSendTxt);
         _leftSendTxt = null;
         ObjectUtils.disposeObject(_talkBtn);
         _talkBtn = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_doubleBmp2);
         _doubleBmp2 = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         _data = null;
         _speakEndHandler = null;
         _currentItem = null;
         super.dispose();
      }
   }
}

