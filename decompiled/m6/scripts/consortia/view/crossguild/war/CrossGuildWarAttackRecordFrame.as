package consortia.view.crossguild.war
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.CrossGuildManager;
   import yishi.utils.MsgMan;
   
   public class CrossGuildWarAttackRecordFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _selfBtn:SelectedIconButton;
      
      private var _vsBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var _titleBack:MutipleImage;
      
      private var _rankText:FilterFrameText;
      
      private var _userText:FilterFrameText;
      
      private var _wayText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _totalScoreText:FilterFrameText;
      
      private var _itemBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _btnGroup:SelectedButtonGroup;
      
      public function CrossGuildWarAttackRecordFrame()
      {
         super();
         initView();
         addEvent();
         CrossGuildManager.instance.sendCrossGuildWar(10);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,485,375);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordFrame.border");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.titleBack");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.rankText");
         _userText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.userText");
         _wayText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.wayText");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.scoreText");
         _totalScoreText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.totalScoreText");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.itemBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.scrollPanel");
         _selfBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.selfBtn");
         _vsBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.vsBtn");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordFrame.btnHbox");
         addToContent(_border);
         addToContent(_btnHbox);
         addToContent(_titleBack);
         addToContent(_rankText);
         addToContent(_userText);
         addToContent(_wayText);
         addToContent(_scoreText);
         addToContent(_totalScoreText);
         addToContent(_scrollPanel);
         _scrollPanel.setView(_itemBox);
         _btnHbox.addChild(_selfBtn);
         _btnHbox.addChild(_vsBtn);
         _rankText.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _userText.text = LanguageMgr.GetTranslation("CrossGuildWarAttackRecordFrame.userText.text");
         _wayText.text = LanguageMgr.GetTranslation("CrossGuildWarAttackRecordFrame.wayText.text");
         _scoreText.text = LanguageMgr.GetTranslation("assaultwar.AssaultwarRankFrame.frameTxt06");
         _totalScoreText.text = LanguageMgr.GetTranslation("CrossGuildWarAttackRecordFrame.totalScoreText.text");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_selfBtn);
         _btnGroup.addSelectItem(_vsBtn);
         _btnGroup.selectIndex = 0;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("ATTACK_RECORD_BACK",this,__fightRankBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         MsgMan.removeObserver("ATTACK_RECORD_BACK",this,__fightRankBackHandler);
      }
      
      private function __fightRankBackHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:CrossGuildWarAttackRecordItem = null;
         _itemBox.removeAllChild();
         var _loc1_:Array = _btnGroup.selectIndex == 0 ? model.myFightRecordList : model.vsFightRecordList;
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new CrossGuildWarAttackRecordItem(_loc4_ + 1);
            _loc2_.side = _btnGroup.selectIndex;
            _loc2_.data = _loc1_[_loc4_];
            _itemBox.addChild(_loc2_);
            _loc4_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
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
         this.titleText = LanguageMgr.GetTranslation("CrossGuildWarAttackRecordFrame.titleText.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_userText);
         _userText = null;
         ObjectUtils.disposeObject(_wayText);
         _wayText = null;
         ObjectUtils.disposeObject(_scoreText);
         _scoreText = null;
         ObjectUtils.disposeObject(_totalScoreText);
         _totalScoreText = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_selfBtn);
         _selfBtn = null;
         ObjectUtils.disposeObject(_vsBtn);
         _vsBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         super.dispose();
      }
   }
}

