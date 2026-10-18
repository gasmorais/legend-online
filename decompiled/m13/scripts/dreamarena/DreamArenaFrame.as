package dreamarena
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dreamarena.item.DreamArenaLeftItem;
   import dreamarena.view.DreamArenaArtifactView;
   import dreamarena.view.DreamArenaDragonTalkerView;
   import dreamarena.view.DreamArenaGoddessView;
   import dreamarena.view.DreamArenaHeroView;
   import dreamarena.view.DreamArenaMainChildView;
   import dreamarena.view.DreamArenaPetView;
   import dreamarena.view.DreamArenaRuneView;
   import dreamarena.view.DreamArenaSlaveChildView;
   import dreamarena.view.DreamArenaTitanView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class DreamArenaFrame extends Frame implements IManualSize
   {
      
      private static const ITEM_COUNT:int = 8;
      
      private var _titleImage:Bitmap;
      
      private var _hasTicketText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _leftBg:Image;
      
      private var _rightBorder:ScaleBitmapImage;
      
      private var _rightBg:Image;
      
      private var _costImage:Image;
      
      private var _lineImage:ScaleBitmapImage;
      
      private var _mainChildView:DreamArenaMainChildView;
      
      private var _slaveChildView:DreamArenaSlaveChildView;
      
      private var _titanView:DreamArenaTitanView;
      
      private var _goddessView:DreamArenaGoddessView;
      
      private var _artifactView:DreamArenaArtifactView;
      
      private var _petView:DreamArenaPetView;
      
      private var _dragonTalkerView:DreamArenaDragonTalkerView;
      
      private var _heroView:DreamArenaHeroView;
      
      private var _runeView:DreamArenaRuneView;
      
      private var _matchBtn:BaseButton;
      
      private var _openBtn:IconButton;
      
      private var _formationBtn:BaseButton;
      
      private var leftList:Vector.<DreamArenaLeftItem>;
      
      private var _leftPanel:ScrollPanel;
      
      private var _leftVbox:VBox;
      
      private var _ticketImage:MutipleImage;
      
      private var _ticketIcon:BaseIconView;
      
      private var _costItem:TokenAmountItem;
      
      private var matchingView:DreamArenaMatchingView;
      
      private var _noOpenCon:Component;
      
      private var _openCon:Component;
      
      private var _openBack:MutipleImage;
      
      private var _winText:FilterFrameText;
      
      private var _loseText:FilterFrameText;
      
      private var _rewardText:FilterFrameText;
      
      private var _winHbox:HBox;
      
      private var _winGrayBox:HBox;
      
      private var _loseHbox:HBox;
      
      private var _loseGrayBox:HBox;
      
      private var winMaxCount:int = 12;
      
      private var loseMaxCount:int = 3;
      
      private var ticketTempId:int;
      
      private var _helpBtn:BaseButton;
      
      public function DreamArenaFrame()
      {
         super();
         initView();
         initLeftView();
         initWinCountView();
         addEvent();
         model.selectIndex = 1;
         refreshView();
         DreamArenaManager.instance.sendDreamArenaRequest(0);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,976,641);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:String = null;
         var _loc1_:String = null;
         var _loc4_:String = null;
         _titleImage = ComponentFactory.Instance.creatBitmap("asset.DreamArenaFrame.titleImage");
         _hasTicketText = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.hasTicketText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.descText");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.leftBg");
         _rightBorder = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.rightBorder");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.rightBg");
         _costImage = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.costImage");
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.lineImage");
         _matchBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.matchBtn");
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.rewardText");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.openBtn");
         _formationBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.formationBtn");
         _leftVbox = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaFrame.leftVbox");
         _costItem = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.costItem");
         _ticketImage = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.ticketShowImage");
         _ticketIcon = ComponentFactory.Instance.creatCustomObject("DreamArenaFrame.ticketIcon");
         _leftPanel = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.leftPanel");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.helpBtn");
         _noOpenCon = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.noOpenCon");
         _openCon = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.openCon");
         _openBack = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.openBack");
         _winText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.winText");
         _loseText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.loseText");
         _winHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.winHbox");
         _winGrayBox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.winGrayBox");
         _loseHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.loseHbox");
         _loseGrayBox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFrame.loseGrayBox");
         addToContent(_titleImage);
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_rightBorder);
         addToContent(_lineImage);
         addToContent(_leftPanel);
         addToContent(_formationBtn);
         addToContent(_noOpenCon);
         addToContent(_openCon);
         addToContent(_descText);
         addToContent(_rewardText);
         addToContent(_helpBtn);
         _leftPanel.setView(_leftVbox);
         _noOpenCon.addChild(_ticketImage);
         _noOpenCon.addChild(_ticketIcon);
         _noOpenCon.addChild(_costImage);
         _noOpenCon.addChild(_costItem);
         _noOpenCon.addChild(_hasTicketText);
         _noOpenCon.addChild(_openBtn);
         _openCon.addChild(_openBack);
         _openCon.addChild(_winText);
         _openCon.addChild(_loseText);
         _openCon.addChild(_winHbox);
         _openCon.addChild(_winGrayBox);
         _openCon.addChild(_loseHbox);
         _openCon.addChild(_loseGrayBox);
         _openCon.addChild(_matchBtn);
         ticketTempId = ConfigInfoManager.instance.getDreamArenaTicket();
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(ticketTempId);
         _ticketIcon.icon = IconFactory.getGoodsIconByTID(ticketTempId);
         if(_loc3_)
         {
            _ticketIcon.tipData = _loc3_.Description;
         }
         if(model.startTime && model.stopTime)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.dateType_mmdd",model.startTime.date,model.startTime.month + 1);
            _loc1_ = LanguageMgr.GetTranslation("public.dateType_mmdd",model.stopTime.date,model.stopTime.month + 1);
            _loc4_ = ConfigInfoManager.instance.getDreamArenaFightTime().join("-");
            _descText.text = LanguageMgr.GetTranslation("DreamArenaFrame.descText.timeText",_loc2_,_loc1_,_loc4_);
         }
         _winText.text = LanguageMgr.GetTranslation("DreamArenaFrame.winText.text");
         _loseText.text = LanguageMgr.GetTranslation("DreamArenaFrame.loseText.text");
         _rewardText.htmlText = LanguageMgr.GetTranslation("DreamArenaFrame.rewardText.text");
         _rewardText.mouseEnabled = true;
      }
      
      private function initLeftView() : void
      {
         var _loc1_:DreamArenaLeftItem = null;
         var _loc2_:int = 0;
         leftList = new Vector.<DreamArenaLeftItem>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new DreamArenaLeftItem(_loc2_ + 1);
            _leftVbox.addChild(_loc1_);
            leftList.push(_loc1_);
            _loc2_++;
         }
         _leftPanel.beginChanges();
         _leftPanel.invalidateViewport();
         _leftPanel.commitChanges();
      }
      
      private function initWinCountView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         var _loc2_:Bitmap = null;
         _loc3_ = 0;
         while(_loc3_ < winMaxCount)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaFrame.winGrapBit");
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaFrame.winBit");
            _winHbox.addChild(_loc4_);
            _winGrayBox.addChild(_loc1_);
            _loc4_.visible = false;
            _loc1_.visible = true;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < loseMaxCount)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaFrame.loseGrapBit");
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaFrame.loseBit");
            _loseHbox.addChild(_loc2_);
            _loseGrayBox.addChild(_loc5_);
            _loc2_.visible = false;
            _loc5_.visible = true;
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _formationBtn.addEventListener("click",_formationBtnClickHandler);
         _matchBtn.addEventListener("click",_matchBtnClickHandler);
         _openBtn.addEventListener("click",__openBtnClickHandler);
         _rewardText.addEventListener("click",_rewardClickHandler);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
         MsgMan.addObserver("LEFT_ITEM_SELECT",this,__itemSelectChangeHandler);
         MsgMan.addObserver("USER_INFO_CHANGE",this,__userInfoChangeHandler);
         MsgMan.addObserver("MATCH_STATE_UPDATE",this,__updateMatchHandler);
         MsgMan.addObserver("DREAM_ARENA_TICKET_CHANGE",this,__updateTicketHandler);
         MsgMan.addObserver("FIGHT_INFO_CHANGE",this,__updateTicketHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_formationBtn)
         {
            _formationBtn.removeEventListener("click",_formationBtnClickHandler);
         }
         if(_openBtn)
         {
            _openBtn.removeEventListener("click",__openBtnClickHandler);
         }
         if(_matchBtn)
         {
            _matchBtn.removeEventListener("click",_matchBtnClickHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         if(_rewardText)
         {
            _rewardText.removeEventListener("click",_rewardClickHandler);
         }
         MsgMan.removeObserver("LEFT_ITEM_SELECT",this,__itemSelectChangeHandler);
         MsgMan.removeObserver("USER_INFO_CHANGE",this,__userInfoChangeHandler);
         MsgMan.removeObserver("MATCH_STATE_UPDATE",this,__updateMatchHandler);
         MsgMan.removeObserver("DREAM_ARENA_TICKET_CHANGE",this,__updateTicketHandler);
         MsgMan.removeObserver("FIGHT_INFO_CHANGE",this,__updateTicketHandler);
      }
      
      private function _formationBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("dreamarena","FORMATION_FRAME");
      }
      
      private function _rewardClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("dreamarena","PREVIEW_REWARD_FRAME");
      }
      
      private function __openBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(model.hasTicket <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaFrame.open.noTicketAlert"));
            return;
         }
         var _loc2_:int = int(model.checkAllSelected());
         if(_loc2_ != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaFrame.match.noSaveAlert" + _loc2_));
            return;
         }
         DreamArenaManager.instance.sendDreamArenaRequest(13);
      }
      
      private function __updateMatchHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         if(_loc3_ == 0)
         {
            if(!matchingView)
            {
               matchingView = new DreamArenaMatchingView();
               matchingView.addEventListener("dispose",__disposeMatchingView);
            }
            matchingView.show();
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaMatchingView.timeOut.alert"));
            __disposeMatchingView(null);
         }
      }
      
      private function __disposeMatchingView(param1:Event) : void
      {
         if(matchingView)
         {
            matchingView.removeEventListener("dispose",__disposeMatchingView);
         }
         ObjectUtils.disposeObject(matchingView);
         matchingView = null;
      }
      
      private function _matchBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!model.canMatch)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaFrame.match.notTimeAlert"));
            return;
         }
         var _loc2_:int = int(model.checkAllSelected());
         if(_loc2_ != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaFrame.match.noSaveAlert" + _loc2_));
            return;
         }
         DreamArenaManager.instance.sendDreamArenaRequest(11);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("dreamarena.DreamArenaFrame.helpFrame");
         _loc2_.show();
      }
      
      private function __userInfoChangeHandler(param1:String, param2:Object) : void
      {
         refreshLeftView();
         if(model.selectIndex == 1)
         {
            if(model.selectJob == 4)
            {
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               if(!_dragonTalkerView)
               {
                  _dragonTalkerView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.dragonTalkerView");
               }
               _dragonTalkerView.refreshView();
               addToContent(_dragonTalkerView);
            }
            else
            {
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               if(!_heroView)
               {
                  _heroView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.heroView");
               }
               _heroView.refreshView();
               addToContent(_heroView);
            }
         }
         if(_runeView)
         {
            _runeView.refreshView();
         }
         if(_petView)
         {
            _petView.refreshView();
         }
         if(_artifactView)
         {
            _artifactView.refreshView();
         }
         if(_goddessView)
         {
            _goddessView.refreshView();
         }
         if(_titanView)
         {
            _titanView.refreshView();
         }
         if(_mainChildView)
         {
            _mainChildView.refreshView();
         }
         if(_slaveChildView)
         {
            _slaveChildView.refreshView();
         }
      }
      
      private function __itemSelectChangeHandler(param1:String, param2:Object) : void
      {
         refreshLeftView();
         switch(int(model.selectIndex) - 1)
         {
            case 0:
               if(model.selectJob == 4)
               {
                  ObjectUtils.disposeObject(_heroView);
                  _heroView = null;
                  if(!_dragonTalkerView)
                  {
                     _dragonTalkerView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.dragonTalkerView");
                  }
                  _dragonTalkerView.refreshView();
                  addToContent(_dragonTalkerView);
               }
               else
               {
                  ObjectUtils.disposeObject(_dragonTalkerView);
                  _dragonTalkerView = null;
                  if(!_heroView)
                  {
                     _heroView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.heroView");
                  }
                  _heroView.refreshView();
                  addToContent(_heroView);
               }
               ObjectUtils.disposeObject(_runeView);
               _runeView = null;
               ObjectUtils.disposeObject(_petView);
               _petView = null;
               ObjectUtils.disposeObject(_artifactView);
               _artifactView = null;
               ObjectUtils.disposeObject(_goddessView);
               _goddessView = null;
               ObjectUtils.disposeObject(_titanView);
               _titanView = null;
               ObjectUtils.disposeObject(_mainChildView);
               _mainChildView = null;
               ObjectUtils.disposeObject(_slaveChildView);
               _slaveChildView = null;
               break;
            case 1:
               if(!_runeView)
               {
                  _runeView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.runeView");
               }
               addToContent(_runeView);
               ObjectUtils.disposeObject(_petView);
               _petView = null;
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               ObjectUtils.disposeObject(_artifactView);
               _artifactView = null;
               ObjectUtils.disposeObject(_goddessView);
               _goddessView = null;
               ObjectUtils.disposeObject(_titanView);
               _titanView = null;
               ObjectUtils.disposeObject(_mainChildView);
               _mainChildView = null;
               ObjectUtils.disposeObject(_slaveChildView);
               _slaveChildView = null;
               break;
            case 2:
               if(!_petView)
               {
                  _petView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.petView");
               }
               addToContent(_petView);
               ObjectUtils.disposeObject(_runeView);
               _runeView = null;
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               ObjectUtils.disposeObject(_artifactView);
               _artifactView = null;
               ObjectUtils.disposeObject(_goddessView);
               _goddessView = null;
               ObjectUtils.disposeObject(_titanView);
               _titanView = null;
               ObjectUtils.disposeObject(_mainChildView);
               _mainChildView = null;
               ObjectUtils.disposeObject(_slaveChildView);
               _slaveChildView = null;
               break;
            case 3:
               if(!_artifactView)
               {
                  _artifactView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.artifactView");
               }
               addToContent(_artifactView);
               ObjectUtils.disposeObject(_runeView);
               _runeView = null;
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               ObjectUtils.disposeObject(_petView);
               _petView = null;
               ObjectUtils.disposeObject(_goddessView);
               _goddessView = null;
               ObjectUtils.disposeObject(_titanView);
               _titanView = null;
               ObjectUtils.disposeObject(_mainChildView);
               _mainChildView = null;
               ObjectUtils.disposeObject(_slaveChildView);
               _slaveChildView = null;
               break;
            case 4:
               if(!_goddessView)
               {
                  _goddessView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.goddessView");
               }
               addToContent(_goddessView);
               ObjectUtils.disposeObject(_runeView);
               _runeView = null;
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               ObjectUtils.disposeObject(_artifactView);
               _artifactView = null;
               ObjectUtils.disposeObject(_petView);
               _petView = null;
               ObjectUtils.disposeObject(_titanView);
               _titanView = null;
               ObjectUtils.disposeObject(_mainChildView);
               _mainChildView = null;
               ObjectUtils.disposeObject(_slaveChildView);
               _slaveChildView = null;
               break;
            case 5:
               if(!_titanView)
               {
                  _titanView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.titanView");
               }
               addToContent(_titanView);
               ObjectUtils.disposeObject(_runeView);
               _runeView = null;
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               ObjectUtils.disposeObject(_artifactView);
               _artifactView = null;
               ObjectUtils.disposeObject(_goddessView);
               _goddessView = null;
               ObjectUtils.disposeObject(_petView);
               _petView = null;
               ObjectUtils.disposeObject(_mainChildView);
               _mainChildView = null;
               ObjectUtils.disposeObject(_slaveChildView);
               _slaveChildView = null;
               break;
            case 6:
               if(!_mainChildView)
               {
                  _mainChildView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.mainChildView");
               }
               addToContent(_mainChildView);
               ObjectUtils.disposeObject(_runeView);
               _runeView = null;
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               ObjectUtils.disposeObject(_artifactView);
               _artifactView = null;
               ObjectUtils.disposeObject(_goddessView);
               _goddessView = null;
               ObjectUtils.disposeObject(_titanView);
               _titanView = null;
               ObjectUtils.disposeObject(_petView);
               _petView = null;
               ObjectUtils.disposeObject(_slaveChildView);
               _slaveChildView = null;
               break;
            case 7:
               if(!_slaveChildView)
               {
                  _slaveChildView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaFrame.slaveChildView");
               }
               addToContent(_slaveChildView);
               ObjectUtils.disposeObject(_runeView);
               _runeView = null;
               ObjectUtils.disposeObject(_dragonTalkerView);
               _dragonTalkerView = null;
               ObjectUtils.disposeObject(_heroView);
               _heroView = null;
               ObjectUtils.disposeObject(_artifactView);
               _artifactView = null;
               ObjectUtils.disposeObject(_goddessView);
               _goddessView = null;
               ObjectUtils.disposeObject(_titanView);
               _titanView = null;
               ObjectUtils.disposeObject(_petView);
               _petView = null;
               ObjectUtils.disposeObject(_mainChildView);
               _mainChildView = null;
         }
      }
      
      private function __updateTicketHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         _costItem.firstText = "1";
         _hasTicketText.text = LanguageMgr.GetTranslation("DreamArenaFrame.hasTicketText.Text",model.hasTicket);
         if(model.isOpen)
         {
            _noOpenCon.visible = false;
            _openCon.visible = true;
            refreshWinCountView();
         }
         else
         {
            _noOpenCon.visible = true;
            _openCon.visible = false;
         }
      }
      
      private function refreshWinCountView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < winMaxCount)
         {
            _winHbox.getChildAt(_loc1_).visible = _loc1_ < model.winCount;
            _winGrayBox.getChildAt(_loc1_).visible = _loc1_ >= model.winCount;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < loseMaxCount)
         {
            _loseHbox.getChildAt(_loc1_).visible = _loc1_ < model.loseCount;
            _loseGrayBox.getChildAt(_loc1_).visible = _loc1_ >= model.loseCount;
            _loc1_++;
         }
      }
      
      private function refreshLeftView() : void
      {
         var _loc1_:DreamArenaLeftItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = leftList[_loc2_];
            _loc1_.refreshView();
            _loc2_++;
         }
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = false;
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_hasTicketText);
         _hasTicketText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_rightBorder);
         _rightBorder = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_costImage);
         _costImage = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_mainChildView);
         _mainChildView = null;
         ObjectUtils.disposeObject(_slaveChildView);
         _slaveChildView = null;
         ObjectUtils.disposeObject(_titanView);
         _titanView = null;
         ObjectUtils.disposeObject(_goddessView);
         _goddessView = null;
         ObjectUtils.disposeObject(_artifactView);
         _artifactView = null;
         ObjectUtils.disposeObject(_petView);
         _petView = null;
         ObjectUtils.disposeObject(_runeView);
         _runeView = null;
         ObjectUtils.disposeObject(_dragonTalkerView);
         _dragonTalkerView = null;
         ObjectUtils.disposeObject(_heroView);
         _heroView = null;
         ObjectUtils.disposeObject(_leftVbox);
         _leftVbox = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_matchBtn);
         _matchBtn = null;
         ObjectUtils.disposeObject(_formationBtn);
         _formationBtn = null;
         ObjectUtils.disposeObject(_costItem);
         _costItem = null;
         ObjectUtils.disposeObject(_ticketIcon);
         _ticketIcon = null;
         ObjectUtils.disposeObject(_leftPanel);
         _leftPanel = null;
         ObjectUtils.disposeObject(matchingView);
         matchingView = null;
         ObjectUtils.disposeObject(_ticketImage);
         _ticketImage = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_noOpenCon);
         _noOpenCon = null;
         ObjectUtils.disposeObject(_openCon);
         _openCon = null;
         ObjectUtils.disposeObject(_openBack);
         _openBack = null;
         ObjectUtils.disposeObject(_winText);
         _winText = null;
         ObjectUtils.disposeObject(_loseText);
         _loseText = null;
         ObjectUtils.disposeObject(_winHbox);
         _winHbox = null;
         ObjectUtils.disposeObject(_winGrayBox);
         _winGrayBox = null;
         ObjectUtils.disposeObject(_loseHbox);
         _loseHbox = null;
         ObjectUtils.disposeObject(_loseGrayBox);
         _loseGrayBox = null;
         ObjectUtils.disposeObject(_rewardText);
         _rewardText = null;
         LogicUtils.disposeDisplayCollection(leftList);
         leftList = null;
         model.clientSelectDic.clear();
         super.dispose();
      }
   }
}

